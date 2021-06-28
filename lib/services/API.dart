import 'package:connectivity/connectivity.dart';
import 'package:currency_converter/constants/secrets.dart';
import 'package:currency_converter/models/Rate.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:dio/dio.dart';

import 'Singleton.dart';

class APIService extends Singleton {

  late final String _mainUrl;
  late final Dio _dio;
  final Connectivity _connectivity = Connectivity();

  static final APIService _serviceInstance = APIService._internal();

  factory APIService() => APIService._serviceInstance;

  APIService._internal(){
    super.initializer = this._init();
  }

  Future<void> _init() async {
    this._mainUrl = "http://data.fixer.io/api/latest?access_key=$API_KEY&symbols=";
    this._dio = new Dio();
  }

  Future<double> _checkRate(String from, String to) async {
    final modifiedURL = "${this._mainUrl}$from,$to";
    final result = await this._dio.get(modifiedURL);
    if(result.statusCode != 200)
      return -1;
    final resultingRates = Map<String,num>.from(result.data["rates"]).values;
    return resultingRates.last / resultingRates.first; // This should never break because there should always be only 2 values
  }

  Future<bool> connected() async => (await this._connectivity.checkConnectivity()) != ConnectivityResult.none;

  Future<Rate> getUpdatedRate(Rate r) async {
    if(!(await this.connected()))
      throw new Exception("There is no connectivity at the moment. The Updating operation for ${r.id} at ${DateTime.now().toIso8601String()} has been cancelled.");
    return r.updateClone(await this._checkRate(r.fromCode, r.toCode));
  }

  Future<Rate> createRate(Currency f, Currency t) async => new Rate(f, t, await this._checkRate(f.code, t.code));
}