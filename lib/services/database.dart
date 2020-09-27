import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:snackit/models/snack.dart';

class DatabaseService{
  final String uid;

  DatabaseService({this.uid});
  final CollectionReference snackCollection = FirebaseFirestore.instance.collection("snacks");

  Future updateUserData (String name,String pastry,String drink, String other) async {
    return await snackCollection.doc(uid).set({
      "name":name,
      "pastry":pastry,
      "other":other,
      "drink":drink,
      "prof":""
    });
  }
  Future updateUsername (String name ) async {
    return await snackCollection.doc(uid).update({
      "name":name,
    });
  }
  Future UpdateUserImage (String image ) async {
    return await snackCollection.doc(uid).update({
      "prof":image,
    });
  }

  List<Snack> _snackListFromSnapshot (QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Snack(
       name: doc.data()["name"] ?? "",
        prof: doc.data()["prof"] ?? "",
        pastry:doc.data()["pastry"] ?? "",
        other:doc.data()["other"] ?? "",
        drink: doc.data()["drink"] ?? "",
      );
    }).toList();
  }

  UserPref _userPrefFromSnapShot (DocumentSnapshot snapshot){
    return UserPref(
      uid:uid,
      pastry:snapshot.data()["pastry"] ?? "",
      other:snapshot.data()["other"] ?? "",
      drink: snapshot.data()["drink"] ?? "",
    );
  }

//  Stream of user snacks
  Stream<List<Snack>> get snacks{
    return snackCollection.snapshots().map(_snackListFromSnapshot);
  }

//  user pref stream
 Stream<UserPref> get userPref{
    return snackCollection.doc(uid).snapshots()
        .map(_userPrefFromSnapShot);
 }

//  add snacks

//update snack
}