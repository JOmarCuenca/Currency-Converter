import 'package:currency_converter/controllers/currencyPickers.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';

Future<Map<String,Currency>?> pickCurrencyDialog(BuildContext context){
  return showDialog(
    context: context, 
    builder: (c) => CurrencyPickerView()
  );
}

class CurrencyPickerView extends StatefulWidget {
  const CurrencyPickerView({ Key? key }) : super(key: key);

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
    return Dialog(    
      backgroundColor: Colors.transparent,  
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 22/50
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.blueGrey.withOpacity(0.8)
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              this._buildGD(
                true, 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("From:"),
                    Container(
                      child: Text(this._controller.fromTextCurrency),
                    )
                  ],
                )
              ),
              this._buildGD(
                false, 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("To:"),
                    Container(
                      child: Text(this._controller.toTextCurrency),
                    )
                  ],
                )
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(this._controller.formattedValues),
                  child: Text("Add")
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector _buildGD(bool from, Widget child) => GestureDetector(
    child: child,
    onTap: () => this._controller.pickCurrency(from),
  );
}