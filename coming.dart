import 'package:flutter/material.dart';


class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:Container(
      height:double.infinity,
      
        child:Image.asset('assets/coming_soon.jpg'),

      ),
      
    );
  }
}