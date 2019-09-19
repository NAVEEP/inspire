import 'dart:convert';
import 'auth.dart';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'main_screen.dart' as ms;
import 'package:shared_preferences/shared_preferences.dart';
import 'post2.dart' as post;
import 'package:feature_discovery/feature_discovery.dart';

String uid;
String uname;
String photo;
List<Widget> items = [];
double height =300;
double width =300;

 

void main() {
  //timeDilation = 1.0;
  runApp(
    MaterialApp(
      
      //home: LoginPage()
      builder: (context, child) {
        return FeatureDiscovery(
          child: child,
        );
      },
      home: LoginPage(),)
    );
  }
      
   // ),
  //);


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  final Firestore _db = Firestore.instance;
  
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
    check();
    super.initState();
    authService.profile.listen((state) => setState(() => _profile = state));

    authService.loading.listen((state) => setState(() => _loading = state));
     _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
       
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: ListTile(
                  title: Text(message['notification']['title']),
                  subtitle: Text(message['notification']['body']),
                ),
                actions: <Widget>[
                  FlatButton(
                    color: Colors.amber,
                    child: Text('Ok'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // TODO optional
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // TODO optional
      },
    );

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
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(child:Container(
          child: Center(
            child: _displayLoginButton(profileData),
          ),
        ),
      ),),
    );
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

        String fcmToken = await _fcm.getToken();

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
        if (fcmToken != null) {
      var tokens = _db
          .collection('USER')
          .document(profile['id'])
          .collection('tokens')
          .document(fcmToken);

      await tokens.setData({
        'token': fcmToken,
        'createdAt': FieldValue.serverTimestamp(), // optional
        'platform': Platform.operatingSystem // optional
      });
    }
        save(
          profile['id'],
          profile['name'],
          profile['picture']['data']['url'],
        );

        onLoginStatusChanged(true, profileData: profile);
        //getFeed();
         Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return ms.TabsDemoScreen();
        }),
      );
        break;
    }
    uid = profileData['id'];
    uname = profileData['name'];
    photo = profileData['picture']['data']['url'];
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
            Stack(
              children: <Widget>[
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
                          MediaQuery.of(context).size.height / 1.1 -
                          12,
                      child: RaisedButton(
                          color: Color(0xffe73131),
                          child: Text(
                            "Get Started",
                            style: TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                          onPressed: () {
                            // initiateFacebookLogin();

                            pageController.jumpToPage(1);
                          }),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width / 6,
                      MediaQuery.of(context).size.height / 4,
                      0.0,
                      0.0),
                  child: Text(
                    "inspire",
                    textScaleFactor: 6.0,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/pablo-uploading.png',
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/pablo-success-1.png',
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/pablo-basketball-game.png',
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
                    'assets/pablo-car-rental.png',
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
                    'assets/pablo-sign-in.png',
                    height: MediaQuery.of(context).size.height / 1.1,
                  ),
                  Container(
                    margin: EdgeInsets.all(6.0),
                    height: 25.0,
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                        color: Color(0xffe73131),
                        child: Text(
                          "Sign In With Google",
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                       onPressed: () {
                          authService.googleSignIn();
                          if(uname!=null){
                          Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return ms.TabsDemoScreen();
        }),
      );}
                       })),
                  Container(
                    margin: EdgeInsets.all(6.0),
                    height: 25.0,
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                        color: Color(0xffe73131),
                        child: Text(
                          "Login with Facebook",
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
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
                    SizedBox(
                      height: height / 3.5,
                      child: Image.asset("assets/ill4.png"),
                    ),
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
                    SizedBox(
                      height: height / 3.5,
                      child: Image.asset("assets/ill1.png"),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          child:
                              Text("something", style: TextStyle(fontSize: 25)),
                          padding:EdgeInsets.fromLTRB(20,15,0,0),
                        ),
                        Padding(padding:EdgeInsets.fromLTRB(20,5,0,0),
                        child:Text("something",style:TextStyle(fontSize:20,color:Colors.grey[600]))
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
                    SizedBox(
                      height: height / 3.5,
                      child: Image.asset("assets/ill2.png"),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          child:
                              Text("something", style: TextStyle(fontSize: 25)),
                          padding:EdgeInsets.fromLTRB(20,15,0,0),
                        ),
                        Padding(padding:EdgeInsets.fromLTRB(20,5,0,0),
                        child:Text("something",style:TextStyle(fontSize:20,color:Colors.grey[600]))
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
                          authService.googleSignIn();
                          if(uname!=null){
                          Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return ms.TabsDemoScreen();
        }),
      );}
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
    String fcmToken = await _fcm.getToken();
    
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
    //   if (fcmToken != null) {
    //   var tokens = _db
    //       .collection('USER')
    //       .document(uid)
    //       .collection('tokens')
    //       .document(fcmToken);

    //   await tokens.setData({
    //     'token': fcmToken,
    //     'createdAt': FieldValue.serverTimestamp(), // optional
    //     'platform': Platform.operatingSystem // optional
    //   });
    // }
      //getFeed();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return ms.TabsDemoScreen();
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
