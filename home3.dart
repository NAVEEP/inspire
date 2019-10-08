import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'post2.dart' as post;
import 'main.dart' as login;

var _scaffoldKey= new GlobalKey<ScaffoldState>();

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
  }) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget build(BuildContext context) {
    return Scaffold(
      key:_scaffoldKey,
      body: buildActivityFeed(),
    );
  }

  bool bl = false;
  @override
  void initState() {
    super.initState();
    bl = false;
    getFeed();
  }

  buildActivityFeed() {
    print(bl);
    if (bl == false) {
      print("circle");
      return Center(child: CircularProgressIndicator());
    } else {
      return ListView(
        children: items,
      );
    }
  }

  List<Widget> items = [];

  getFeed() async {
    var snap = await Firestore.instance
        .collection('POST')
        .where('privacy', isEqualTo: '0')
        .orderBy('timestamp', descending: true)
        // .orderBy("timestamp", descending: true)
        .getDocuments();

    for (var doc in snap.documents) {
      items.add(post.MyHomePage(
        snap: doc,
      ));
    }
    setState(() {
      bl = true;
    });
  }
}

class Feed extends StatefulWidget {
  Feed({
    Key key,
  }) : super(key: key);
  @override
  FeedState createState() => FeedState();
}

class FeedState extends State<Feed> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildPersonalFeed(),
    );
  }

  bool l = false;
  @override
  void initState() {
    super.initState();
    l = false;
    feed();
  }

  buildPersonalFeed() {
    print(l.toString() + "lll");
    if (l == false) {
      print("circle");
      return Center(child: CircularProgressIndicator());
    } else {
      return (item.length == 0)
          ? Center(
              child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/feed_filler.png',scale:0.5,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                      "No Posts yet .\n Start getting inspired by people to see their posts.",style: TextStyle(color: Color(0XFF9C9C9C), fontSize: 23),),
                )
              ],
            ))
          : Container(
              color: Colors.grey[300],
              height: double.infinity,
              width: double.infinity,
              child: ListView(
                children: item,
              ));
    }
  }

  List<Widget> item = [];

  feed() async {
    var snap = await Firestore.instance
        .collection('USER')
        .document(login.uid)
        .collection("FEED")
        .getDocuments();

    for (var doc in snap.documents) {
      await Firestore.instance
          .collection("POST")
          .document(doc.documentID)
          .get()
          .then((pos) {
        print(pos.data);
        item.add(post.MyHomePage(
          snap: pos,skey:_scaffoldKey,
        ));
      });
    }
    setState(() {
      l = true;
    });
  }
}
