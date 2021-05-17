import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/alert_shower.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../components/rounded_button.dart';
import '../constants.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;

  String _email, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                _email = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter Your E-mail',
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              obscureText: true,
              onChanged: (value) {
                _password = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter Your Password',
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(
                color: Colors.lightBlueAccent,
                buttonText: 'Log In',
                onPressed: () async {
                  if (_email != null && _password != null) {
                    EasyLoading.show();
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: _email, password: _password);

                      if (user != null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                        EasyLoading.dismiss();
                      }
                    } catch (e) {
                      print(e);
                      EasyLoading.dismiss();
                    }
                  } else if (_email == null && _password == null) {
                    AlertShower.showAlert('missing Email and passwaord',
                        'email and password', context);
                  } else if (_email == null) {
                    AlertShower.showAlert('missing Email ', 'email', context);
                  } else if (_password == null) {
                    AlertShower.showAlert(
                        'missing passwaord', 'password', context);
                  } else if (_password.length < 6) {
                    AlertShower.showAlert('Insuitable Password',
                        'a 6 character password', context);
                  }
                }),
          ],
        ),
      ),
    );
  }
}
