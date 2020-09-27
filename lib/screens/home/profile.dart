import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snackit/services/auth_service.dart';
import 'package:snackit/services/database.dart';
import 'package:snackit/shared/konstants.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File _image;
  String _username;
  final picker = ImagePicker();
  var user =  FirebaseAuth.instance.currentUser;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }

    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    String profile = user.photoURL;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 20,),
          Center(
            child: Row(
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: _image == null ?
                      AssetImage(profile):
                      AssetImage(
                       _image.path,
                      ) ,
                      radius: 50.0,
                    ),
                    SizedBox(height: 10.0,),
                    Text(
                      user.displayName,
                      style:TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                FlatButton(
                  onPressed: getImage,
                  child: Icon(Icons.add_a_photo),
                ),
              ],
            )
          ),
          SizedBox(height: 30,),
          TextFormField(
            initialValue: user.displayName,
            decoration: textInputDecoration.copyWith(hintText: "Username"),
            validator: (value){
              return  value.isEmpty ? "Enter username" :null;
            },
            onChanged: (value)=>setState(() => _username=value),
          ),
          SizedBox(height: 30.0,),
          RaisedButton(
            color: Colors.brown[400],
            onPressed: () async{
              if (_formKey.currentState.validate()){
                AuthServices().updateUserProfile(_username, _image.path ?? profile);
                DatabaseService(uid: user.uid).updateUsername(_username);
                DatabaseService(uid: user.uid).UpdateUserImage(_image.path ?? profile);
                Navigator.pop(context);
              }
            },
            child: Text(
                'Update info',
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
}