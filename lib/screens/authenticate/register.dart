import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:snackit/services/auth_service.dart';
import 'package:snackit/services/database.dart';
import 'package:snackit/shared/konstants.dart';
import 'package:snackit/shared/loader.dart';

class Register extends StatefulWidget {
  final Function toggleForm;
  Register({this.toggleForm});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLoading = false;
  String _email;
  String _password;
  String _username;

  void registerUser() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      dynamic user = await _auth.register(_email, _password, _username);

      if (user) {
        await DatabaseService()
            .updateUserData(_username, "pastry", "drink", "other");
        setState(() {
          isLoading = false;
          final snack = SnackBar(
            content: Text("This is Snackbar Example"),
            duration: Duration(seconds: 15),
            backgroundColor: Colors.green,
          );
          _scaffoldKey.currentState.showSnackBar(snack);
        });
      } else if (user.code == 'weak-password') {
        setState(() {
          isLoading = false;
        });
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("unable to register"),
        ));
      } else if (user.code == 'email-already-in-use') {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loader()
        : Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.brown[200],
            appBar: AppBar(
              backgroundColor: Colors.brown[600],
              title: Text(
                "sign up to Snackit",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              actions: [
                Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => widget.toggleForm(),
                          child: Icon(
                            Icons.person,
                            size: 26.0,
                          ),
                        ),
                        SizedBox(
                          width: 6.0,
                        ),
                        Text(
                          "Sign in",
                          style: TextStyle(fontSize: 17.0),
                        ),
                      ],
                    ))
              ],
            ),
            body: Container(
              padding: EdgeInsets.fromLTRB(20.0, 100, 20.0, 10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    //username
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: "Username"),
                      validator: (value) {
                        return value.isEmpty ? "Enter username" : null;
                      },
                      onChanged: (value) => setState(() => _username = value),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    //email
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: "Email"),
                      validator: (value) {
                        return value.isEmpty || !value.contains("@")
                            ? "email must be valid"
                            : null;
                      },
                      onChanged: (value) => setState(() => _email = value),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    //password
                    TextFormField(
                      validator: (value) {
                        // ignore: missing_return
                        return value.length < 6
                            ? "password must be at least 6 characters long"
                            : null;
                      },
                      obscureText: true,
                      decoration:
                          textInputDecoration.copyWith(hintText: "password"),
                      onChanged: (value) => setState(() => _password = value),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    FlatButton(
                      color: Colors.brown[400],
                      onPressed: () {
                        registerUser();
                      },
                      child: Text('Register',
                          style:
                              TextStyle(fontSize: 16.0, color: Colors.white)),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
