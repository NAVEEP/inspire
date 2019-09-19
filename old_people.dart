import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'post2.dart' as post;
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

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState();

  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('USER').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Scaffold(body: Center(child: Text('Loading...')));
            default:
              
              return Scaffold(
                appBar: AppBar(
                  iconTheme: IconThemeData(color: Colors.grey[800]),
                  textTheme: TextTheme(
                    title: TextStyle(color: Color(0XFF9C9C9C), fontSize: 23.0),
                  ),
                  backgroundColor: Colors.white,
                  title: Text("Discover people "),
                ),
                body: Container(
                  color: Colors.grey[100],
                  child: GridView.count(
                    crossAxisCount: 2,
                    // gridDelegate: SliverGridDelegate(),
                    children: snapshot.data.documents
                        .map((DocumentSnapshot document) {
                          String uiid = document["uid"];
                          int n = document["ins"];
                      return Tile(document,n,uiid);
                    }).toList(),
                  ),
                ),
              );
          }
        });
  }
}

class Tile extends StatelessWidget {
  
  DocumentSnapshot document;
  int n;
  String uiid;
  Tile(this.document,this.n,this.uiid);

  @override
  
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(2.0, 5.0,2.0,5.0),
      child: GestureDetector(
        onTap: (){ 
        Navigator.pushReplacement(
              context,
              new MaterialPageRoute(builder: (context) {
                return profile.MyApp(uid: uiid);
              }),
            );},
            child: 
      Container(
  
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          
          border: Border.all(
            style: BorderStyle.none,
          ),
        ),
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(document['photoURL']),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                document['uName'],
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18.0),
              ),
            ),
             Padding(
              padding: EdgeInsets.all(0.0),
              child: Text(
                'Inspiring $n people'??"",
                style: TextStyle(fontWeight: FontWeight.w200, fontSize: 14.0),
              ),
            ),
          ],
        ),
      ),
    ),);
  }
}
