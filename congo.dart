import 'package:flutter/material.dart';
import 'main_screen.dart' as ms;
import 'package:flutter/animation.dart';
//import 'share.dart' as share;
import 'dart:io';
import 'dart:typed_data';
//import 'package:image/image.dart' ;

//import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

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
      home: MyHomePage(
        star: 3,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  int star;
  var file;
  MyHomePage({Key key, this.star,this.file}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState(star ?? 5,file);
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int star; var file;
  _MyHomePageState(this.star,this.file);

  Animation animation;
  Animation animationController;
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this)
          ..forward();

    animation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        curve: Curves.fastOutSlowIn, parent: animationController));
  }
_shareImage(var file1) async {
    try {
       final ByteData bytes = await file.toByteDta();
       final Uint8List list = bytes.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file2 = await new File('${tempDir.path}/image.jpg').create();
      file2.writeAsBytesSync(list);

      final channel = const MethodChannel('channel:me.albie.share/share');
      channel.invokeMethod('shareFile', 'image.jpg');

    } catch (e) {
      print('Share error: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start, children: [
              Stack(
                children:[
                  Container(
                  height: height/2.2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/done.png'),
                          fit: BoxFit.cover))),
                          // Container(
                          //       height: height/2.2,
                          //       width: MediaQuery.of(context).size.width,
                          //       child: Align(
                          //         alignment: Alignment.centerRight,

                          //         child:OutlineButton.icon(
                          //             icon:Icon(Icons.share),
                          //             label: Text("Share"),
                          //             onPressed: (){

                          //                   _shareImage(file);

                          //             },
                                      

                          //         ),
                          //       ),
                                

                          // ),
                ],),
              SizedBox(height: 15.0),
              Text(
                'CONGRATULATIONS',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 25.0,
                    fontFamily: 'Uniform Bold',
                    color: Color(0XFF2284A1)),
              ),
              SizedBox(height: 10.0),
              Text(
                'You have completed a challenge from',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                    fontFamily: 'Uniform Bold',
                    color: Colors.grey[500]),
              ),
              SizedBox(height: 10.0),
              Text(
                'LEVEL $star',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                    fontFamily: 'Uniform Bold',
                    color: Colors.grey[800]),
              ),
              SizedBox(height: 35.0),
              Text(
                'You earn',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0,
                    fontFamily: 'Uniform Bold',
                    color: Colors.grey[500]),
              ),
              SizedBox(height: 10.0),
              Transform(
                  transform: Matrix4.translationValues(
                      0.0, animation.value * height, 0.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: myWidget(star))),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'STARS',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                    fontFamily: 'Uniform Bold',
                    color: Colors.grey[800]),
              ),
              SizedBox(
                height: 15.0,
              ),
              
            ]),
            bottomSheet: Container(
              // color:Colors.white,
              margin:  EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/6, 0.0, 0.0, 15.0),
              // padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/3, 0, 0, 20),
                height: 45.0,
                width: MediaQuery.of(context).size.width*4/6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Color(0xFFE73131)),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Color(0xFFE73131),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return ms.TabsDemoScreen();
                      }),
                    );
                  },
                  child: Text(
                    'Continue',
                    style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0,
                        color: Colors.white),
                  ),
                ),
              ),
          );
        });
  }

  List<Widget> myWidget(int star) {
    return List.generate(
        star,
        (i) => Image.asset('assets/tara1.gif',
            width: 40.0,
            height: 40.0,
            fit:
                BoxFit.cover)); // replace * with your rupee or use Icon instead
  }
}
