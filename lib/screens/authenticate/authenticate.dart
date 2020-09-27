import 'package:flutter/material.dart';
import 'package:snackit/screens/authenticate/register.dart';
import 'package:snackit/screens/authenticate/signin.dart';

class Authenticate extends StatefulWidget {
  Authenticate({Key key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool isSignedIn = true;

  void toggleForm (){
    setState(() {
      isSignedIn = !isSignedIn;
    });

  }
  @override
  Widget build(BuildContext context) {
    return isSignedIn ? Signin(toggleForm:toggleForm) : Register(toggleForm:toggleForm);
  }
}