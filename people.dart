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
              //           appBar: AppBar(
              //              leading: new IconButton(
              //  icon: new Icon(Icons.arrow_back, color: Colors.black),
              //  onPressed: () => Navigator.of(context).pop(),
              // ),
              //             iconTheme: IconThemeData(color: Colors.grey[800]),
              //             textTheme: TextTheme(
              //               title: TextStyle(color: Color(0XFF9C9C9C), fontSize: 23),
              //             ),
              //             backgroundColor: Colors.white,
              //             title: Text("Discover people "),
              //           ),
                        body: Column(
                          children: <Widget>[
                          //  Flexible(
                          //    flex: 2,
                          //    child: row(),
                          //  ),
                            Flexible(
                              flex: 18,
                              child: Container(
                                height: login.height,
                                color: Colors.grey[100],
                                child: GridView.count(
                                  crossAxisCount: 2,
                                  // gridDelegate: SliverGridDelegate(),
                                  children: snapshot.data.documents
                                      .map((DocumentSnapshot document) {
                                    String uiid = document["uid"];
                                    int n = document["ins"];
                                    return Tile(document, n, uiid);
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                       ));
                }
              });
        }
      
        row() {
          return StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('SUBCAT').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return Scaffold(body: Center(child: CircularProgressIndicator()));
                if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Scaffold(body: Center(child: Text('Loading...')));
                  default:
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child:Row(
                      children:
                          snapshot.data.documents.map((DocumentSnapshot document) {
                        // return Tile(document,n,uiid);
                        return Button(document.documentID);
                      }).toList(),
                    ),);
                }
              });
        }

        list(String cat)
        {

           return StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collectionGroup('UCHALLENGES').where('scat',isEqualTo: cat).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return Scaffold(body: Center(child: CircularProgressIndicator()));
                if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Scaffold(body: Center(child: Text('Loading...')));
                  default:
                  return Scaffold(
                      body: Flexible(
                              flex: 18,
                              child: Container(
                                height: login.height,
                                color: Colors.grey[100],
                                child: GridView.count(
                                  crossAxisCount: 2,
                                  // gridDelegate: SliverGridDelegate(),
                                  children: snapshot.data.documents
                                      .map((DocumentSnapshot document) {
                                    String uid = document["uid"];
                                     Firestore.instance.collection("User").document(uid).get().then((doc){

                                       return Tile(doc, doc['ins'], doc['uid']);
                                     });
                                    
                                  }).toList(),
                                ),
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
  Tile(this.document, this.n, this.uiid);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(2, 5, 2, 5),
      child: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
            context,
            new MaterialPageRoute(builder: (context) {
              return profile.MyApp(uid: uiid);
            }),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5)),
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
                padding: EdgeInsets.all(10),
                child: Text(
                  document['uName'],
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(0),
                child: Text(
                  'Inspiring $n people' ?? "",
                  style: TextStyle(fontWeight: FontWeight.w200, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class Button extends StatelessWidget {
  String name;
  Button(this.name);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        padding: EdgeInsets.fromLTRB(15,10,15,10),
        // height: 50,
        // width: 100,
        child: Text(name),
        decoration: BoxDecoration(

          color: Colors.white,
          border: Border.all(width: 0.5),
          borderRadius: new BorderRadius.all(Radius.elliptical(20, 20)),
        ),
      ),
    );
  }
}

