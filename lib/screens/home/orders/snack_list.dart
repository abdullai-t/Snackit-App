import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snackit/models/snack.dart';
import 'package:snackit/screens/home/orders/snack_tile.dart';

class SnackList extends StatefulWidget {


  @override
  _SnackListState createState() => _SnackListState();
}

class _SnackListState extends State<SnackList> {
  @override
  Widget build(BuildContext context) {
    final snacks = Provider.of<List<Snack>>(context);

    return ListView.builder(
      itemCount: snacks.length ?? 1,
      itemBuilder: (context,index){
        return SnackTile(snack:snacks[index]);
      },
    );
  }
}