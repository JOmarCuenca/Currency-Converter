import 'package:currency_converter/constants/constants.dart';
import 'package:flutter/material.dart';

Future<bool?> showDecisionDialog(BuildContext context, {required String body, String title = "Are you sure?", String noMessage = "No", String yesMessage = "Yes"}){
  return showDialog(
    context: context, 
    builder: (c) => DecisionDialog(
      body: body,
      title: title,
      noMessage: noMessage,
      yesMessage: yesMessage,
    )
  );
}

class DecisionDialog extends StatelessWidget {

  final String title,
  body,
  noMessage,
  yesMessage;

  const DecisionDialog({ 
    Key? key,
    required this.title,
    required this.body,
    required this.noMessage,
    required this.yesMessage
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: DIALOG_STYLE,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title,
              style: TITLE_TEXT_STYLE
            ),
            SizedBox(height: 20,),
            Text(body,
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                this._buildBtn(context, noMessage, false),
                this._buildBtn(context, yesMessage, true)
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBtn(BuildContext context, String text, bool result) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: Color.fromRGBO(244, 85, 37, .8),
      padding: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        // side: BorderSide(color: Colors.red)
      )
    ),
    onPressed: () => Navigator.of(context).pop(result), 
    child: Text(text,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16
      ),
    )
  );
}