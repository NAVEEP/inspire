import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'post2.dart' as post;
import 'main.dart' as login;

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
class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState();

  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('POST')
        .where('privacy', isEqualTo: '0').orderBy('timestamp', descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Scaffold(body: Center(child: Text('Loading...')));
            default:
              return Scaffold(body:
              // PageView.builder(
              //       controller: PageController(),
              //       scrollDirection: Axis.vertical,

              //       itemBuilder:(context,position) {

              //         snapshot.data.documents.map((DocumentSnapshot document) {
              //          // print(document.documentID);
              //           return Tile(document);
                  
              //     });
              //       },
              //     )
               ListView(
                  children:
                      snapshot.data.documents.map((DocumentSnapshot document) {
                    return  Tile(document);
                  }).toList(),
               ),
              );
          }
        });
  }

}
class Tile extends StatelessWidget {
  final DocumentSnapshot document;
  Tile(this.document);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: post.MyHomePage(snap: document,));}}
class MyHome extends StatefulWidget {
  MyHome({
    Key key,
  }) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}
class _MyHomeState extends State<MyHome> {
  _MyHomeState();

  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance .collection('USER')
        .document(login.uid)
        .collection("FEED")
        .orderBy('timestamp', descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            print(snapshot.data.documents.first);
           if (!snapshot.hasData)
            return Scaffold(body: Center(child: CircularProgressIndicator()));
        print(snapshot.data.documents.first);
              return Scaffold(body: //ListView(
                  PageView.builder(
                    controller: PageController(),
                    scrollDirection: Axis.vertical,

                    itemBuilder:(context,position) {

                      snapshot.data.documents.map((DocumentSnapshot document) {
                       // print(document.documentID);
                        Firestore.instance.collection("POST").document(document.documentID).get().then((post){
                          return Tile(post);
                          });
                  
                  });
                    },
                  )
                  // children:
                  //     snapshot.data.documents.map((DocumentSnapshot document) {
                  //       print(document.documentID);
                  //       Firestore.instance.collection("POST").document(document.documentID).get().then((post){return Tile(post);});
                  
                  // }).toList(),
               // ),
              );
          
        });
  }

}




