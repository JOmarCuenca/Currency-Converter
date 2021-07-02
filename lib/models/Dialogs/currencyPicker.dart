import 'package:currency_converter/constants/constants.dart';
import 'package:currency_converter/controllers/currencyPickers.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';

Future<Map<String, Currency>?> pickCurrencyDialog(BuildContext context) {
  return showDialog(context: context, builder: (c) => CurrencyPickerView());
}

class CurrencyPickerView extends StatefulWidget {
  const CurrencyPickerView({Key? key}) : super(key: key);

  @override
  _CurrencyPickerViewState createState() => _CurrencyPickerViewState();
}

class _CurrencyPickerViewState extends State<CurrencyPickerView> {
  late CurrencyPickerController _controller;

  @override
  void initState() {
    this._controller = new CurrencyPickerController(context, this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // ignore: non_constant_identifier_names
    final SPACING = SizedBox(height: size.height / 24,);
    return Dialog(
      shape: DIALOG_STYLE,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            this._buildGD(true, this._buildCurrencyField(context, true)),
            SPACING,
            this._buildGD(false, this._buildCurrencyField(context, false)),
            SPACING,
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                  style: BUTTON_STYLE,
                  onPressed: () => Navigator.of(context)
                      .pop(this._controller.formattedValues),
                  child: Text("Add")),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencyField(BuildContext context, bool from) => Container(
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    decoration: BoxDecoration(
      border: Border.all(
        width: 2,
        color: PRIMARY_COLOR
      ),
      borderRadius: BorderRadius.circular(16)
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(from ? "From:" : "To:"),
        Container(
          child: from
              ? Text(this._controller.fromTextCurrency)
              : Text(this._controller.toTextCurrency),
        )
      ],
    ),
  );

  GestureDetector _buildGD(bool from, Widget child) => GestureDetector(
    child: child,
    onTap: () => this._controller.pickCurrency(from),
  );
}
