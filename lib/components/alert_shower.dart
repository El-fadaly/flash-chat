import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AlertShower {
  static void showAlert(
      String errorTitle, String missing, BuildContext context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: errorTitle,
      desc: "Please provide a $missing",
      buttons: [
        DialogButton(
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(179, 0, 0, 1.0),
        ),
        DialogButton(
          child: Text(
            "enter $missing",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {},
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }
}
