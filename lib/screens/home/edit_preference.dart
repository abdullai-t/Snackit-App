import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snackit/models/snack.dart';
import 'package:snackit/services/database.dart';
import 'package:snackit/shared/konstants.dart';
import 'package:snackit/shared/loader.dart';

class EditPreference extends StatefulWidget {
  @override
  _EditPreferenceState createState() => _EditPreferenceState();
}

class _EditPreferenceState extends State<EditPreference> {
  final _formKey = GlobalKey<FormState>();

  String _drink;
  String _other;
  String _pastry;

  final List<String> drinks = ["Coke", "fanta", "Sobolo", "yougot", "sprit", "malt"];
  final List<String>pastries = ["Meat Bread", "meat Pie", "Biscuit", "Chibs"];
  final List<String>others = ["Gum", "water", ];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserPref>(
      stream: DatabaseService(uid:user.uid).userPref,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserPref userPref = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  "Update Snack Preference",
                  style:TextStyle(
                      fontSize: 18.0
                  ),
                ),
                SizedBox(height: 30,),

                DropdownButtonFormField <String>(
                  decoration: textInputDecoration,
                  hint: Text("choose drink"),
                  value: _drink  ,
                  items:  drinks.map((drink){
                    return DropdownMenuItem(
                      value: drink,
                      child: Text(drink),
                    );
                  }).toList(),
                  onChanged: (value)=>setState(() => _drink=value),
                ),
                SizedBox(height: 15.0,),
                DropdownButtonFormField <String>(
                  decoration: textInputDecoration,
                  hint: Text("choose pastry"),
                  value: _pastry  ,
                  items: pastries.map((pastry){
                    return DropdownMenuItem(
                      value: pastry,
                      child: Text(pastry),
                    );
                  }).toList(),
                  onChanged: (value)=>setState(() => _pastry=value),
                ),
                SizedBox(height: 15.0,),

                DropdownButtonFormField <String>(
                  decoration: textInputDecoration,
                  hint: Text("choose other"),
                  value: _other,
                  items: others.map((other){
                    return DropdownMenuItem(
                      value: other,
                      child: Text(other),
                    );
                  }).toList(),
                  onChanged: (value)=>setState(() => _other=value),
                ),
                SizedBox(height: 30.0,),
                RaisedButton(
                  color: Colors.brown[400],
                  onPressed: () async{
                    if (_formKey.currentState.validate()){
                      await DatabaseService(uid:user.uid).updateUserData(
                          user.displayName,
                          _pastry ?? userPref.pastry,
                          _drink ?? userPref.drink,
                          _other ?? userPref.other
                      );
                      Navigator.pop(context);
                    }

                  },
                  child: Text(
                      'Update Preference',
                      style: TextStyle(
                          fontSize: 16.0,
                          color:Colors.white
                      )
                  ),
                ),
              ],
            ),
          );
        }
        else{
          return Loader();
        }

      }
    );
  }
}