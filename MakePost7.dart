import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'video4.dart' as video;
import 'main.dart' as login;

class Persona extends StatefulWidget {
  String cname,day,days;
  Persona({Key key, this.cname,this.day,this.days})
      : super(key: key);

  @override
  _PersonaState createState() => _PersonaState(cname,day,days);
}

class _PersonaState extends State<Persona> {
  String cname,day,days;
  _PersonaState(this.cname,this.day,this.days);

  File samplei;
  File samplev;
  // bool _switchVal=false;
  int _radioValue1 = 0;
  final myController = TextEditingController();
  StorageUploadTask task;
  String url;
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    //_switchVal=false;
    //state=false;
    samplei = null;
    samplev = null;
    _radioValue1 = 0;
  }

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
                //SizedBox(height: 10.0,),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Card(
                        child: GestureDetector(
                          onTap: () {
                            getImagec();
                          },
                          child: Container(

                            height: 80.0,width: MediaQuery.of(context).size.width/3.5,
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
                        child: GestureDetector(
                          onTap: () {
                            getImageg();
                          },
                          child: Container(
                            height: 80.0,width: MediaQuery.of(context).size.width/3.5,
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
                        child: GestureDetector(
                          onTap: () {
                            getVideoc();
                          },
                          child: Container(
                            height: 80.0,
                            width: MediaQuery.of(context).size.width/3.5,
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
                        child: GestureDetector(
                          onTap: () {
                            getVideog();
                          },
                          child: Container(
                            height: 80.0,width: MediaQuery.of(context).size.width/3.5,
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
      return Container(
        height: 258.0,
        width: 340.0,
        child: Material(
          elevation: 1.0,
          borderRadius: BorderRadius.circular(6.0),
          child: Image.file(samplei, height: 280.0, width: 320.0),
        ),
      );
    } else if (samplev != null) {
      return Container(
        height: 258.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: video.VideoApp(video: samplev),
      );
    }
  }

  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;
    });
  }

  Future getImageg() async {
  //   var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
  //   // var tempImage = await ImagePicker.pickVideo(source: ImageSource.camera,);
  //   setState(() {
  //     samplei = tempImage;
  //   });
  }

  Future getImagec() async {
    // var tempImage = await ImagePicker.pickImage(source: ImageSource.camera);
    // // var tempImage = await ImagePicker.pickVideo(source: ImageSource.camera,);
    // setState(() {
    //   samplei = tempImage;
    // });
  }

  Future getVideog() async {
    //var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    // var tempImage = await ImagePicker.pickVideo(
    //   source: ImageSource.camera,
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
    String postname;
    getlink(String type) async {
      StorageTaskSnapshot downloadUrl = await task.onComplete;
      url = await downloadUrl.ref.getDownloadURL() as String;

      await Firestore.instance.collection("POST").document(postname).setData({
        "body": myController.text,
        // "url": url,
        "timestamp": DateTime.now(),
      //  "level": level,
        //"scat": scat,
        "cname": cname,
        "privacy": _radioValue1.toString(),
        "uid": login.uid,
        "user_url": login.photo,
        "uname": login.uname,
        "nopr": 0,
        "stars": 0,
        "rating": 0,
        "dou": 0.0,
        "media_url": url,
        "mtype": type,
        //"ctag": tag,
        "dtag":day,
        "type":"s",
      });
      Firestore.instance
          .collection('USER')
          .document(login.uid)
          .collection('CHALLENGES')
          .document(cname+day)
          .setData({"status": 'c', 'postid': postname,'timestamp':DateTime.now(),"day":day,"cname":cname,"days":days,"type":"ns"},merge: true);

      if (_radioValue1 == 0 || _radioValue1 == 1) {
        var snap = await Firestore.instance
            .collection("RELATION")
            .where('A', isEqualTo: login.uid)
            .getDocuments();
        for (var doc in snap.documents) {
          await Firestore.instance
              .collection("USER")
              .document(doc.data['B'])
              .collection("FEED")
              .document(postname)
              .setData({});
        }
      }
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Stop using other social media!"),));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('', style: TextStyle(color: Colors.white)),
          backgroundColor: Color(0xFFD8491C),
          //leading: Icon(Icons.menu,color:Colors.white),
          actions: <Widget>[
            RaisedButton(
                color: Color(0xFFD8491C),
                child: Text("POST"),
                onPressed: () {
                  String timenow = DateTime.now().toString();
                  postname = login.uid + timenow;
                  if (myController.text != null &&
                      (samplei != null || samplev != null)) {
                    final StorageReference firebaseStorageRef =
                        FirebaseStorage.instance.ref().child(postname);
                    task = firebaseStorageRef
                        .putFile((samplev != null) ? samplev : samplei);
                    getlink((samplev != null) ? "v" : "i");
                  }
                }),
          ],
        ),
        body: ListView(children: [
          Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(height: 30.0),

            Container(
              height: 100.0,
              width: MediaQuery.of(context).size.width,
              // decoration:BoxDecoration(

              // borderRadius: BorderRadius.circular(12.0),
              // border: Border.all(
              //   color: Color(0xFFB7B5B5),
              //   width: 2.0,
              // ),
              // )
              child: TextFormField(
                controller: myController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "How are you feelin abt it?",
                  labelText: "Description",
                ),
                maxLines: 4,
              ),
            ),
            SizedBox(height: 20.0),

            Container(
              height: 20.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Post Privacy:",
                    style: TextStyle(
                        color: Color(0xFFD8491C),
                        fontWeight: FontWeight.w600,
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

            SizedBox(height: 5.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0),
                  color: Colors.deepOrange,),
                  child: Text(
                    '   '+'#' + cname+'   ',
                    style: new TextStyle(fontSize: 15.0,color: Colors.white),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0),
                    color: Colors.deepOrange,),
                  child: Text(
                    "   #day  " + day +'   ',
                    style: new TextStyle(fontSize: 15.0,color: Colors.white),
                  ),
                ),
                // Container(
                //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0),
                //     color: Colors.deepOrange,),
                //   child: Text(
                //     '   '+'#' + scat+'   ',
                //     style: new TextStyle(fontSize: 15.0,color: Colors.white),
                //   ),
                // ),
              ],
            ),
            (samplei == null && samplev == null) ? Choose() : Post(),
            //Choose(),
          ])
        ]));
  }
}
