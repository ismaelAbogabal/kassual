import 'package:flutter/material.dart';
import 'package:kassual/bloc/user_bloc/user_bloc.dart';
import 'package:kassual/config/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  final String error;

  const LoginScreen({Key key, this.error}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool login = true;

  // TextEditingController name = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: Text("KASSUAL"), toolbarHeight: 100),
        body: buildBody(context),
      ),
    );
  }

  double height;
  buildBody(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        height ??= constraints.maxHeight;
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: height,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: buildItems(),
            ),
          ),
        );
      },
    );
  }

  Column buildItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Text(
            login ? "Login" : "Sing Up",
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        SizedBox(height: 20),
        Text(
          widget.error ?? "",
          textAlign: TextAlign.center,
          style: AppTheme.errorTextStyle,
        ),
        TextField(
          decoration: inputDecoration("Email"),
          controller: email,
        ),
        SizedBox(height: 20),
        if (!login) ...[
          TextField(
            controller: firstName,
            decoration: inputDecoration("First Name"),
          ),
          SizedBox(height: 20),
          TextField(
            controller: lastName,
            decoration: inputDecoration("Last Name"),
          ),
          SizedBox(height: 20),
        ],
        SizedBox(height: 20),
        TextField(
          obscureText: true,
          controller: password,
          decoration: inputDecoration("Password"),
        ),
        SizedBox(height: 20),
        RaisedButton(
          onPressed: login
              ? () {
                  UserBloc.of(context).add(UELogin(email.text, password.text));
                }
              : () {
                  UserBloc.of(context).add(UESignIn(
                    lastName: lastName.text,
                    firstName: firstName.text,
                    email: email.text,
                    password: password.text,
                  ));
                },
          child: Text(login ? "LOGIN" : "SIGN UP"),
          colorBrightness: Brightness.dark,
        ),
        Container(
          height: 40,
          width: double.infinity,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                !login
                    ? Container()
                    : FittedBox(
                        child: FlatButton(
                          onPressed: () {
                            launch(
                              "https://kassual.com/account/login/#recover",
                            );
                          },
                          child: Text("Forget Password"),
                        ),
                      ),
                FittedBox(
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        login = !login;
                      });
                    },
                    child: Text(
                      "${login ? "Don`t" : ""} have account ${login ? "Sign up" : "Login"}",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // double height(BuildContext context) {
  //   return MediaQuery.of(context).size.height -
  //       100 -
  //       MediaQuery.of(context).padding.top;
  // }

  inputDecoration(title) {
    return InputDecoration(
      border: OutlineInputBorder(),
      labelText: title,
    );
  }
}
