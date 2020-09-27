import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:snackit/models/user.dart';
import 'package:snackit/services/database.dart';

class AuthServices{

 final FirebaseAuth _auth = FirebaseAuth.instance;
 //auth change stream
 StreamSubscription<User> get user {
  return _auth.authStateChanges().listen((User user){
     user != null ? CustomUser(uid:user.uid) : null;
   });
 }

 Future updateUserProfile (String username, String image) async{
   return await _auth.currentUser.updateProfile(
     displayName: username,
     photoURL: image,
   );
 }
 Future register (String email, String password,String username) async{
   try {
     UserCredential user = await _auth.createUserWithEmailAndPassword(
         email: email,
         password: password,
     );
     await _auth.currentUser.updateProfile(displayName:username, photoURL: 'imgs/profile.jpg');
     return user.user;
   } on FirebaseAuthException catch (e) {
     return e.code;
   } catch (e) {
     return null;
   }


 }

 Future signIn (String email, String password) async{
   try{
     UserCredential user = await _auth.signInWithEmailAndPassword(
       email: email,
       password: password,
     );
     return user.user;
   }
   on FirebaseAuthException catch (e) {
    return e;
   }
 }

 Future logOut () async{
   await _auth.signOut();
 }

}