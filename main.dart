import 'dart:convert';
import 'auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'main_screen.dart' as ms;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'notif-handler.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'onboarding.dart' as on;
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:camera/camera.dart';


bool c3=false;
bool c1=false;
bool c0=false;
bool stats=false;
bool profile=false;
List<CameraDescription> cameras;


String uid;
String uname;
String photo;
double width = 300;
double height = 300;


 man() async {
  // Fetch the available cameras before initializing the app.

    
 
}
void main() {

 FirebaseAnalytics analytics = new FirebaseAnalytics();
 FirebaseAnalyticsObserver observer =
      new FirebaseAnalyticsObserver(analytics: analytics);

  man();
  runApp(
    MaterialApp(
     navigatorObservers: <NavigatorObserver>[observer],
      home: LoginPage(analytics:analytics,observer:observer),
    ),
  );
}

class LoginPage extends StatefulWidget {

FirebaseAnalytics analytics;
FirebaseAnalyticsObserver observer;

LoginPage({this.analytics,this.observer});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  FirebaseAnalytics analytics;
FirebaseAnalyticsObserver observer;

_LoginPageState({this.analytics,this.observer});


  bool isLoggedIn;
  var profileData;
  PageController pageController = PageController();
  List<Widget> lc1 = [], lc2 = [], lc3 = [], lc4 = [], lc5 = [];
  Map<String, dynamic> _profile;
  bool _loading = false;


 

  @override
  void initState() {
    isLoggedIn = false;
    profileData = null;
    uid = null;
    uname = null;
    photo = null;
    print(isLoggedIn);
    FirebaseNotifications().setUpFirebase();
    authService.profile.listen((state) => setState(() => _profile = state));

    authService.loading.listen((state) => setState(() => _loading = state));
    // check();
    super.initState();
    
    check();
    // initiateFacebookLogin();
  }

