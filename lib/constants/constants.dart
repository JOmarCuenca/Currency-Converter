import 'package:flutter/material.dart';

const CurrencyCodes = ["mxn", "usd", "jpy"];
const PRIMARY_COLOR = Color.fromRGBO(244, 85, 37, .8);

enum ExceptionCodes {
  ServerError,
  TimeoutError
}

const Map<String, dynamic> Mexican_peso = {
  "code": "MXN",
  "name": "Mexico Peso",
  "symbol": "\$",
  "number": 484,
  "flag": "MXN",
  "decimal_digits": 2,
  "name_plural": "Mexican pesos",
  "symbol_on_left": true,
  "decimal_separator": ".",
  "thousands_separator": ",",
  "space_between_amount_and_symbol": false
};

const Map<String, dynamic> US_dollar = {
  "code": "USD",
  "name": "United States Dollar",
  "symbol": "\$",
  "number": 840,
  "flag": "USD",
  "decimal_digits": 2,
  "name_plural": "US dollars",
  "symbol_on_left": true,
  "decimal_separator": ".",
  "thousands_separator": ",",
  "space_between_amount_and_symbol": false
};

const TITLE_TEXT_STYLE = TextStyle(fontWeight: FontWeight.w600, fontSize: 24);

// ignore: non_constant_identifier_names
final DIALOG_STYLE =
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(24));

// ignore: non_constant_identifier_names
final BUTTON_STYLE = ElevatedButton.styleFrom(
    primary: PRIMARY_COLOR,
    padding: EdgeInsets.all(10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ));
