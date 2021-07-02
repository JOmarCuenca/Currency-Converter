import 'dart:developer';

import 'package:currency_converter/constants/constants.dart';
import 'package:currency_converter/controllers/ViewController.dart';
import 'package:currency_converter/models/Dialogs/alert.dart';
import 'package:currency_converter/models/Dialogs/currencyPicker.dart';
import 'package:currency_converter/models/Dialogs/decision.dart';
import 'package:currency_converter/models/Rate.dart';
import 'package:currency_converter/services/API.dart';
import 'package:currency_converter/services/DatabaseService.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeController extends ViewController {

  TextEditingController _editingController = new TextEditingController();
  DatabaseService _db = DatabaseService();
  APIService _api = APIService();

  List<Rate> _rates     = [];
  List<Rate> _fullRates = [];
  List<String> values   = [];
  bool _saving = false;

  HomeController(BuildContext context, State view) : super(context, view);

  TextEditingController get textController => this._editingController;

  @override
  Future<void> init() async {
    this._rates = await this._db.getRates();
    this.calculate();
    this._updateRates();
  }

  List<Rate> get allRates => this._fullRates;

  void calculate(){
    this._fullRates = [];
    this._rates.forEach((element) {
      this._fullRates.addAll([
        element,
        element.inverse
      ]);
    });
    double? val = double.tryParse(this._editingController.text);
    this.values = this._fullRates.map((e) => e.createChangeText(originalVal: val ?? 0)).toList();
    this.updateState();
  }

  void _saveRates(){
    if(!this._saving){
      this._saving = true;
      this._db.saveRates(this._rates)
      .then((value) {
        this._saving = false;
      });
    }
  }

  void _addRate(Currency f, Currency t) async {
    final newRate = Rate(f, t, 1);
    if(!this._rates.any((element) => element.equals(newRate))){
      try{
        this._rates.add(await this._api.getUpdatedRate(newRate));
      } catch(e){
        if(e == ExceptionCodes.ServerError)
          showMessage(context, message: "Request was denied by the service, please try again later");
        else
          showMessage(context, message: "Please make sure you are connected to a strong network before using the service.");
        // showMessage(context, message: e.toString());
        if(kDebugMode) log(e.toString());
      }
      this.calculate();
      this._saveRates();
    }
  }

  void addRateBtn() async {
    final result = await pickCurrencyDialog(context);
    if(result != null){
      this._addRate(result["from"]!, result["to"]!);
    }
  }

  void _deleteRate(Rate r){
    if(!this._saving){
      this._saving = true;
      this._rates.removeWhere((element) => element.equals(r));
      this.calculate();
      this._db.deleteRates(r)
      .then((value) => this._saving = false);
    }
  }

  void deleteRateBtn(Rate r) async {
    final result = await showDecisionDialog(context,
    body: "Do you wish to delete this Currency Rate?");
    if(result != null && result)
      this._deleteRate(r);
  }

  Future<void> _updateRates() async {
    for(int i = 0; i < this._rates.length; i++){
      if(this._rates[i].isOld){
        try{
          this._rates[i] = await this._api.getUpdatedRate(this._rates[i]);
        } catch(e){
          if(kDebugMode) log(e.toString());
        }
      }
    }
  }
}