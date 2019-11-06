import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:image/image.dart' as im;
// import 'package:image_picker_modern/image_picker_modern.dart';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
//import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'video4.dart' as video;
import 'main.dart' as login;
import 'main_screen.dart' as ms;
import 'congo.dart' as congo;
import 'package:progress_indicators/progress_indicators.dart';

class Persona extends StatefulWidget {
  String cname, scat, level, tag, image,type;
  Persona({Key key, this.cname, this.scat, this.level, this.tag, this.image,type})
      : super(key: key);

  @override
  _PersonaState createState() => _PersonaState(cname, scat, level, tag, image,type);
}

class _PersonaState extends State<Persona> {
  String cname, scat, level, tag, image,type;
  _PersonaState(this.cname, this.scat, this.level, this.tag, this.image,this.type);
  

  File samplei;
  File samplev;
  File thumbsamplev;
  File thumbsamplei;
  // bool _switchVal=false;
  int _radioValue1 = 0;
  final myController = TextEditingController();
  StorageUploadTask task1;
  StorageUploadTask task2;
  String url;
  String thumbnail_url;
  bool upload;
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    //_switchVal=false;
    //state=false;
    upload = false;
    samplei = null;
    samplev = null;
    _radioValue1 = 0;
  }
// Future<bool> checkAndRequestCameraPermissions() async {
//   PermissionStatus permission =
//       await PermissionHandler().checkPermissionStatus(PermissionGroup.camera);
//   if (permission != PermissionStatus.granted) {
//     Map<PermissionGroup, PermissionStatus> permissions =
//         await PermissionHandler().requestPermissions([PermissionGroup.camera]);
//     return permissions[PermissionGroup.camera] == PermissionStatus.granted;
//   } else {
//     return true;
//   }
// }
  Widget Choose() {
    return Container(
      height: 258.0,
      // width: 340.0,
      child: Material(
          elevation: 1.0,
          borderRadius: BorderRadius.circular(6.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: 0.0,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Card(
                        elevation: 4.0,
                        child: GestureDetector(
                          onTap: () {
                            getImagec();
                          },
                          child: Container(
                            height: 80.0,
                            width: MediaQuery.of(context).size.width / 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text("Add Photo",
                                    softWrap: true,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0,
                                        fontFamily: 'Segoe UI',
                                        color: Colors.grey[800])),
                                Text("Via Camera",
                                    softWrap: true,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0,
                                        fontFamily: 'Segoe UI',
                                        color: Colors.grey[800])),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 4.0,
                        child: GestureDetector(
                          onTap: () {
                            getImageg();
                          },
                          child: Container(
                            height: 80.0,
                            width: MediaQuery.of(context).size.width / 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text("Add Photo ",
                                    softWrap: true,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0,
                                        fontFamily: 'Segoe UI',
                                        color: Colors.grey[800])),
                                Text("Via Gallery",
                                    softWrap: true,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0,
                                        fontFamily: 'Segoe UI',
                                        color: Colors.grey[800])),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Text('Add Photo via camera',style:TextStyle(fontWeight:FontWeight.w600, fontSize: 16.0,fontFamily: 'Segoe UI',color:Colors.grey[800])),
                      Card(
                        elevation: 4.0,
                        child: GestureDetector(
                          onTap: () {
                            getVideoc();
                          },
                          child: Container(
                            height: 80.0,
                            width: MediaQuery.of(context).size.width / 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text("Add Video",
                                    softWrap: true,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0,
                                        fontFamily: 'Segoe UI',
                                        color: Colors.grey[800])),
                                Text("Via Camera",
                                    softWrap: true,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0,
                                        fontFamily: 'Segoe UI',
                                        color: Colors.grey[800])),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 4.0,
                        child: GestureDetector(
                          onTap: () {
                            getVideog();
                          },
                          child: Container(
                            height: 80.0,
                            width: MediaQuery.of(context).size.width / 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text("Add Video",
                                    softWrap: true,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0,
                                        fontFamily: 'Segoe UI',
                                        color: Colors.grey[800])),
                                Text("Via Gallery",
                                    softWrap: true,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0,
                                        fontFamily: 'Segoe UI',
                                        color: Colors.grey[800])),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
              ])),
    );
  }

  Widget Post() {
    if (samplei != null) {

      print("Inside print");
      return Container(
        padding: EdgeInsets.all(10.0),
        height: 258.0,
        width: 340.0,
        child: Material(
          elevation: 1.0,
          borderRadius: BorderRadius.circular(6.0),
          
          child: Image.file(samplei),
        ),
      );
    } else if (samplev != null) { 
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          height: 400.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: video.VideoApp(video: samplev),
        ),
      );
    }
  }

  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;
    });
  }

  Future getImageg() 
  // async
   {
   // var tImage;
    // var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
   
    // // // // var tempImage = await ImagePicker.pickVideo(source: ImageSource.camera,);
    // setState(() {
    //   samplei = tempImage;
    // });
    
  }
  

  Future getImagec() async {

    //if (await checkAndRequestCameraPermissions()){
    //   var tempImage = await ImagePicker.pickImage(source: ImageSource.camera);

    // // // //print("camera source");
    
    // // // // var tempImage = await ImagePicker.pickVideo(source: ImageSource.camera,);
    // setState(() {

    //   print("in set state of camera");
    //   samplei = tempImage;
    // });
    //}
                      // im.Image image = im.decodeImage(tempImage.readAsBytesSync());
                      // im.Image thumbnail = im.copyResize(image, width: 320);
                      // thumbsamplei..writeAsBytesSync(im.encodeJpg(thumbnail,quality: 75));
    
  }

  Future getVideog() async {
    //var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    // var tempImage = await ImagePicker.pickVideo(
    //   source: ImageSource.gallery,
    // );
    // setState(() {
    //   samplev = tempImage;
    // });
  }

  Future getVideoc() async {
    // var tempImage = await ImagePicker.pickVideo(
    //   source: ImageSource.camera,
    // );
    // setState(() {
    //   samplev = tempImage;
    // });
  }

  @override
  Widget build(BuildContext context) {
    String postname, description;
    getlink(String type) async {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return congo.MyHomePage(
            star: lev(),
          );
        }),
      );
      StorageTaskSnapshot downloadUrl1 = await task1.onComplete;
      url = await downloadUrl1.ref.getDownloadURL() as String;

      StorageTaskSnapshot downloadUrl2 = await task2.onComplete;
      thumbnail_url = await downloadUrl2.ref.getDownloadURL() as String;

      await Firestore.instance.collection("POST").document(postname).setData({
        "body": description ??myController.text,
        // "url": url,
        "timestamp": DateTime.now(),
        "level": level,
        "scat": scat,
        "cname": cname,
        "privacy": _radioValue1.toString(),
        "uid": login.uid,
        "user_url": login.photo,
        "uname": login.uname,
        "nopr": 0,
        "stars": 0,
        "rating": 0,
        "dou": 0.01,
        "media_url": url,
        "thumbnail_url":thumbnail_url,
        "mtype": type,
        "ctag": tag,
        "id": postname,
      });

      if (_radioValue1 == 0 || _radioValue1 == 1) {
        var snap = await Firestore.instance
            .collection("RELATIONS")
            .where('A', isEqualTo: login.uid)
            .getDocuments();
        for (var doc in snap.documents) {
          await Firestore.instance
              .collection("USER")
              .document(doc.data['B'])
              .collection("FEED")
              .document(postname)
              .setData({
            "timestamp": DateTime.now(),
          });
        }
      }
      print("upload");
      updatedata(postname);
      
    }

    return Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          title: Text('', style: TextStyle(color: Colors.grey[800])),
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: <Widget>[
            RaisedButton(
              
                color: Color(0xffe73131),
                child: Text("POST",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                        fontFamily: 'Segoe UI',
                        color: Colors.white)),
                onPressed: () {
                  String timenow = DateTime.now().toString();
                  postname = login.uid + timenow;
                  if (myController.text != null &&
                      (samplei != null || samplev != null)) {
                    upload = false;
                //     if(samplei != null){
                     

                //       im.Image image = im.decodeImage(samplei.readAsBytesSync());
                //       im.Image thumbnail = im.copyResize(image, width: 320);
                //       thumbsamplei..writeAsBytesSync(im.encodeJpg(thumbnail,quality: 75));

                // }
        //         if(samplev!=null)
        //         {
        //           final _flutterVideoCompress = FlutterVideoCompress();
                    
        //              thumbsamplev =  _flutterVideoCompress.getThumbnailWithFile(
        //   samplev.path,
        //   quality: 70,
        //   position: -1,
        // );

        //         }

                final StorageReference firebaseStorageRef1 =
                        FirebaseStorage.instance.ref().child("t"+postname);
                    task2 = firebaseStorageRef1
                        .putFile((samplev != null) ? thumbsamplev : thumbsamplei);

                    // _showDialog(false);
                    final StorageReference firebaseStorageRef2 =
                        FirebaseStorage.instance.ref().child("t"+postname);
                    task1 = firebaseStorageRef2
                        .putFile((samplev != null) ? samplev : samplei);
                    getlink((samplev != null) ? "v" : "i");
                  }
                }),
          ],
        ),
        body: ListView(children: [
          Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(height: 15.0),

            Container(
              margin: EdgeInsets.all(10.0),
              height: 100.0,
              width: MediaQuery.of(context).size.width,
              child: Theme(
                data: new ThemeData(
                  primaryColor: Color(0xffe73131),
                  primaryColorDark: Color(0xffe73131),
                ),
                child: TextField(
                  onChanged: (string) {
                    setState(() {
                      description = string;
                    });
                  },
                  controller: myController,
                  decoration: const InputDecoration(
                   // focusColor: Color(0xffe73131),
                    border: OutlineInputBorder(),
                    hintText: "How are you feelin abt it?",
                    labelText: "Description",
                  ),
                  maxLines: 4,
                ),
              ),
            ),
            SizedBox(height: 20.0),

            Container(
              height: 20.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Post Privacy",
                    style: TextStyle(
                        color: Color(0xFFe73131),
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                        fontFamily: 'Segoe UI'),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Radio(
                  value: 0,
                  groupValue: _radioValue1,
                  onChanged: _handleRadioValueChange1,
                ),
                new Text(
                  'Global',
                  style: new TextStyle(fontSize: 16.0),
                ),
                new Radio(
                  value: 1,
                  groupValue: _radioValue1,
                  onChanged: _handleRadioValueChange1,
                ),
                new Text(
                  'Followers',
                  style: new TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                new Radio(
                  value: 2,
                  groupValue: _radioValue1,
                  onChanged: _handleRadioValueChange1,
                ),
                new Text(
                  'Private',
                  style: new TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            //SizedBox(height:35.0),

            SizedBox(height: 20.0),
            Container(
              height: 20.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Tags attached",
                    style: TextStyle(
                        color: Color(0xFFe73131),
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                        fontFamily: 'Segoe UI'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 0.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              
              children: <Widget>[
                FlatButton(
                  onPressed: () {},
                  child: Text(
                     '#' + cname,
                    style:
                        new TextStyle(fontSize: 15.0, color: Color(0xff2284a1)),
                  ),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text(
                    "#level  " + level ,
                    style:
                        new TextStyle(fontSize: 15.0, color: Color(0xff2284a1)),
                  ),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text(
                    '#' + scat,
                    style:
                        new TextStyle(fontSize: 15.0, color: Color(0xff2284a1)),
                  ),
                ),
              ],
            ),
            (samplei == null && samplev == null) ? Choose() : Post(),
            //Choose(),
          ])
        ]));
  }

  // void _showDialog(up) {
  //   // flutter defined function
  //   if (up == false) {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         // return object of type Dialog
  //         return AlertDialog(

  //       content: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: <Widget>[ Text("Uploading post  "),  CircularProgressIndicator(),]),
            

  //           // content: new Text("Alert Dialog body"),
  //           actions: <Widget>[
  //             // usually buttons at the bottom of the dialog
  //             new FlatButton(
  //                shape: RoundedRectangleBorder(
  //                                     borderRadius: BorderRadius.circular(10.0),
  //                                   ),
  //               color: Color(0xffe73131),
  //               child: Text("Upload in background",style: TextStyle(color: Colors.white),),
  //               onPressed: () { },
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   } else {
  //     Navigator.of(context, rootNavigator: true).pop();
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) {
  //         return congo.MyHomePage(
  //           star: lev(),
  //         );
  //       }),
  //     );
  //   }
  // }

  updatedata(postname) async {
    int bnum, unum, mnum;
    Firestore.instance.collection("USER").document(login.uid).get().then((a) {
      bnum = a['bnum'];
      unum = a['unum'];
      mnum = a['mnum'];
      switch (level) {
        case ('a'):
          {
            bnum = bnum + 1;
            break;
          }
        case ('b'):
          {
            bnum = bnum + 2;
            break;
          }
        case ('c'):
          {
            bnum = bnum + 3;
            break;
          }
        case ('d'):
          {
            bnum = bnum + 4;
            break;
          }
        case ('e'):
          {
            bnum = bnum + 5;
            break;
          }
      }
      mnum = mnum + 1;
      Firestore.instance.collection("USER").document(login.uid).updateData({
        'bnum': bnum,
        'unum': unum,
        'mnum': mnum,
      });
    });
    final QuerySnapshot result = await Firestore.instance
        .collection("USER")
        .document(login.uid)
        .collection("UCHALLENGES")
        .where('cname', isEqualTo: cname)
        .limit(1)
        .getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    if (documents.length == 1) {
      Firestore.instance
          .collection("USER")
          .document(login.uid)
          .collection("UCHALLENGES")
          .document(cname)
          .updateData({'status': "c", 'postid': postname});
    } else {
      Firestore.instance
          .collection("USER")
          .document(login.uid)
          .collection("UCHALLENGES")
          .document(cname)
          .setData({
        'status': "c",
        'postid': postname,
        "curl": login.photo,
        'timestamp': DateTime.now()
      });
    }
  }

  lev() {
    switch (level) {
      case ('a'):
        {
          return 1;
        }
      case ('b'):
        {
          return 2;
        }
      case ('c'):
        {
          return 3;
        }
      case ('d'):
        {
          return 4;
        }
      case ('e'):
        {
          return 5;
        }
    }
  }
}