  var facebookLogin = FacebookLogin();
  //var googleSignIn = GoogleSignIn();
  void onLoginStatusChanged(bool isLoggedIn, {profileData}) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
      this.profileData = profileData;
    });
  }

  int pgn = 0;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: userI(),
        ),
      ),
    );
  }

  // void initGoogleLogin() async {
  //   authService.googleSignIn();
  //   DocumentReference ref =
  //       Firestore.instance.collection('USER').document(googleAccount.id);
  //   ref.setData({
  //     'bnum': 0,
  //     'ins': 0,
  //     'mnum': 0,
  //     'unum': 0,
  //     'urating': 0,
  //     'uid': googleAccount.id,
  //     'email': googleAccount.email,
  //     'photoURL': googleAccount.photoUrl,
  //     'uName': googleAccount.displayName,
  //     //'lastSeen': DateTime.now()
  //   }, merge: true);
  //   print("2");
  //   save(
  //     googleAccount.id,
  //     googleAccount.displayName,
  //     googleAccount.photoUrl,
  //   );
  //   print("3");
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(builder: (context) {
  //       return ms.TabsDemoScreen();
  //     }),
  //   );

  //   print("4");
  //   uid = googleAccount.id;
  //   uname = googleAccount.displayName;
  //   photo = googleAccount.photoUrl;
  // }

  void initiateGoogleLogin() async{

    FirebaseUser user=await authService.googleSignIn();
    DocumentReference ref =
            Firestore.instance.collection('USER').document(user.uid);
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
          //'lastSeen': DateTime.now()
        }, merge: true);
        save(
          user.uid,
          user.displayName,
          user.photoUrl,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            // return ms.MyHomePage();
            return ms.TabsDemoScreen(analytics: analytics,observer: observer);
          }),
        );

              uid=user.uid;
              uname=user.displayName;
              photo=user.photoUrl;

  }

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
          'bnum': 0,
          'ins': 0,
          'mnum': 0,
          'unum': 0,
          'urating': 0,
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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            // return ms.MyHomePage();
            return ms.TabsDemoScreen(analytics: analytics,observer: observer);
          }),
        );
        break;
    }
    uid = profileData['id'];
    uname = profileData['name'];
    photo = profileData['picture']['data']['url'];
  }

  userI() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(width / 3, 80, width / 3, 0),
          child: Text("Inspire",
              style: TextStyle(fontSize: 30, color: Colors.grey[600])),
        ),
        Container(
          height: height / 2+50,
          child: PageView(
              onPageChanged: (int inr) {
                setState(() {
                  pgn = inr;
                });
              },
              controller: pageController,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 80),
                    Center(child:SizedBox(
                      height: height / 3.5,
                      child: Image.asset("assets/ill4.png"),
                    ),),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          child:
                              Text("Grow every moment", style: TextStyle(fontSize: 25)),
                          padding:EdgeInsets.fromLTRB(20,15,0,0),
                        ),
                        Padding(padding:EdgeInsets.fromLTRB(20,5,0,0),
                        child:Text("through challenges",style:TextStyle(fontSize:20,color:Colors.grey[600]))
                        ),

                      ],
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 80),
                    Center(child:SizedBox(
                      height: height / 3.5,
                      child: Image.asset("assets/ill1.png"),
                    ),),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          child:
                              Text("Do things", style: TextStyle(fontSize: 25)),
                          padding:EdgeInsets.fromLTRB(20,15,0,0),
                        ),
                        Padding(padding:EdgeInsets.fromLTRB(20,5,0,0),
                        child:Text("that matter to you",style:TextStyle(fontSize:20,color:Colors.grey[600]))
                        ),

                      ],
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 80),
                    Center(child:SizedBox(
                      height: height / 3.5,
                      child: Image.asset("assets/ill2.png"),
                    ),),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          child:
                              Text("Connect with people", style: TextStyle(fontSize: 25)),
                          padding:EdgeInsets.fromLTRB(20,15,0,0),
                        ),
                        Padding(padding:EdgeInsets.fromLTRB(20,5,0,0),
                        child:Text("that inspire you",style:TextStyle(fontSize:20,color:Colors.grey[600]))
                        ),

                      ],
                    )
                  ],
                )
              ]),
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Container(
              // width: width/3,
              // child: dots(),
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(60, 0,0,0),
            child: dots(),),
            Spacer(),
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Sign in",style: TextStyle(fontSize: 26,color: Colors.grey[600],fontWeight: FontWeight.w400),),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          print("on tap");
                         initiateGoogleLogin();
                        //  authService.googleSignIn();
                        //  print("before navigation");
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(builder: (context) {
                        //       // return ms.MyHomePage();
                        //       return ms.TabsDemoScreen();
                        //     }),
                        //   );
                        },
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Image.asset(
                            'assets/google.png',
                            height: 50,
                            width: 50,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          initiateFacebookLogin();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Image.asset(
                            "assets/facebook.png",
                            height: 50,
                            width: 50,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        )
      ],
    );
  }

  dots() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        icon(0),
        SizedBox(
          width: 3,
        ),
        icon(1),
        SizedBox(
          width: 3,
        ),
        icon(2),
      ],
    );
  }

  icon(int a) {
    if (a == pgn) {
      return Container(
        padding: EdgeInsets.all(15),
        height: 10,
        width: 20,
        decoration: BoxDecoration(
          color: Colors.red,
          // border: Border.all(color: Colors.black, width: 0.0),
          borderRadius: new BorderRadius.all(Radius.elliptical(80, 80)),
        ),
      );
    } else
      return Container(
        padding: EdgeInsets.all(15),
        height: 7,
        width: 7,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[400],
        ),
      );
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

        c3=prefs.getBool('c3')??false;
        c1=prefs.getBool('c1')??false;
        c0=prefs.getBool('c0')??false;
        stats=prefs.getBool('stats')??false;
        profile=prefs.getBool('profile')??false;

      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return ms.TabsDemoScreen(analytics: analytics,observer: observer);
        }),
      );
    } else {
      print('check false');
      isLoggedIn = false;
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
