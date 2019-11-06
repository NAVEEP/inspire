import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'courses.dart' as next;
import 'main_screen.dart' as ms;
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

var titlee;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState(title);
}

class _MyHomePageState extends State<MyHomePage> {
  String titl;
  _MyHomePageState(this.titl);

  list() {
    return StreamBuilder<QuerySnapshot>(
      stream:
          Firestore.instance.collection("LOGGER").orderBy("time",descending: true).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();

        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            children: snapshot.data.documents.map((DocumentSnapshot document) {
              Timestamp time = document.data["time"];

              return Padding(
                padding: EdgeInsets.all(10.0),
                child: Material(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(width: 0.5)),
                      child: ListTile(
                        onLongPress: (){
                          Firestore.instance.collection("LOGGER").document(document.documentID).delete();
                        },
                          title: Text(document.data["name"]),
                          trailing: Column(
                            children: <Widget>[
                              
                                  Text(time.toDate().toIso8601String()),
                            ],
                          )),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return
        WillPopScope(
          onWillPop:(){
 Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return ms.TabsDemoScreen();
        }),
      );
          },
          child:
        Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(20, 40, 10, 10),
              child: Text("Sasta Logger", textScaleFactor: 2.5),
            ),
            SingleChildScrollView(
              child: list(),
            ),
          ],
        ),
      ),
    ),);
  }
}
