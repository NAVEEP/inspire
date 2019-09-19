import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
//import 'package:advanced_share/advanced_share.dart';
//import 'package:wc_flutter_share/wc_flutter_share.dart';
//import 'package:esys_flutter_share/esys_flutter_share.dart';

//import 'package:esys_flutter_share/esys_flutter_share.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey _globalKey = new GlobalKey();

  bool inside = false;
  Uint8List imageInMemory;
  String bs64;
   Uint8List pngBytes;

  Future<Uint8List> _capturePng() async {
    try {
      print('inside');
      inside = true;
      RenderRepaintBoundary boundary =
          _globalKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
       pngBytes = byteData.buffer.asUint8List();
      bs64 = base64Encode(pngBytes);
    

//      print(pngBytes);
//      print(bs64);
      print('png done');
      setState(() {
        imageInMemory = pngBytes;
        inside = false;
      });
      return pngBytes;
    } catch (e) {
      print(e);
    }
  }


//  void handleResponse(response, {String appName}) {
//     if (response == 0) {
//       print("failed.");
//     } else if (response == 1) {
//       print("success");
//     } else if (response == 2) {
//       print("application isn't installed");
//       if (appName != null) {
//         scaffoldKey.currentState.showSnackBar(new SnackBar(
//           content: new Text("${appName} isn't installed."),
//           duration: new Duration(seconds: 4),
//         ));
//       }
//     }
//   }
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _globalKey,
      child: new Scaffold(
          appBar: new AppBar(
            title: new Text('Widget To Image demo'),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    'click the button below to capture image',
                  ),
                  new RaisedButton(
                    child: Text('capture Image'),
                    onPressed: _capturePng,
                  ),
                  inside ? CircularProgressIndicator()
                  :
                  imageInMemory != null
                      ? Column(
                        children:<Widget>[
                         new Container(
                          child: Image.memory(imageInMemory),
                          margin: EdgeInsets.all(10)),
                         new RaisedButton(
                 child: Text('share to shareWhatsApp'),
                 onPressed: () async{
    //                                      await WcFlutterShare.share(  
    // sharePopupTitle: 'share',  
    // subject: 'This is subject',  
    // text: 'This is text',  
    // fileName: 'share.png',  
    // mimeType: 'image/png',  
    // bytesOfFile: pngBytes);
    // await Share.file('esys image', 'esys.png', pngBytes, 'image/png', text: 'My optional text.');
    

// await AdvancedShare.generic(
//     msg: "Hi inspire here", 
//     subject: "Flutter",
//     title: "Share Image",
//     url: bs64
// 	).then((response){
// 	print(response);
// 	});
//                    //await Share.file('esys image', 'esys.png', pngBytes, 'image/png', text: 'My optional text.');
      //            await AdvancedShare
      //   .whatsapp(msg: "Hye this is inspire", url: bs64);
      // //   .then((response) {
      // // handleResponse(response, appName: "Whatsapp");
      // //   });
                 },
               ),
                          
                          ])
                      : Container(),

                      
                ],
              ),
            ),
          )),
    );
  }
}