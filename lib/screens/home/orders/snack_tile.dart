import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:snackit/models/snack.dart';

class SnackTile extends StatelessWidget {
  final Snack snack;
  SnackTile({this.snack});

  var user =  FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(15.0, 6.0, 15.0, 0.0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 6.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30.0,
              backgroundImage: AssetImage(snack.prof),
            ),
            title: Container(
                child: Text(
                    snack.name.toUpperCase(),
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700]
                  ),
                ),
              margin: EdgeInsets.only(top:20.0),
            ),
            subtitle: Row(
              children: [
                Row(
                  children: [
                    SizedBox(height: 45.0,),
                    Container(
                      child: Icon(
                        Icons.local_drink,
                        size: 18.0,
                      ),
                    ),
                    SizedBox(width: 5.0,),
                    Text(snack.drink),
                  ],
                ),
                SizedBox(width: 10.0,),
                Row(
                  children: [
                    Container(
                      child: Icon(
                        Icons.fastfood,
                        size: 18.0,
                      ),
                    ),
                    SizedBox(width: 5.0,),
                    Text(snack.pastry),
                  ],
                ),
                SizedBox(width: 10.0,),
                Row(
                  children: [
                    Container(
                      child: Icon(
                        Icons.local_cafe,
                        size: 18.0,
                      ),
                    ),
                    SizedBox(width: 5.0,),
                    Text(snack.other),
                  ],
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}
