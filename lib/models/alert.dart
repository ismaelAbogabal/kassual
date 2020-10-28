import 'package:flutter/material.dart';

class AlertModel {
  static Future<bool> confirm({
    BuildContext context,
    String title,
    String body,
  }) async {
    bool val = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title ?? ""),
          content: Text(body ?? ""),
          actions: [
            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            RaisedButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text("Ok"),
              colorBrightness: Brightness.dark,
            ),
          ],
        );
      },
    );
    return val == true;
  }
}
