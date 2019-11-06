import 'package:flutter/material.dart';
import 'pchallenge1.dart' as pc1;
import 'self_profile.dart' as profile;
import 'main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'drawerdetails.dart' as d;
import 'people.dart' as people;
import 'coming.dart' as coming;
import 'logger.dart' as logger;
import 'main.dart'as login;
// String url = 'https://n8d.at/wp-content/plugins/aioseop-pro-2.4.11.1/images/default-user-image.png';
String url = '';

String name = '';
pro(context) {
  Firestore.instance.collection("USER").document(uid).get().then((a) {
    url = a["photoURL"];
    name = a["uName"];
  });

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(url),
          ),
        ),
      ),
      Container(
        width: 120,
        child: FittedBox(
          child: Text(
            // name.split(" ")[0] + "\n"+name.split(" ")[1],
            name,
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w400),
          ),
          fit: BoxFit.scaleDown,
        ),
      ),
    ],
  );
}

uploadcomplete(context) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          //shape: RoundedRectangleBorder(
          //  borderRadius: BorderRadius.circular(10.0)),
          child: coming.MyHome(),
        );
        // child: Container(
        //   padding: const EdgeInsets.all(20.0),
        //     height: MediaQuery.of(context).size.height*0.52-50,
        //     width: MediaQuery.of(context).size.width*0.7,
        //     decoration:
        //         BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: <Widget>[

        //         SizedBox(height:30.0),
        //         Text(
        //       '1 of 3',
        //       style: TextStyle(
        //           fontFamily: 'Segoe UI',
        //           fontWeight: FontWeight.w500,
        //           fontSize: 16.0,
        //           color: Color(0xff5cb0c9)),
        //     ),
        //     SizedBox(height: 20.0,),
        //     Text(
        //       'Choose a challenge that intrigues you, lies in your interest.',
        //       style: TextStyle(
        //           fontFamily: 'Segoe UI',
        //           fontWeight: FontWeight.w500,
        //           fontSize: 19.0,
        //           color: Colors.grey[800]),
        //     ),
        //     SizedBox(height: 70.0,),
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceAround,
        //       children: <Widget>[FlatButton(
        //     shape: RoundedRectangleBorder(
        //       //borderRadius: BorderRadius.circular(30.0),
        //     ),
        //     color: Color(0xFFE73131),
        //     onPressed: () {Navigator.of(context, rootNavigator: true).pop();},
        //     child: Text(
        //       'Next',
        //       style: TextStyle(
        //           fontFamily: 'Segoe UI',
        //           fontWeight: FontWeight.w500,
        //           fontSize: 19.0,
        //           color: Colors.white),
        //     ),
        //   ),],)

        //       ],
        //     )));
      });
}

drawer(context) {
  return Drawer(
    elevation: 20.0,
    child: Center(
      child: Column(
        // padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 50.0,
          ),
          DrawerHeader(
            child: GestureDetector(
              onTap: (){

                Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) {
                  return profile.main(uid);
                }),
              );
              },
              child:
                  // Container(),
                  pro(context),
            ),
            decoration: BoxDecoration(
                // color: Colors.deepOrange,
                ),
          ),

          ListTile(
            title: Text('Create personal challenge'),
            leading: Icon(Icons.flag),
            onTap: () {
              // Navigator.push(
              //   context,
              //   new MaterialPageRoute(builder: (context) {
              //     return coming.MyHome();
              //   }),
              // );
              uploadcomplete(context);
            },
          ),
          ListTile(
            title: Text('Our Mission'),
            leading: Icon(Icons.terrain),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) {
                  return d.MyHomePage("mission");
                }),
              );
            },
          ),

          ListTile(
            title: Text('Join our Team'),
            leading: Icon(Icons.group_add),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) {
                  return d.MyHomePage("team");
                }),
              );
            },
          ),
          ListTile(
            title: Text('Suggest Changes'),
            leading: Icon(Icons.feedback),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) {
                  return d.MyHomePage("changes");
                }),
              );
            },
          ),
login.uname=="User"?ListTile(
            title: Text('logger'),
            leading: Icon(Icons.feedback),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) {
                  return logger.MyHomePage();
                }),
              );
            },
          ):SizedBox(),
          // ListTile(
          //   title: Text('Discover People'),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       new MaterialPageRoute(builder: (context) {
          //         return people.MyHomePage();
          //       }),
          //     );
          //   },
          // ),
        ],
      ),
    ),
  );
}
