import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'post2.dart' as post;
import 'main.dart' as login;
import 'profile.dart' as profile;

void main() {
  runApp(MyHomePage());
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState();
  int index=0;
  int count=0;
   List fin=[];
  var subcat = List<String>();
  void initState(){
    super.initState();
    index=1;
    count=0;
    subcat=['All'];
    //list("Guitar");
  }
        Widget build(BuildContext context) {
          subcat=[];
          count=0;
          return StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('USER').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return Scaffold(body: Center(child: CircularProgressIndicator()));
                if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Scaffold(body: Center(child: Text('Loading...')));
                  default:
                    return Scaffold(
                        appBar: AppBar(
                          iconTheme: IconThemeData(color: Colors.grey[800]),
                          textTheme: TextTheme(
                            title: TextStyle(color: Color(0XFF9C9C9C), fontSize: 23),
                          ),
                          backgroundColor: Colors.white,
                          title: Text("Discover people "),
                        ),
                        body: Column(
                          children: <Widget>[
                           Flexible(
                             flex: 2,
                             child: row(),
                           ),
                          index==0?  Flexible(
                              flex: 18,
                              child: Container(
                                height: login.height,
                                color: Colors.grey[100],
                                child: GridView.count(
                                  crossAxisCount: 2,
                                  // gridDelegate: SliverGridDelegate(),
                                  children: snapshot.data.documents
                                      .map((DocumentSnapshot document) {
                                    String uiid = document["uid"];
                                    int n = document["ins"];
                                    return Tile(document, n, uiid);
                                  }).toList(),
                                ),
                              ),
                            )://Container()
                            list(),
                          ],
                        ));
                }
              });
        }

        fetchitems() async{

          print("inside fetchitems");
         
         var list= await Firestore.instance.collectionGroup('UCHALLENGES').where('scat',isEqualTo: "Guitar").getDocuments();
          print("got list");
         fint(var list) async{

           print("inside fint");
            for (var a in list.documents)
          {
              var snap=await  Firestore.instance.collection("USER").document(a['uid']).get();
              print(snap.data);
              fin.add(snap);

              print("add");

          }

         }
          print("before fint");
         await fint(list);

          
  print("after fint");
          // setState(() {

          //   print("inside set state");
            
          // });

          print("before return");

          return fin;

        }
        list()
        {
           print("inside list");
          // Firestore.instance.collectionGroup('UCHALLENGES').where('scat',isEqualTo: "Guitar").getDocuments().then((doc){
          //   print("jh");

          
          //   for (var a in doc.documents)
          //   {
          //       print("a");
          //        Firestore.instance.collection("USER").document(a['uid']).get().then((docu){
          //                         print("b");
          //                               print(docu['uName']);
          //                              // return Container();
          //                              //return Tile(doc, doc['ins'], doc['uid']);
          //                            });
          //   }
          // });
          // return Center(child:Text("hye"));
          return FutureBuilder(
    future: fetchitems(),
    builder:(context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
         } else {
           print("inside flexible");
            return Flexible(
                              flex: 18,
                              child: Container(
                                height: login.height,
                                color: Colors.grey[100],
                                child: GridView.count(
                                  crossAxisCount: 2,
                                  // gridDelegate: SliverGridDelegate(),
                                  children: snapshot.data.documents
                                      .map((DocumentSnapshot document) {
                                        print("document ka");
                                                                            String uiid = document["uid"];
                                    int n = document["ins"];
                                    print(uiid);

                                    return Tile(document, n, uiid);
                                  }).toList(),
                                ),
                              ),
                            );
         }
     }
);
          
          //  return StreamBuilder<QuerySnapshot>(
          //     stream: Firestore.instance.collectionGroup('UCHALLENGES').where('scat',isEqualTo: "Guitar").snapshots(),
          //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //       if (!snapshot.hasData)
          //         return Scaffold(body: Center(child: CircularProgressIndicator()));
          //       if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          //       switch (snapshot.connectionState) {
          //         case ConnectionState.waiting:
          //           return Scaffold(body: Center(child: Text('Loading...')));
          //         default: print("default");
          //         return Scaffold(
          //             body: Flexible(
          //                     flex: 18,
          //                     child: Container(
          //                       height: login.height,
          //                       color: Colors.grey[100],
          //                       child: GridView.count(
          //                         crossAxisCount: 2,
                                 
          //                        children:
          //                          snapshot.data.documents
          //                             .map((DocumentSnapshot document) {
                                    
          //                               print(document.data);
          //                                Firestore.instance.collection("USER").document(document['uid']).get().then((docu){
          //                        // print("b");
          //                        print(docu.data);
          //                               print(docu['uName']);
          //                               print(docu['uid']);
          //                               print(docu['ins']);                                       // return Container();
                                      

          //                              // return Container(child:Text(docu['uName']));
                                      
          //                            });

          //                              return Container(width: 80.0,
          //       height: 80.0,
          //       child:Text("hye"),
          //                              );
                                   
                                    
          //                         }).toList(),
                                 
          //                       ),
          //                     ),
          //                   ),

                      
                    
          //         );
                    
          //       }
          //     });
        }
        
        
      row1() {
          return StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collectionGroup('UCHALLENGES').where('scat',isEqualTo: "Guitar").snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return Scaffold(body: Center(child: CircularProgressIndicator()));
                if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Scaffold(body: Center(child: Text('Loading...')));
                  default:
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child:Row(
                      children:
                          snapshot.data.documents.map((DocumentSnapshot document) {
                        // return Tile(document,n,uiid);
                        // await Firestore.instance.collection("USER").document()
                        return Tile(document,0,"11");
                       
                        // print(subcat);
                      }).toList(),
                    ),);
                }
              });
        }
        row() {
          return StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('SUBCAT').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return Scaffold(body: Center(child: CircularProgressIndicator()));
                if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Scaffold(body: Center(child: Text('Loading...')));
                  default:
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child:Row(
                      children:
                          snapshot.data.documents.map((DocumentSnapshot document) {
                        // return Tile(document,n,uiid);

                        count++;
                        
                         subcat.add(document.documentID);
                         print(subcat);
                        return button(document.documentID,count);
                       
                        // print(subcat);
                      }).toList(),
                    ),);
                }
              });
        }
       Widget button(name,count){
           return Padding(
      padding: EdgeInsets.all(8),
      child: InkWell(
        onTap: (){
          // setState(() {
          //   index=count;
          // });
        },
        child:Container(
        padding: EdgeInsets.fromLTRB(15,10,15,10),
        // height: 50,
        // width: 100,
        child: Text(name+"  "+count.toString()),
        decoration: BoxDecoration(

          color: Colors.white,
          border: Border.all(width: 0.5),
          borderRadius: new BorderRadius.all(Radius.elliptical(20, 20)),
        ),
      ),),
    );
        }
      
        }
        class Tilenew extends StatefulWidget {
          DocumentSnapshot doc;
          Tilenew(this.doc);

          @override
          _TilenewState createState() => _TilenewState(doc);
        }
        
        class _TilenewState extends State<Tilenew> {
          DocumentSnapshot doc;
          _TilenewState(this.doc);
          @override
          Widget build(BuildContext context) {
            print("inside til1new");
            return FutureBuilder(
              future:  Firestore.instance.collection("USER").document(doc['uid']).get(),
               builder: (BuildContext context, AsyncSnapshot snapshot) {
                 print("inside builder");
            if (snapshot.hasData) {
              if (snapshot.data!=null) {

                print("before returning");
                return Padding(
      padding: EdgeInsets.fromLTRB(2, 5, 2, 5),
      child: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
            context,
            new MaterialPageRoute(builder: (context) {
              return profile.MyApp(uid: snapshot.data['uid']);
            }),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(
              style: BorderStyle.none,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(snapshot.data['photoURL']),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  snapshot.data['uName'],
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(0),
                child: Text(
                  'Inspiring'+snapshot.data['ins']+'people' ?? "",
                  style: TextStyle(fontWeight: FontWeight.w200, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
             } } else {
                return new Container(width: 80.0,
                height: 80.0,child:CircularProgressIndicator());
             // },
             }
               }    
           );
          }}

class Tile extends StatelessWidget {
  DocumentSnapshot document;
  int n;
  String uiid;
  Tile(this.document, this.n, this.uiid);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(2, 5, 2, 5),
      child: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
            context,
            new MaterialPageRoute(builder: (context) {
              return profile.MyApp(uid: uiid);
            }),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(
              style: BorderStyle.none,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(document['photoURL']),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  document['uName'],
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(0),
                child: Text(
                  'Inspiring $n people' ?? "",
                  style: TextStyle(fontWeight: FontWeight.w200, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class Button extends StatelessWidget {
  String name;
  Button(this.name);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: InkWell(
        onTap: (){
          
        },
        child:Container(
        padding: EdgeInsets.fromLTRB(15,10,15,10),
        // height: 50,
        // width: 100,
        child: Text(name),
        decoration: BoxDecoration(

          color: Colors.white,
          border: Border.all(width: 0.5),
          borderRadius: new BorderRadius.all(Radius.elliptical(20, 20)),
        ),
      ),),
    );
  }
}

