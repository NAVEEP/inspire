import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'profile.dart' as profile;

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
  var userDocs;


  ListView buildSearchResults(List<DocumentSnapshot> docs) {
    List<Widget> userSearchItems = [];

    docs.forEach((DocumentSnapshot doc) {
      User user = new User.fromDocument(doc);
      UserSearchItem searchItem = new UserSearchItem(user);
      userSearchItems.add(searchItem);userSearchItems.add(SizedBox(height: 1.0,child: Container(color: Colors.grey[200],),));
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
        .getDocuments()
        .then((a) {
      setState(() {
        print("inside setstate");
        userDocs = a.documents;
        // print(a.documents.first.data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print("inside scaffold");
    return new Scaffold(
      // appBar: buildSearchField(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // here the desired height
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          titleSpacing: 0.0,
          backgroundColor: Colors.white,
          title: Container(
            height: 330.0,
            padding: EdgeInsets.all(10.0),
            child: TextField(
              decoration: new InputDecoration(
                labelText: 'Search for a user....',
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: new BorderSide(
                    color: Colors.black,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
              // decoration: new InputDecoration(labelText: 'Search for a user...'),
              onSubmitted: submit,
              onChanged: (string){submit(string);},
              
            ),
          ),
        ),
      ),
      body: userDocs == null
          ? Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(""),
            )
          : buildSearchResults(userDocs),
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
        child: Container(
          padding: EdgeInsets.all(5.0),
          // decoration: BoxDecoration(border: new Border.all(color: Colors.black),shape: BoxShape.rectangle),
      child: ListTile(
          leading: new CircleAvatar(
            radius: 25.0,
            backgroundImage: new NetworkImage(user.image_url),
            backgroundColor: Colors.grey,
          ),
          title: new Text(user.uname, style: boldStyle),
          //subtitle: new Text(user.displayName),

          onTap: () {
            Navigator.pushReplacement(
              context,
              new MaterialPageRoute(builder: (context) {
                return profile.MyApp(uid: user.uid);
              }),
            );
          }),
    ));
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
