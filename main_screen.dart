import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'challenges3.dart' as challenge;
import 'stats4.dart' as stats;
import 'search.dart' as search;
import 'notification.dart' as notif;
import 'drawer.dart' as drawer;
import 'home2.dart' as feed1;
import 'home3.dart' as feed;
//import 'package:firebase_analytics/observer.dart';
import 'main.dart' as login;
import 'feed.dart' as ms1;
//import 'widget_image.dart' as w;
//import 'media.dart' as share;
// import 'share.dart' as share;
// import 'camera.dart' as camera;
// import 'gallery.dart' as gallery;
// import 'camera_video.dart' as video;
// import 'onboard.dart' as onboard;

final feature1 = "FEATURE_1";
final feature2 = "FEATURE_2";

class TabsDemoScreen extends StatefulWidget {
  // String uname;
  TabsDemoScreen();

  @override
  TabsDemoScreenState createState() => TabsDemoScreenState();
}

class TabsDemoScreenState extends State<TabsDemoScreen> {
  // String uname;
  TabsDemoScreenState();
  int currentTabIndex = 0;
  void initState() {
    Firestore.instance.collection("LOGGER").add({"name":login.uname,'time':DateTime.now()});
    currentTabIndex = 0;
    super.initState();
    //  Firestore.instance
    //     .collection('CHALLENGES')
    //     .where('scat', isEqualTo: "Guitar")
        
    //     .getDocuments().then((da){
    //       for (var doc in da.documents){
    //         Firestore.instance.collection("CHALLENGES").document(doc.documentID).delete();
    //       }
    //     });
  }

  Widget get bottomNavigationBar {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(10),
        topLeft: Radius.circular(10),
      ),
      child: BottomNavigationBar(
        elevation: 100.0,
        //backgroundColor: Colors.blueGrey[50],

        onTap: onTapped,
        currentIndex: currentTabIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.outlined_flag,
              size: 30.0,
            ),
            title: Text(
              "Challenges",
              style: TextStyle(fontSize: 11.0),
            ),
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.web,
              size: 30.0,
            ),
            title: Text("Feed", style: TextStyle(fontSize: 11.0)),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.sort,
              size: 30.0,
            ),
            title: Text("Stats", style: TextStyle(fontSize: 11.0)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      // Container(child: Center(child: Text("widgete"))),
      // Container(child: Center(child: Text("widgete"))),
      // Container(child: Center(child: Text("widgete"))),
      challenge.MyHomePage(),
      // Text("dad"),Text("dad"),Text("dad"),
      ms1.MyHomePage(),stats.MyHomePage(),
      
    ];

    var scaffold = Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            tabs[currentTabIndex],
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: bottomNavigationBar,
            ),
          ],
        ),
      ),
    );
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xffe73131),
      ),
      home: scaffold,
    );
  }

  onTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }
}
