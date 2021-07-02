import 'package:currency_converter/controllers/ViewController.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';

class CurrencyPickerController extends ViewController {

  static const String GENERIC_TEXT = "Pick a currency";

  Currency? _from, _to;

  CurrencyPickerController(BuildContext context, State<StatefulWidget> view) : super(context, view);

  @override
  Future<void> init() async {
    return null;
  }

  void pickCurrency(bool from) {
    return showCurrencyPicker(context: context, onSelect: (c) {
      if(from)
        this._from = c;
      else
        this._to = c;
      this.updateState();
    });
  }

  String _constructCurrText(Currency c) => "${CurrencyUtils.currencyToEmoji(c)} ${c.name}";

  String get fromTextCurrency {
    if(this._from == null){
      return GENERIC_TEXT;
    }
    return this._constructCurrText(this._from!);
  }

  String get toTextCurrency {
    if(this._to == null){
      return GENERIC_TEXT;
    }
    return this._constructCurrText(this._to!);
  }

  Map<String,Currency>? get formattedValues {
    if(this._from != null && this._to != null)
      return {
        "from"  : this._from!,
        "to"    : this._to!
      };
    return null;
  }

}