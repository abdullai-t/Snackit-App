import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:snackit/models/pop_menu.dart';
import 'package:snackit/models/snack.dart';
import 'package:snackit/screens/home/edit_preference.dart';
import 'package:snackit/screens/home/orders/snack_list.dart';
import 'package:snackit/screens/home/profile.dart';
import 'package:snackit/services/auth_service.dart';
import 'package:snackit/services/database.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthServices _auth = AuthServices();
String _selectedChoice;
  List choices = [
     PopupMenu(title: 'Preference', icon: Icons.edit),
     PopupMenu(title: 'profile', icon: Icons.settings),
     PopupMenu(title: 'Logout', icon: Icons.exit_to_app),
  ];


  @override
  Widget build(BuildContext context) {
    void showEditForm(){
      showModalBottomSheet(
          context: context,
          builder: (context){
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
              child: EditPreference(),
            );
          });
    }
    void showProfile(){
      showModalBottomSheet(
          context: context,
          builder: (context){
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
              child:Profile(),
            );
          });
    }
    void _select(choice) {
      setState(() {
        _selectedChoice = choice;
      });
      if (_selectedChoice == 'Preference' ){
        showEditForm();
      }
     else if (_selectedChoice == 'profile' ){
        showProfile();
      }
      else if (_selectedChoice == 'Logout' ){
        _auth.logOut();
      }
    }

    return StreamProvider<List<Snack>>.value(
      value: DatabaseService().snacks,
      child: Scaffold(
        backgroundColor: Colors.brown[200],
        appBar: AppBar(
          backgroundColor: Colors.brown[600],
          // centerTitle: true,
          title: Text(
            "Snackit",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
          actions: [
            PopupMenuButton(
              offset: Offset(0,100),
              elevation: 3.2,
              initialValue: 1,
              onSelected: _select,
              onCanceled: () {
                print('You have not chossed anything');
              },
              tooltip: 'This is tooltip',
              itemBuilder: (BuildContext context) {
                return choices.map((choice) {
                  return PopupMenuItem(
                    value: choice.title,
                    child:
                    Container(
                        child: Text(choice.title)
                    ),
                  );
                }).toList();
              },
            )
          ],
        ),
        body: SnackList(),
      ),
    );
  }
}