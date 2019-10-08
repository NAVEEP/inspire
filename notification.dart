import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main.dart' as login;
import 'profile.dart' as profile;

void main() {
  runApp(MyHomePage());
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

bool load = false;
bool show = false;

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState();
  GlobalKey fabKey = GlobalObjectKey("fab");
  bool load = false;
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('USER')
            .document(login.uid)
            .collection('NOTIFICATION')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return Scaffold(
                appBar: AppBar(
                  iconTheme: IconThemeData(color: Colors.grey[800]),
                  backgroundColor: Colors.white,
                  title: Text(
                    "Notifications",
                    style: TextStyle(color: Color(0XFF9C9C9C), fontSize: 23),
                  ),
                ),
                body: Center(child: Image.asset('assets/notif_filler.png')));
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Scaffold(body: Center(child: Text('Loading...')));
            default:
              print(login.uid);
              return Scaffold(
                appBar: AppBar(
                  iconTheme: IconThemeData(color: Colors.grey[800]),
                  backgroundColor: Colors.white,
                  title: Text(
                    "Notifications",
                    style: TextStyle(color: Color(0XFF9C9C9C), fontSize: 23),
                  ),
                ),
                body: (snapshot.data.documents.length == 0)
                    ? Center(
                        child: Column(
                        children: <Widget>[
                          Image.asset('assets/notif_filler.png',scale:0.5),
                        Padding(padding: EdgeInsets.all(10),child: Text("No New Notification to show.",style: TextStyle(color: Color(0XFF9C9C9C), fontSize: 23),),)],
                      ))
                    : ListView(
                        children: snapshot.data.documents
                            .map((DocumentSnapshot document) {
                          return
                              // Text("2222");
                              Tile(document.documentID);
                        }).toList(),
                      ),
              );
          }
        });
  }
}

class Tile extends StatefulWidget {
  Tile(this.cname);
  final String cname;
  @override
  TilePage createState() => TilePage(cname);
}

class TilePage extends State<Tile> {
  String cnam;
  DocumentSnapshot item;
  bool load = false;
  TilePage(this.cnam);
  @override
  void initState() {
    super.initState();
    Firestore.instance.collection("USER").document(cnam).get().then((doc) {
      setState(() {
        item = doc;
        load = true;
      });
    });
  }

  Widget build(BuildContext context) {
    return !load
        ? Container()
        : Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Card(
              elevation: 5,
              child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => profile.MyApp(
                                      uid: item.data['uid'],
                                    )),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10),
                              width: 60.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(item.data['photoURL']),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  item.data['uName'],
                                  textScaleFactor: 1.2,
                                ),
                                Text(
                                  "wants to get inspired from you",
                                  textScaleFactor: 0.8,
                                )
                              ],
                            ),
                            SizedBox(
                              width: 50,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                            child: InkWell(
                              child: Text(
                                "remove",
                                style: TextStyle(fontSize: 18),
                              ),
                              onTap: () {
                                deny(cnam, item);
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                            child: FlatButton(
                              // padding: EdgeInsets.fromLTRB(10,0,20,0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              color: Color(0xFFD23F3F),
                              onPressed: () {
                                accept(cnam, item);
                              },
                              child: Text(
                                "inspire",
                                style: TextStyle(
                                    fontFamily: 'Segoe UI',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.0,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
            ),
          );
  }

  deny(cnam, item) {
    Firestore.instance
        .collection('USER')
        .document(login.uid)
        .collection('NOTIFICATION')
        .document(cnam)
        .delete();

    Firestore.instance
        .collection('RELATION')
        .document(login.uid + "+" + item.uid)
        .delete();
  }

  accept(cnam, item) {
    Firestore.instance
        .collection('USER')
        .document(login.uid)
        .collection('NOTIFICATION')
        .document(cnam)
        .delete();

    Firestore.instance
        .collection('RELATION')
        .document(login.uid + "+" + item.uid)
        .setData({
      'a': login.uid,
      'b': item.uid,
      'status': 'accepted',
    });
  }
}
/* class MyHome extends StatefulWidget {
  MyHome(this.cname);
  final String cname;
  @override
  _MyHomePage createState() => _MyHomePage(cname);
}

class _MyHomePage extends State<MyHome> {
  _MyHomePage(this.cnam);
  String cnam;
  bool tim = false;
  void initState() {
    super.initState();
    var dod;
    Firestore.instance.collection("USER").document(cnam).get().then((doc){
      dod=doc;
      setState(() {
       tim=true; 
      });
    });
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              child: 
            ),
          );
      
    
  }

  
}
 */
