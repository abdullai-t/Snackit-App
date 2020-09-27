import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:snackit/services/auth_service.dart';
import 'package:snackit/shared/konstants.dart';
import 'package:snackit/shared/loader.dart';

class Signin extends StatefulWidget {
  final Function toggleForm;
  Signin({this.toggleForm});
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLoading = false;
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {

    return isLoading ? Loader() :Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.brown[200],
      appBar: AppBar(
        backgroundColor: Colors.brown[600],
        title: Text(
          "Sign In to Snackit",
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
                    child: Icon(
                      Icons.person_add,
                      size: 26.0,
                    ),
                    onTap: ()=> widget.toggleForm(),
                  ),
                  SizedBox(width: 6.0,),
                  Text("Join" , style: TextStyle(fontSize: 17.0),),
                ],
              )
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20.0, 100, 20.0, 10.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20.0,),
                //email
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: "Email"),
                  validator: (value){
                    // ignore: missing_return
                    return  value.isEmpty || !value.contains("@") ? "email must be valid" :null;
                  },
                  onChanged: (value)=>setState(() => _email=value),
                ),
                SizedBox(height: 20.0,),
                //password
                TextFormField(
                  validator: (value){// ignore: missing_return
                  return  value.length <6 ? "password must be at least 6 characters long" :null;
                  },
                  obscureText: true,
                  decoration: textInputDecoration.copyWith(hintText: "password"),
                  onChanged: (value)=>setState(() => _password=value),
                ),
                SizedBox(height: 30.0,),
                FlatButton(
                  color: Colors.brown[400],
                  onPressed: () async{
                    if (_formKey.currentState.validate()){
                      setState(() {
                        isLoading = true;
                      });
                      dynamic user =  await _auth.signIn(_email, _password);
                      if(user!=null){
                        setState(() {
                          isLoading = false;
                        });
                      }

                    }
                  },
                  child: Text('Log in',style: TextStyle(fontSize: 16.0, color:Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
}