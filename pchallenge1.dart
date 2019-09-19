import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'main.dart' as login;
import 'main_screen.dart' as ms;

import 'package:firebase_storage/firebase_storage.dart';

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
      theme: ThemeData(primarySwatch: Colors.deepOrange),
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

  final cname = TextEditingController();
  final days = TextEditingController();

  String _validateName(String value) {
    if (value.isEmpty) return 'Challenge name is required';
    return null;
  }

  Widget build(BuildContext context) {
    return Dialog(
      child:
          //  Container(
          //         // height: 400.0,
          //         // width: 200.0,
          //         decoration:
          //             BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
          //         child:
          SingleChildScrollView(
        child: Column(children: <Widget>[
          SizedBox(height: 20.0),
          Text('Name your',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24.0,
                  fontFamily: 'Segoe UI',
                  color: Colors.black)),
          Text(' Challenge',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 30.0,
                  fontFamily: 'Segoe UI',
                  color: Colors.black)),
          SizedBox(height: 4.0),
          Container(
            height: 1.0,
            width: 150.0,
            // color:Colors.grey[700],
          ),
          SizedBox(height: 20.0),
          Container(
            height: 60.0,
            width: 180.0,
            child: TextField(
              controller: cname,
              decoration: const InputDecoration(
                // border:OutlineInputBorder(),
                hintText: "name",
              ),
              // validator:_validateName ,
              // maxLines: 2,
            ),
          ),
          SizedBox(height: 26.0),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                /*Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image: AssetImage('images/calendar.png'),
                        fit: BoxFit.cover,
                      ),
                    )),*/
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Set the number of days',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          fontFamily: 'Segoe UI',
                          color: Colors.black)),
                ),
              ]),
          SizedBox(height: 0.0),
          Container(
            width: 100.0,
            child: TextFormField(
              controller: days,
              decoration: const InputDecoration(
                  // border:OutlineInputBorder(),
                  // prefixText:
                  hintText: "days"),
              validator: _validateName,
              keyboardType: TextInputType.phone,
              //maxLines: 2,
            ),
          ),
          SizedBox(height: 30.0,),
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            color: Colors.grey[100],
            onPressed: () {
              Firestore.instance
                  .collection("USER")
                  .document(login.uid)
                  .collection('CHALLENGES')
                  .document(cname.text)
                  .setData(
                {
                  "status": 'a',
                  "type": 's',
                  "cname": cname.text,
                  "days": days.text,
                  "timestamp": DateTime.now(),
                },
                merge: true,
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ms.TabsDemoScreen(),
                ),
              );
            },
            child: Text(
              'Done',
              style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0,
                  color: Color(0xffe73131)),
            ),
          ),
          SizedBox(
            height: 20.0,
          )
        ]),
      ),
    );
  }
}
