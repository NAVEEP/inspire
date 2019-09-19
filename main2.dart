import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'main_screen.dart' as ms;
import 'package:shared_preferences/shared_preferences.dart';

String uid;
String uname;
String photo;

void main() {
  runApp(
    MaterialApp(
      home: LoginPage(),
    ),
  );
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoggedIn;
  var profileData;
  PageController pageController = PageController();
  List<Widget> lc1 = [], lc2 = [], lc3 = [], lc4 = [], lc5 = [];

  @override
  void initState() {
    isLoggedIn = false;
    profileData = null;
    uid = null;
    uname = null;
    photo = null;
    print(isLoggedIn);
check();
    super.initState();
    // check();
    // initiateFacebookLogin();
  }

  var facebookLogin = FacebookLogin();

  void onLoginStatusChanged(bool isLoggedIn, {profileData}) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
      this.profileData = profileData;
    });
  }

  int pgn = 0;
  @override
  Widget build(BuildContext context) {
  

    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Center(
            child: isLoggedIn
                ? _displayUserData(profileData)
                : _displayLoginButton(profileData),
          ),
        ),
      ),
    );}
//     if(isLoggedIn){return Scaffold(body:_displayUserData(profileData));}
// else {return Scaffold(body: _displayLoginButton(profileData),);}  }

  void initiateFacebookLogin() async {
    print("inside initiate facebook login");
    var facebookLoginResult =
        await facebookLogin.logInWithReadPermissions(['email']);
    //print(facebookLoginResult);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
        var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${facebookLoginResult.accessToken.token}');

        var profile = json.decode(graphResponse.body);
        print(profile.toString());
        // print(profile['id']);
        DocumentReference ref =
            Firestore.instance.collection('USER').document(profile['id']);
        ref.setData({
          'uid': profile['id'],
          'email': profile['email'],
          'photoURL': profile['picture']['data']['url'],
          'uName': profile['name'],
          //'lastSeen': DateTime.now()
        }, merge: true);
        save(
          profile['id'],
          profile['name'],
          profile['picture']['data']['url'],
        );

        onLoginStatusChanged(true, profileData: profile);
        break;
    }
    uid = profileData['id'];
    uname = profileData['name'];
    photo = profileData['picture']['data']['url'];
  }

  _displayUserData(profileData) {
    
    return ms.TabsDemoScreen();
  }

  _displayLoginButton(profile) {
    /* return RaisedButton(
            child: Text("Login with Facebook"),
            onPressed: () {
              initiateFacebookLogin();
            }); */
    return Container(
      
      // height: 1000.0,
      child: PageView(
        
          onPageChanged: (int inr) {},
          controller: pageController,
          children: <Widget>[
            Stack(children: <Widget>[
            Column(
              
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset('assets/log.png',
                    height: MediaQuery.of(context).size.height / 1.1,
                    width: double.infinity),
                Container(
                  color: Colors.grey[600],
                  margin: EdgeInsets.all(6.0),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).size.height / 1.1-12,
                  child: RaisedButton(
                    
                      color: Color(0xffe73131),
                      child: Text("Get Started",style: TextStyle(color: Colors.white,fontSize: 20.0),),
                      onPressed: () {
                        // initiateFacebookLogin();

                        
                        pageController.jumpToPage(1);
                      }),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/6,MediaQuery.of(context).size.height/4,0.0,0.0),
              child: Text("inspire",textScaleFactor: 6.0,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
            )
            ],),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/log1.png',
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/log2.png',
                  ),
                  Container(),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/log3.png',
                  ),
                  Container(),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/log4.png',
                    height: MediaQuery.of(context).size.height / 1.1,
                  ),
                  Container(
                    margin: EdgeInsets.all(6.0),
                    height: 50.0,
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                        color: Color(0xffe73131),
                        child: Text("Login with Facebook",style: TextStyle(color: Colors.white,fontSize: 18.0),),
                        onPressed: () {
                          initiateFacebookLogin();
                          // pageController.jumpToPage(1);
                        }),
                  ),
                ],
              ),
            ),
          ]),
    );
  }

  _logout() async {
    await facebookLogin.logOut();
    onLoginStatusChanged(false);
    print("Logged out");
  }

  void check() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'exist';
    final value = prefs.getBool(key) ?? false;
    print('read: $value');
    if (value) {
      setState(() {
        print('check true');
        uid = prefs.getString("uid");
        uname = prefs.getString("uname");
        photo = prefs.getString("photo");
        print(uid ?? 'shit');
        isLoggedIn = true;
      });
    } else {
      print('check false');
      isLoggedIn=false;
    }
  }

  save(String a, String b, String c) async {
    print("profile saved");
    final prefs = await SharedPreferences.getInstance();

    prefs.setBool("exist", true);
    prefs.setString("uid", a);
    prefs.setString("uname", b);
    prefs.setString("photo", c);
    print('saved ');
  }
}
