import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'profile.dart' as profile;
import 'main.dart' as login;
import 'drawer.dart' as drawer;
import 'notification.dart' as notif;
import 'people.dart' as people;
//import 'search.dart' as search;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SearchPage());
  }
}

class SearchPage extends StatefulWidget {
  _SearchPage createState() => new _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  bool load = false;
  var userDocs;

  ListView buildSearchResults(List<DocumentSnapshot> docs) {
    List<Widget> userSearchItems = [];

    docs.forEach((DocumentSnapshot doc) {
      User user = new User.fromDocument(doc);
      UserSearchItem searchItem = new UserSearchItem(user);
      userSearchItems.add(searchItem);
      userSearchItems.add(SizedBox(
        height: 1,
        child: Container(
          color: Colors.grey[200],
        ),
      ));
    });
    //if (userSearchItems == null)

    return new ListView(
      children: userSearchItems,
    );
  }

  void submit(String searchValue) async {
    print("inside submit");
    await Firestore.instance
        .collection("USER")
        .where('uName',
            isGreaterThanOrEqualTo: searchValue.substring(0, 1).toUpperCase() +
                searchValue.substring(1))
        // .where('uName', isLessThan: searchValue.substring(0, 1).toUpperCase())
        .getDocuments()
        .then((a) {
      setState(() {
        print("inside setstate");
        userDocs = a.documents;
        // print(a.documents.first.data);
      });
    });
  }
    void initState() {
    
    Firestore.instance.collection("SearchLogger").add({"name":login.uname,'time':DateTime.now()});
  }

  @override
  Widget build(BuildContext context) {
    print("inside scaffold");

    return SafeArea(
      child: Scaffold(
          drawer: drawer.drawer(context),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child:
                // AppBar(
                //   iconTheme: IconThemeData(color: Colors.grey[800]),
                //   backgroundColor: Colors.white,
                //   title:
                Padding(
              padding: EdgeInsets.all(15),
              child: Card(
                elevation: 10,
                child: Container(
                  width: login.width,
                  height: 60,
                  child: TextField(
                    decoration: new InputDecoration(
                        labelText: 'Search for a user....',
                        fillColor: Colors.white,
                        // border: new OutlineInputBorder(
                        // borderRadius: BorderRadius.circular(20),
                        // borderSide: new BorderSide(
                        // color: Colors.black,
                        // ),
                        // ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                        )),
                    // decoration: new InputDecoration(labelText: 'Search for a user...'),
                    onSubmitted: submit,
                    onChanged: (string) {
                      submit(string);
                    },
                  ),
                ),
              ),
            ),
            // backgroundColor: Colors.deepOrange,
          ),
          // ),

          body: userDocs == null?
              // ? Padding(
              //     padding: EdgeInsets.all(10),
              //     child: Text(""),
              //   )
              people.MyHomePage()
              : buildSearchResults(userDocs)
          //     ? Padding(
          //         padding: EdgeInsets.all(15),
          //         child: Card(
          //           elevation: 10,
          //           child: Container(
          //             width: login.width,
          //             height: 60,
          //             child: TextField(
          //               decoration: new InputDecoration(
          //                   labelText: 'Search for a user....',
          //                   fillColor: Colors.white,
          //                   // border: new OutlineInputBorder(
          //                   // borderRadius: BorderRadius.circular(20),
          //                   // borderSide: new BorderSide(
          //                   // color: Colors.black,
          //                   // ),
          //                   // ),
          //                   prefixIcon:

          //                       Icon(
          //                         Icons.search,
          //                         color: Colors.black,

          //                   )),
          //               // decoration: new InputDecoration(labelText: 'Search for a user...'),
          //               onSubmitted: submit,
          //               onChanged: (string) {
          //                 submit(string);
          //               },
          //             ),
          //           ),
          //         ),
          //       )
          //     : buildSearchResults(userDocs),
          ),
    );
  }

  not() {
    int d = 0;
    Firestore.instance
        .collection("USER")
        .document(login.uid)
        .collection("NOTIFICATION")
        .getDocuments()
        .then((a) {
      d = a.documentChanges.length;
      if (d == 0) {
      } else if (!load) {
        setState(() {
          load = true;
        });
      }
    });
    if (!load && d == 0) {
      return Icon(
        Icons.notifications,
        color: Color(0XFF9C9C9C),
      );
    } else
      return Stack(
        children: <Widget>[
          Icon(
            Icons.notifications,
            color: Color(0XFF9C9C9C),
          ),
          Positioned(
            left: 12,
            bottom: 8,
            child: Text(".",
                style: TextStyle(color: Color(0xffe73131), fontSize: 45)),
          )
        ],
      );
  }
}

class UserSearchItem extends StatelessWidget {
  final User user;

  const UserSearchItem(this.user);

  @override
  Widget build(BuildContext context) {
    TextStyle boldStyle = new TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
    );

    return new GestureDetector(
      onTap: () {
            Navigator.pushReplacement(
              context,
              new MaterialPageRoute(builder: (context) {
                return profile.MyApp(uid: user.uid);
              }),
            );
          },
        child: Container(
      padding: EdgeInsets.all(5),
      // decoration: BoxDecoration(border: new Border.all(color: Colors.black),shape: BoxShape.rectangle),
      child: Row(children: <Widget>[
        
           Padding(
             padding: EdgeInsets.all(12),
             child: CircleAvatar(
            radius: 35,
            backgroundImage: new NetworkImage(user.image_url),
            backgroundColor: Colors.grey,
          ),),
          Text(user.uname, style: boldStyle),
          //subtitle: new Text(user.displayName),

         ], ))
   );
  }
}

class User {
  //final int cnum;
  //final int mnum;
  //final int urating;
  final String uname;
  final String uid;
  //final int bnum;
  final String image_url;
  //final String user_url;
  //final String did;

  User({
//this.cnum,this.mnum,this.urating,
    this.uname,
    this.image_url,
    this.uid,
  });

  factory User.fromDocument(DocumentSnapshot document) {
    return new User(
      //did:document.documentID,
      uname: document['uName'],
      uid: document['uid'],
      //cnum: document['cnum'],
      //mnum: document['mnum'],
      image_url: document['photoURL'],

      //user_url: document['user_url'],

      //d: document['timestamp'],
      // urating: document['urating'],
      //bnum: document["bnum"],
    );
  }
}
