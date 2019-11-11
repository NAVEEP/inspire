import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'challenges0.dart' as inside;
import 'main.dart' as login;
import 'package:highlighter_coachmark/highlighter_coachmark.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
class MyHomePage extends StatefulWidget {
  final String scat, levela, levelb, levelc, leveld, levele;
  MyHomePage(
      {Key key,
      this.scat,
      this.levela,
      this.levelb,
      this.levelc,
      this.leveld,
      this.levele})
      : super(key: key);

  @override
  _MyHomePageState createState() =>
      _MyHomePageState(scat, levela, levelb, levelc, leveld, levele);
}
bool show=false;
class _MyHomePageState extends State<MyHomePage> {
  GlobalKey fabKey = GlobalObjectKey("fab");
  
  final String scat, levela, levelb, levelc, leveld, levele;
  _MyHomePageState(this.scat, this.levela, this.levelb, this.levelc,
      this.leveld, this.levele);
  PageController pageController = PageController(viewportFraction: 0.9);
  static List<Widget> lc1 = [], lc2 = [], lc3 = [], lc4 = [], lc5 = [];

  static int c1 = 0,
      t1 = 1,
      c2 = 0,
      t2 = 1,
      c3 = 0,
      t3 = 1,
      c4 = 0,
      t4 = 1,
      c5 = 0,
      t5 = 1;
  bool state = false;
  void initState() {
    c1 = 0;
    t1 = 1;
    c2 = 0;
    t2 = 1;
    c3 = 0;
    t3 = 1;
    c4 = 0;
    t4 = 1;
    c5 = 0;
    t5 = 1;
    super.initState();
   login.c1?null:  !show
        ? Timer(Duration(seconds: 1), () {
            show = true;
            print("now  " + show.toString());
            showCoachMarkFAB();
          })
        : null;
    if (state == true) {
      print(scat);
      print(state);
    } else {
      print(scat);
      print(state);
      // state = false;
      print("ininti");
      lc1 = [
        Padding(
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            child: Text("Level A",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Segoe UI',
                    color: Colors.grey[800],
                    fontSize: 20))),
        Padding(
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          child: ClipRRect(
            borderRadius: new BorderRadius.circular(8.0),
            child: Container(
              height: 150.0,
              width: login.width,
              decoration: BoxDecoration(color: Colors.grey[300]),
              child: Image.network(
                levela,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ];
      lc2 = [
        Padding(
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            child: Text("Level B",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Segoe UI',
                    color: Colors.grey[800],
                    fontSize: 20))),
        Padding(
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          child: ClipRRect(
            borderRadius: new BorderRadius.circular(8.0),
            child: Container(
              height: 150.0,
              width: login.width,
              decoration: BoxDecoration(color: Colors.grey[300]),
              child: Image.network(
                levelb,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ];
      lc3 = [
        Padding(
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            child: Text("Level C",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Segoe UI',
                    color: Colors.grey[800],
                    fontSize: 20))),
        Padding(
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          child: ClipRRect(
            borderRadius: new BorderRadius.circular(8.0),
            child: Container(
              height: 150.0,
              width: login.width,
              decoration: BoxDecoration(color: Colors.grey[300]),
              child: Image.network(
                levelc,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ];
      lc4 = [
        Padding(
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            child: Text("Level D",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Segoe UI',
                    color: Colors.grey[800],
                    fontSize: 20))),
        Padding(
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          child: ClipRRect(
            borderRadius: new BorderRadius.circular(8.0),
            child: Container(
              height: 150.0,
              width: login.width,
              decoration: BoxDecoration(color: Colors.grey[300]),
              child: Image.network(
                leveld,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ];
      lc5 = [
        Padding(
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            child: Text("Level E",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Segoe UI',
                    color: Colors.grey[800],
                    fontSize: 20))),
        Padding(
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          child: ClipRRect(
            borderRadius: new BorderRadius.circular(8.0),
            child: Container(
              height: 150.0,
              width: login.width,
              decoration: BoxDecoration(color: Colors.grey[300]),
              child: Image.network(
                levele,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ];

      getFeed('a', 1);
      getFeed('b', 2);
      getFeed('c', 3);
      getFeed('d', 4);
      getFeed('e', 5);
    }
  }

  int pgn = 0;
  Widget build(BuildContext context) {
    if (state = false) {
      print("build");
      // getFeed('a', 0);
      // getFeed('b', 1);
      // getFeed('c', 2);
      // getFeed('d', 3);
      // getFeed('e', 4);
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        // key: fabKey,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.grey[800]),
          backgroundColor: Colors.white,
          title: Text(
            scat,
            style: TextStyle(color: Colors.grey[800]),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              // Padding(
              //   padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 10.0),
              //   child: dots(),
              // ),
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Container(
                    height: 1000.0,
                    width: MediaQuery.of(context).size.width,
                    child: PageView(
                        onPageChanged: (int inr) {
                          setState(() {
                            pgn = inr;
                          });
                        },
                        controller: pageController,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: lc1,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: lc2,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: lc3,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: lc4,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: lc5,
                          ),
                        ])),
              )
            ],
          ),
        ),
      );
    }
  }

  cha(String name, String status, String image) {
    Color col;
    if (status == 'n')
      col = Colors.black;
    else if (status == 'c')
      col = Color(0xff2284a1);
    else if (status == 'a') col = Colors.white;
    ico() {
      if (status == 'n') {
        return Icon(Icons.star_border, color: Colors.grey[800]);
      } else if (status == 'c') {
        return Icon(Icons.star, color: Color(0xfff9d624));
      } else if (status == 'a') {
        return Icon(Icons.star, color: Colors.grey[800]);
      }
    }

    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => inside.MyHomePage(
                    cname: name,
                    image: image,
                    show: true,
                  )),
        );
      },
      trailing: ico(),
      title: Text(
        name,
        style: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w500,
          fontFamily: 'Segoe UI',
        ),
      ),
    );
  }

  getFeed(String level, int b) async {
    // lp[b]=[];
var snap;
  scat=="Guitar"? snap = await Firestore.instance
        .collection('CHALLENGES')        
        .where('scat', isEqualTo: scat)
        .where('level', isEqualTo: level)
        // .orderBy("order")
        .getDocuments():
        snap = await Firestore.instance
        .collection('CHALLENGES')
        .where('scat', isEqualTo: scat)
        .where('level', isEqualTo: level)
        .getDocuments();

    for (var a in snap.documents) {
      String status = 'n';
      print("step");
      await Firestore.instance
          .collection("USER")
          .document(login.uid)
          .collection("UCHALLENGES")
          .document(a.documentID)
          .get()
          .then((c) {
        if (c.exists) {
          setState(() {
            status = c['status'];
          });
        }

        switch (b) {
          case 1:
            {
              if (lc1.length == 2) {
                print(lc1.length);
                print("here");
                lc1.insert(2, row(c1, 1));
              } else {
                lc1.removeAt(2);
                lc1.insert(2, row(c1, t1));
              }
              print("23");
              status == 'c' ? c1++ : {};
              t1++;
              lc1.add(cha(a.documentID, status, levela));
              break;
            }
          case 2:
            {
              if (lc2.length == 2) {
                lc2.insert(2, row(c2, 1));
              } else {
                lc2.removeAt(2);
                lc2.insert(2, row(c2, t2));
              }
              print("23");
              status == 'c' ? c2++ : {};
              t2++;

              lc2.add(cha(a.documentID, status, levelb));
              break;
            }
          case 3:
            {
              if (lc3.length == 2) {
                lc3.insert(2, row(c3, 1));
              } else {
                lc3.removeAt(2);
                lc3.insert(2, row(c3, t3));
              }

              status == 'c' ? c3++ : {};
              t3++;
              lc3.add(cha(a.documentID, status, levelc));
              break;
            }
          case 4:
            {
              if (lc4.length == 2) {
                lc4.insert(2, row(c4, 1));
              } else {
                lc4.removeAt(2);
                lc4.insert(2, row(c4, t4));
              }
              print("23");
              status == 'c' ? c4++ : {};
              t4++;
              lc4.add(cha(a.documentID, status, leveld));
              break;
            }
          case 5:
            {
              if (lc5.length == 2) {
                lc5.insert(2, row(c5, 1));
              } else {
                lc5.removeAt(2);
                lc5.insert(2, row(c5, t5));
              }
              print("23");
              status == 'c' ? c5++ : {};
              t5++;
              lc5.add(cha(a.documentID, status, levele));
              break;
            }
        }
      });
      setState(() {
        state = true;
      });
    }
  }

  dots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        icon(0),
        icon(1),
        icon(2),
        icon(3),
        icon(4),
      ],
    );
  }

  icon(int a) {
    if (a == pgn) {
      return Icon(
        Icons.radio_button_checked,
        size: 16.0,
      );
    } else
      return Icon(Icons.radio_button_unchecked, size: 16.0);
  }

  row(a, b) {
    return Padding(
        padding: EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text("Completed",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    )),
                Text(a.toString(),
                    style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontWeight: FontWeight.w400,
                        fontSize: 20))
              ],
            ),
            Column(
              children: <Widget>[
                Text("Total",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    )),
                Text(b.toString(),
                    style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontWeight: FontWeight.w400,
                        fontSize: 20))
              ],
            ),
          ],
        ));
  }

void showCoachMarkFAB() {
    CoachMark coachMarkFAB = CoachMark(bgColor: Color(0xff2F3962));
    RenderBox target = fabKey.currentContext.findRenderObject();
  
    Rect markRect = target.localToGlobal(Offset.zero) & target.size*0;
    
    coachMarkFAB.show(
        // markShape: BoxShape.rectangle,
        targetContext: fabKey.currentContext,
        markRect: markRect,
        // markShape: BoxShape.rectangle,
         children: [
         Column(children: <Widget>[
         Padding(
           padding: EdgeInsets.fromLTRB(25, 120, 0, 0),
           child: Text(
             "Levels",
             style: (TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w600)),
           ),
         ),
         Padding(
           padding: EdgeInsets.fromLTRB(10, 30, 0, 0),
           child: Text("Challenges are organised in the form of levels of increasing order of difficulty. Level A is the best to start with.",
           style: (TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w400)),
           ),
         )
         ],)
       ],

        duration: null,
        onClose: () async{
          show = false;
           final prefs = await SharedPreferences.getInstance();
          prefs.setBool("c1", true);
          login.c1=true;
        });
  }

}