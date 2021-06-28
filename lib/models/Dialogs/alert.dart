import 'package:currency_converter/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Future<void> showMessage(BuildContext context,
    {required String message, String title = "Alert"}) {
  return showDialog(
      context: context,
      builder: (c) => AlertDialog(
            title: title,
            message: message,
          ));
}

class AlertDialog extends StatelessWidget {
  final String title, message;

  const AlertDialog({Key? key, required this.title, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: DIALOG_STYLE,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 600,
          maxHeight: MediaQuery.of(context).size.height * 1/5
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                Text(
                  title,
                  style: TITLE_TEXT_STYLE,
                ),
                Divider()
              ],
              mainAxisSize: MainAxisSize.min,
            ),
            Text(
              message,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
