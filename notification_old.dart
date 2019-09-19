import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main.dart' as login;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notofications',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context)?? Center(child: Text("No new Notifications to show"),),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('USER')
          .document(login.uid)
          .collection('NOTIFICATION')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return 
        // LinearProgressIndicator();
       Center(child: Text("No new Notifications to show"),);
       else if (snapshot.hasData)
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
     if (snapshot.length==0) return 
        // LinearProgressIndicator();
       Center(child: Text("No new Notifications to show"),);
      else 
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(record.name),
          trailing: GestureDetector(
            child: Icon(Icons.close),
            onTap: accept(record, data),
          ),
          leading: GestureDetector(
            child: Icon(Icons.check),
            onTap: deny(data,record),
          ),
        ),
      ),
    );
  }

  deny(data,record) {
    Firestore.instance
        .collection('USER')
        .document(login.uid)
        .collection('NOTIFICATION')
        .document(data.documentID)
        .delete();

        Firestore.instance.collection('RELATION').document(login.uid+record.uid).delete();
  }

  accept(record, data) {
    Firestore.instance.collection('RELATION').document().setData({
      'a': login.uid,
      'b': record.uid,
      'status': 'accepted',
    });

    Firestore.instance
        .collection('USER')
        .document(login.uid)
        .collection('NOTIFICATION')
        .document(data.documentID)
        .delete();
  }
}

class Record {
  final String name;
  final String uid;

  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : name = map['text'],
        uid = map['uid'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
