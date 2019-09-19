import 'package:flutter/material.dart';
import 'main_screen.dart' as ms;
import 'package:cloud_firestore/cloud_firestore.dart';

class MyHomePage extends StatefulWidget {
  final String drawer;
  MyHomePage(this.drawer);

  @override
  _MyHomePageState createState() => _MyHomePageState(drawer);
}

class _MyHomePageState extends State<MyHomePage> {
  String drawer;
  _MyHomePageState(this.drawer);
  bool loading = false;
  String title = '', body = 'The text might not be there';

  @override
  Widget build(BuildContext context) {
    !loading ? getdata() : null;

    return WillPopScope(
      onWillPop: (){ Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return ms.TabsDemoScreen();
        }),
      );},
      child:
    MaterialApp(
      home: Scaffold(
        
        body: ListView(children:[Column(children: <Widget>[
          SizedBox(height:30),
          Container(
            margin:const EdgeInsets.all(15),
            child:
          Image.asset('assets/mission.png',
            
            fit:
                BoxFit.cover),),
                SizedBox(height:20),
                Text('Our Mission', style: TextStyle(fontSize: 30, fontFamily: 'Segoe UI')),
                SizedBox(height:20),
                Text('Jo daalna hai', style: TextStyle(fontSize: 16, fontFamily: 'Segoe UI',color:Colors.grey[600])),
                SizedBox(height:20),
                
                

        ],),])
      ),
    ),);
  }

  getdata() {
    Firestore.instance.collection("DRAWER").document(drawer).get().then((a) {
      setState(() {
        title = a['title'];
        body = a['body'];
        loading = true;
      });
    });
  }
}
