import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'main.dart' as main;
import 'package:flutter/material.dart';
import 'main_screen.dart' as ms;

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  Observable<FirebaseUser> user; // firebase user
  Observable<Map<String, dynamic>> profile; // custom user data in Firestore
  PublishSubject loading = PublishSubject();

  // constructor
  AuthService() {
    user = Observable(_auth.onAuthStateChanged);

    profile = user.switchMap((FirebaseUser u) {
      if (u != null) {
        return _db
            .collection('users')
            .document(u.uid)
            .snapshots()
            .map((snap) => snap.data);
      } else {
        return Observable.just({});
      }
    });
  }

  Future<FirebaseUser> googleSignIn(con) async {

    print("inside auth service");
    
    //  loading.add(true);
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
     updateUserData(user);
      print("user name: ${user.displayName}");
      final prefs = await SharedPreferences.getInstance();

    prefs.setBool("exist", true);
    prefs.setString("uid", user.uid);
    prefs.setString("uname", user.displayName);
    prefs.setString("photo", user.photoUrl);

        
         
       //break;
    
    main.uid = user.uid;
    main.uname =user.displayName;
    main.photo = user.photoUrl;

    Navigator.pushReplacement(
                              con,
                              MaterialPageRoute(builder: (context) {
                                // return ms.MyHomePage();
                                return ms.TabsDemoScreen();
                              }),
                            );



       loading.add(false);
      return user;
    // }
    //  catch (error) {
    //   return error;
    // }

  }

  void updateUserData(FirebaseUser user) async {
    DocumentReference ref = _db.collection('USER').document(user.uid);

     ref.setData({
        'bnum': 0,
          'ins': 0,
          'mnum': 0,
          'unum': 0,
          'urating': 0,
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoUrl,
      'uName': user.displayName,
     // 'lastSeen': DateTime.now()
    }, merge: true);
  }

  Future<String> signOut() async {
    try {
      await _auth.signOut();
      return 'SignOut';
    } catch (e) {
      return e.toString();
    }
  }

}

// TODO refactor global to InheritedWidget
final AuthService authService = AuthService();