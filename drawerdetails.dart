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
        appBar: AppBar(
          title: Text(
            title,
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(child: Text(body,style: TextStyle(color: Color(0XFF9C9C9C), fontSize: 28),)),
        ),
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
