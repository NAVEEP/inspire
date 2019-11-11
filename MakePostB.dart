
import 'package:flutter/material.dart';
import 'dart:async';
import 'main.dart' as main;
import 'video4.dart' as video;
import 'package:image/image.dart' as imag;
import 'package:firebase_storage/firebase_storage.dart';
import 'congo.dart' as congo;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class MyHome extends StatefulWidget {
   String type,cname,scat,level;
   var image;
  MyHome(
      {Key key,
      
      this.image,this.type,this.cname,this.scat,this.level})
      : super(key: key);

  @override
  MyHomeState createState() => MyHomeState(image,type,cname,scat,level);
}


class MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {
  String type,cname,scat,level;
  var image;
  int _radioValue1 = 0;

  MyHomeState(this.image,this.type,this.cname,this.scat,this.level);

  TextEditingController myController;
  String description='';

 StorageUploadTask task1;
  

  @override
  void initState() {
    super.initState();
 _radioValue1 = 0;  
 //body=" ";
 //descriptionController.text=" ";
  }
 
  @override
  void dispose() {
   
    
    super.dispose();
  }
void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
     
      appBar: AppBar(
                      iconTheme: new IconThemeData(color: Colors.grey),
        elevation: 1.0,
        leading: new IconButton(
               icon: new Icon(Icons.arrow_back, color: Colors.black),
               onPressed: () => Navigator.of(context).pop(),
              ), 
       //leading:Icon(icon:Ic),
        actions: <Widget>[

           Theme(
                data: new ThemeData(
                  primaryColor: Color(0xffe73131),
                  primaryColorDark: Color(0xffe73131),
                ),
          child:RaisedButton(onPressed: (){
            String timenow = DateTime.now().toString();
            String postname = main.uid + timenow;
            print("1");
            if(type!='v')
            {
              print("2");
              Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return congo.MyHomePage(
            star: lev(),file:image
          );
        }),
      );
      print("3");
              File thumbsamplei=image;

             imag.Image image1 = imag.decodeImage(image.readAsBytesSync());
             print("4");
                      imag.Image thumbnail = imag.copyResize(image1, width: 120);
                      print(thumbnail);
                      //  thumbsamplei..writeAsBytesSync(imag.encodeJpg(thumbnail,quality: 95));
                       print("thumbnail ban gaya ");
                      final StorageReference firebaseStorageRef1 =
                        FirebaseStorage.instance.ref().child(postname);
                   task1 = firebaseStorageRef1
                        .putFile(thumbsamplei);

                        print("upload initiated");
                         getlink(postname);
                            print("after getlink");

                        
                       
                        
    
      


            } 
            else if(type=='v')
            {
              Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return congo.MyHomePage(
            star: lev(),file:image
          );
        }),
      );
                print("inside video");
                final StorageReference firebaseStorageRef1 =
                        FirebaseStorage.instance.ref().child(postname);
                   task1 = firebaseStorageRef1//.putData(image);
                        .putFile( image);


                        print("file upload ho gyi");
                        getlink(postname);


