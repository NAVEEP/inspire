import 'package:cloud_firestore/cloud_firestore.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chart3.dart' as chart;
import 'main.dart' as login;
import 'search.dart' as search;
import 'pchallenge1.dart' as pc1;
import 'challenges0.dart' as inside;
import 'post2.dart' as post;
import 'notification.dart' as notif;
import 'drawer.dart' as drawer;
import 'postfromstat.dart' as postfromstat;
import 'main_screen.dart' as ms;
import 'MakePost6.dart' as mp;
import 'self_profile.dart' as self;
import 'package:highlighter_coachmark/highlighter_coachmark.dart';
import 'dart:async';
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState();
  List<Widget> accepted = [];
  List<Widget> completed = [];
  List<int> acc = [0, 0, 0, 0];
  List<int> com = [0, 0, 0, 0];
  List<int> ac = [2, 0, 0, 0];
  List<int> co = [2, 0, 0, 0];
  bool b = false;
  DateTime d1 = DateTime.now();
  int stars = 0;
  int comp = 0;
  bool show = false;
  GlobalKey fabKey = GlobalObjectKey("fab");
   void initState() {
    super.initState();

  //  login.stats?null:  !show
  //       ? Timer(Duration(seconds: 1), () {
  //           show = true;
  //           print("now  " + show.toString());
  //           showCoachMarkFAB();
  //         })
  //       : null;
  }
  Widget build(BuildContext context) {
    b == false ? getlist() : null;
  print("build");
    return WillPopScope(
      onWillPop: (){},
      //child: MaterialApp(
        //home:
        child: Scaffold(
            drawer: drawer.drawer(context),
            appBar: AppBar(
              iconTheme: new IconThemeData(color: Colors.grey),
              title: Text(
                'Your Stats',
                style: TextStyle(color: Color(0XFF9C9C9C), fontSize: 20),
              ),
              backgroundColor: Colors.white,
            ),
            body: SafeArea(child:SingleChildScrollView(
              child:
              check(),
            )),),
    );
  }

  getlist() {
    // print("getlist");

    Firestore.instance
        .collection("USER")
        .document(login.uid)
        .collection("UCHALLENGES")
        .where("status", isEqualTo: "a")
        .getDocuments()
        .then((a) {
      print("a");
      for (var doc in a.documents) {
        print(doc.documentID);
        DateTime d2 = doc['timestamp'].toDate();
        var diff = d1.difference(d2).inDays;
        accepted.add(lia(doc));
        if (diff <= 7)
          acc[0] = acc[0] + 1;
        else if (diff > 7 && diff <= 14)
          acc[1] = acc[1] + 1;
        else if (diff > 14 && diff <= 21)
          acc[2] = acc[2] + 1;
        else //if(diff>21&&diff<=28)
          acc[3] = acc[3] + 1;
      }
      setState(() {
        print("exit for");
        b = true;
      });
    });
    Firestore.instance
        .collection("USER")
        .document(login.uid)
        .collection("UCHALLENGES")
        .where("status", isEqualTo: "c")
        .getDocuments()
        .then((a) {
      for (var doc in a.documents) {
        DateTime d2 = doc['timestamp'].toDate();
        var diff = d1.difference(d2).inDays;
        completed.add(lic(doc));
        if (diff <= 7)
          com[0] = com[0] + 1;
        else if (diff > 7 && diff <= 14)
          com[1] = com[1] + 1;
        else if (diff > 14 && diff <= 21)
          com[2] = com[2] + 1;
        else
          com[3] = com[3] + 1;
      }
    });
    Firestore.instance
        .collection("USER")
        .document(login.uid)
        .get()
        .then((snap) {
      setState(() {
        stars = snap['bnum'];
        comp = snap['mnum'];
      });
    });
    print("exit");
  }

  func(String id) async {
    DocumentSnapshot snap =
        await Firestore.instance.collection('POST').document(id).get();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => postfromstat.MyHomePage(snap: snap)));
  }

  lia(DocumentSnapshot doc) {
   // print(doc['timestamp'].toDate().toString());
   String formattedDate = DateFormat('yyyy-MM-dd').format(doc['timestamp'].toDate());
   
    return Container(
      
      child: ListTile(
        onTap: () {
          if (doc['type'] == 's') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return mp.Persona(
                    cname: doc['cname'],
                    scat: "scat",
                    level: "s",
                    tag: "personal",
                    image: "string");
              }),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => inside.MyHomePage(
                        cname: doc.documentID,
                        image: doc['curl'],
                        show: false,
                      )),
            );
          }
        },
        title: Container(child: Text(doc.documentID)),
        trailing:Container(child:Text(formattedDate)),
        subtitle: Container(
          height: 0.3,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  lic(DocumentSnapshot doc) {
     String formattedDate = DateFormat('yyyy-MM-dd ').format(doc['timestamp'].toDate());

    return Container(
      child: ListTile(
        onTap: () {
          func(doc['postid']);
        },
        title: Container(child: Text(doc.documentID)),
         trailing:Container(child:Text(formattedDate)),
        subtitle: Container(
          height: 0.3,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  check() {
    print(
      "in ccheck"
    );
    if (b == false) {
      return Container(
        height: login.height,
        child: Center(child: Center(child: CircularProgressIndicator())),
      );
    } else
      print("acc");
    //print(co
    return Column(
      children: <Widget>[
        SizedBox(
          height: 40.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Card(
              elevation: 2.0,
              child: Column(
                children: <Widget>[
                  Padding(
                    child: Text(stars.toString(),
                        style:
                            TextStyle(fontFamily: 'Segoe UI', fontSize: 55.0)),
                    padding: EdgeInsets.fromLTRB(50, 10, 50, 0),
                  ),
                  Padding(
                    child: Text("   STARS \n  GAINED ",
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Segoe UI',
                            fontSize: 11.0)),
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  ),
                ],
              ),
            ),
            Card(
              elevation: 2.0,
              child: Column(
                children: <Widget>[
                  Padding(
                    child: Text(comp.toString() ?? completed.length.toString,
                        style:
                            TextStyle(fontFamily: 'Segoe UI', fontSize: 55.0)),
                    padding: EdgeInsets.fromLTRB(50, 10, 50, 0),
                  ),
                  Padding(
                    child: Text("CHALLENGES \n COMPLETED",
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Segoe UI',
                            fontSize: 11.0)),
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Card(
          child: chart.MyHomePage(acc, com),
          elevation: 10,
          margin: EdgeInsets.all(20),
        ),
        SizedBox(
          height: 15,
        ),
        
        Card(
          margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: ExpansionTile(
            title: Text("Accepted",
                style: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500)),
            children: accepted,
            initiallyExpanded: true,
          ),
        ),
        Card(
          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: ExpansionTile(
            title: Text(
              "Completed",
              style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500),
            ),
            children: completed,
            initiallyExpanded: true,
          ),
        ),
        SizedBox(
          height: 90,
        )
      ],
    );
  }

void showCoachMarkFAB() {
    CoachMark coachMarkFAB = CoachMark(bgColor: Color(0xff2F3962));
    RenderBox target = fabKey.currentContext.findRenderObject();
    Rect markRect = target.localToGlobal(Offset.zero) & target.size;
    var circleMarkRect = Rect.fromCircle(center: markRect.center, radius: markRect.longestSide * 0.6);
    coachMarkFAB.show(
        // markShape: BoxShape.rectangle,
        targetContext: fabKey.currentContext,
        markRect: circleMarkRect,
        markShape: BoxShape.circle,
        children: [
          Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(login.width/7, 120, 0, 0),
            child: Text(
              "Tap here \n to go to your profile",
              style: (TextStyle(color: Colors.white,fontSize: 30)),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.fromLTRB(login.width/6, 30, 20, 30),
          //   child: Text("          Inspire offers a various categories to choose from .Do what you like the most and progress.",
          //   style: (TextStyle(color: Colors.white,fontSize: 15)),
          //   ),
          // )
          ],)
        ],
        duration: null,
        onClose: ()async {
          show = false;
           final prefs = await SharedPreferences.getInstance();
          prefs.setBool("stats", true);
          login.stats=true;
        });
  }



}
