import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Share Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Share Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  String file;
  MyHomePage({Key key, this.title,this.file}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState(file);
}

class _MyHomePageState extends State<MyHomePage> {

String file;
_MyHomePageState(this.file);
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _shareImage,
        tooltip: 'Share',
        child: new Icon(Icons.share),
      ),
    );
  }

  _shareImage() async {
    try {
      final ByteData bytes = await rootBundle.load('assets/pic4.jpg');
      final Uint8List list = bytes.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.jpg').create();
      file.writeAsBytesSync(list);

      final channel = const MethodChannel('channel:me.albie.share/share');
      channel.invokeMethod('shareFile', 'image.jpg');

    } catch (e) {
      print('Share error: $e');
    }
  }
}