                  print("Navigation se pehle");
                        

            }

            

          },
          //icon:Icon(Icons.done_all),
          color: Color(0xffe73131),
                child: Text("POST",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                        fontFamily: 'Segoe UI',
                        color: Colors.white))
         
          //highlightedBorderColor: Colors.pinkAccent,
          
          ),)
        ],
        
        backgroundColor: Colors.white,
      ),
     body:ListView (children:[Stack(
       children:[ Column(
      children: <Widget>[
         Padding(padding: EdgeInsets.only(top: 10.0)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
              Container(
              margin: EdgeInsets.all(10.0),
              height: 70.0,
              width: MediaQuery.of(context).size.width/1.09,
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
                  maxLines: 5,
                ),
              ),
            ),
          ],),
            SizedBox(height: 0.0),
             FittedBox(child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                
                
                new Radio(
                  value: 0,
                  
                  groupValue: _radioValue1,
                  onChanged: _handleRadioValueChange1,
                  activeColor:Colors.black,
                ),
               
                new Text(
                  'Global',
                  style: new TextStyle(fontSize: 14.0),
                ),
                
                new Radio(
                  value: 1,
                  groupValue: _radioValue1,
                  onChanged: _handleRadioValueChange1,
                  activeColor:Colors.black,
                ),
                new Text(
                  'Followers',
                  style: new TextStyle(
                    fontSize: 14.0,
                  ),
                ),
                
                new Radio(
                  value: 2,
                  groupValue: _radioValue1,
                  onChanged: _handleRadioValueChange1,
                  activeColor:Colors.black,
                ),
                new Text(
                  'Private',
                  style: new TextStyle(fontSize: 14.0),
                ),
              ],
            ),
            fit:BoxFit.scaleDown),
            FittedBox(child:Row(
              mainAxisAlignment: MainAxisAlignment.start,
              
              children: <Widget>[
                FlatButton(
                  onPressed: () {},
                  child: Text(
                     '# '+cname ,
                    style:
                        new TextStyle(fontWeight: FontWeight.w600,fontSize: 15.0, color: Color(0xff2284a1)),
                  ),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text(
                    "#level"+level.toUpperCase() ,
                    style:
                        new TextStyle(fontWeight: FontWeight.w600,fontSize: 15.0, color: Color(0xff2284a1)),
                  ),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text(
                    '# '+scat ,
                    style:
                        new TextStyle(fontWeight: FontWeight.w600,fontSize: 15.0, color: Color(0xff2284a1)),
                  ),
                ),
              ],
            ),
            fit: BoxFit.cover,
            ),
              Container(
              margin: EdgeInsets.fromLTRB(10,0,10,10),
                
                width: MediaQuery.of(context).size.width,
                    child:  type!='t'?(type=='i'?Image.file(
                    image,
                   
                  ):
                  Container(
                            child: Center(
                              child: AspectRatio(
                                  aspectRatio:
                                       1.0,
                                  child: video.VideoApp(video:image)),
                            ),

                          )
                  
                  
                  ):Image.asset(
                    'assets/flag.png',
                    height: MediaQuery.of(context).size.height / 6,
                    width: MediaQuery.of(context).size.width / 6,
                  ),

     ),

          
          ],),

       ])
     ],),
      
    );
  }

  getlink(String postname) async{

    print("inside get link");

    StorageTaskSnapshot downloadUrl1 = await task1.onComplete;
    String  url = await downloadUrl1.ref.getDownloadURL() as String;

    print("Link downloaded");

      
      await Firestore.instance.collection("POST").document(postname).setData({
        "body": description ??{myController.text??" "},
        // "url": url,
        "timestamp": DateTime.now(),
        "level": level,
        "scat": scat,
        "cname": cname,
        "privacy": _radioValue1.toString(),
        "uid": main.uid,
        "user_url": main.photo,
        "uname": main.uname,
        "nopr": 0,
        "stars": 0,
        "rating": 0,
        "dou": 0.01,
        "media_url": url,
       // "thumbnail_url":thumbnail_url,
        "mtype": type,
        //"ctag": tag,
        "id": postname,
      
      });
      if (_radioValue1 == 0 || _radioValue1 == 1) {
        var snap = await Firestore.instance
            .collection("RELATIONS")
            .where('A', isEqualTo: main.uid)
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
      updatedata(postname);

      print("khatam");

      // if (_radioValue1 == 0 || _radioValue1 == 1) {
      //   var snap = await Firestore.instance
      //       .collection("RELATIONS")
      //       .where('A', isEqualTo: main.uid)
      //       .getDocuments();
      //   for (var doc in snap.documents) {
      //     await Firestore.instance
      //         .collection("USER")
      //         .document(doc.data['B'])
      //         .collection("FEED")
      //         .document(postname)
      //         .setData({
      //       "timestamp": DateTime.now(),
      //     });
      //   }
      // }
  }
updatedata(postname) async {
    int bnum, unum, mnum;
    Firestore.instance.collection("USER").document(main.uid).get().then((a) {
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
      Firestore.instance.collection("USER").document(main.uid).updateData({
        'bnum': bnum,
        'unum': unum,
        'mnum': mnum,
      });
    });
    final QuerySnapshot result = await Firestore.instance
        .collection("USER")
        .document(main.uid)
        .collection("UCHALLENGES")
        .where('cname', isEqualTo: cname)
        .limit(1)
        .getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    if (documents.length == 1) {
      Firestore.instance
          .collection("USER")
          .document(main.uid)
          .collection("UCHALLENGES")
          .document(cname)
          .updateData({'status': "c", 'postid': postname});
    } else {
      Firestore.instance
          .collection("USER")
          .document(main.uid)
          .collection("UCHALLENGES")
          .document(cname)
          .setData({
        'status': "c",
        'postid': postname,
        "curl": main.photo,
        "uid":main.uid,
        'timestamp': DateTime.now(),
        "scat":scat,
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
}}