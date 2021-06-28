import 'dart:convert';

import 'package:currency_picker/currency_picker.dart';

class Rate {

  double _rate;

  Currency 
    _from,
    _to;

  late DateTime _creationDate;

  static Rate fromJson(Map<String,dynamic> m){
    return new Rate(
      Currency.from(json: json.decode(m["fromTag"])),
      Currency.from(json: json.decode(m["toTag"])),
      m["rate"]
    );
  }

  Rate(this._from, this._to, this._rate, {DateTime? creationDate}){
    this._creationDate = creationDate ?? DateTime.now();
  }

  Rate get inverse => new Rate(this._to, this._from, 1 / this._rate);

  double calculate(double val) => this._rate * val;
  String roundDecimals(double val) => this.calculate(val).toStringAsFixed(this._to.decimalDigits);
  String createChangeText({required double originalVal}) => 
    "$originalVal ${this._from.namePlural} -> ${this.roundDecimals(originalVal)} ${this._to.namePlural}";

  Currency  get fromCurrency  => this._from;
  Currency  get toCurrency    => this._to;
  String    get fromFlag      => CurrencyUtils.currencyToEmoji(this.fromCurrency);
  String    get toFlag        => CurrencyUtils.currencyToEmoji(this.toCurrency);
  String    get fromCode      => this.fromCurrency.code;
  String    get toCode        => this.toCurrency.code;
  String    get id            => this.fromCode+this.toCode;
  bool      get isOld         => DateTime.now().difference(this._creationDate).inHours >= 12;
  DateTime  get creationDate  => this._creationDate;

  Map<String,dynamic> toJson() => {
    "fromTag" : json.encode(this._from.toJson()),
    "toTag"   : json.encode(this._to.toJson()),
    "rate"    : this._rate
  };

  bool equals(Rate r) => (
    (this._from.code == r._from.code && this._to.code == r._to.code)
    ||
    (this._to.code == r._from.code && this._from.code == r._to.code)
  );

  Rate updateClone(double rate) => new Rate(this._from, this._to, rate);
}