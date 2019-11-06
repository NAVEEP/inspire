import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:example/people_new.dart';
import 'package:flutter/material.dart';
import 'profile.dart' as profile;
import 'video3.dart' as video;
import 'main.dart' as login;
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:flutter_advanced_networkimage/provider.dart';

int r;
double ating = 0.0;
double current;

class Post {
  double dou;
  int stars;
  int rating;
  int nopr;

  final String uname;
  final String cname;
  final String ctag;
  final String level;
  final String scat;
  final String uid;
  final String body;
  final String user_url;
  final String media_url;
  final String mtype;
  final String id;

  final DateTime datetime;

  Post({
    this.uname,
    this.cname,
    this.ctag,
    this.level,
    this.scat,
    this.uid,
    this.body,
    this.user_url,
    this.media_url,
    this.mtype,
    this.datetime,
    this.dou,
    this.stars,
    this.rating,
    this.nopr,
    this.id,
  });

  factory Post.fromDocument(DocumentSnapshot document) {
    current = document['dou'];
    return new Post(
      body: document['body'],
      dou: document['dou'],
      uname: document['uname'],
      uid: document['uid'],
      cname: document['cname'],
      level: document['level'],
      scat: document['scat'],
      ctag: document['ctag'],
      mtype: document['mtype'],
      media_url: document['media_url'],
      user_url: document['user_url'],
      datetime: document['timestamp'].toDate(),
      stars: document['stars'],
      rating: document['rating'],
      nopr: document['nopr'],
      id: document.documentID,
    );
  }
}

class MyHomePage extends StatefulWidget {
  DocumentSnapshot snap;
  MyHomePage({Key key, this.snap}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState(snaps: snap);
}

class _MyHomePageState extends State<MyHomePage> {
  bool exist = false;
  bool loading = true;
  bool reveal = false;
  DocumentSnapshot snaps;
  _MyHomePageState({Key key, this.snaps});
  void initState() {
    super.initState();
    current = 0.0;
    ating = 0.0;
    loading = true;
  }

  Widget build(BuildContext context) {
    // print(loading);
    Post post;

    post = Post.fromDocument(snaps);

    if (!loading) {
      print(loading);
      print("rloading");
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          color: Colors.grey[300],
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 2.0,
              // borderRadius: BorderRadius.circular(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 30, 10, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 61.0,
                          height: 61.0,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(post.user_url)),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.all(5),
                            child: GestureDetector(
                              onTap: () {
                                print(post.uid);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => profile.MyApp(
                                            uid: post.uid,
                                          )),
                                );
                              },
                              child: Container(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    post.uname,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Open Sans',
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(0),
                                    child: Text(
                                      timediff(post),
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Open Sans',
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                            )),
                        Spacer(),
                      ],
                    ),
                  ),
                  post.body == ""
                      ? Container(height: 5)
                      : Padding(
                          padding: EdgeInsets.fromLTRB(25, 10, 10, 10),
                          child: Text(
                            post.body,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Segoe UI',
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 3, 15, 3),
                    child: FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "#level " + post.level.toUpperCase(),
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Open Sans',
                                color: Color(0xff2284a1)),
                          ),
                          Text(
                            '  #' + post.cname,
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Open Sans',
                                color: Color(0xff2284a1)),
                          ),
                          Text(
                            '  #' + post.scat,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Segoe UI',
                              color: Color(0xff2284a1),
                            ),
                          ),
                        ],
                      ),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  Material(
                    elevation: 2.0,
                    borderRadius: BorderRadius.circular(0),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(0),
                          child: Stack(
                            children: [
                              Container(
                                  padding: EdgeInsets.all(0),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                  child: (post.mtype == 'v')
                                      ? Container(
                                          padding: EdgeInsets.all(0),
                                          height: 400,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                          ),
                                          child: video.VideoApp(
                                              url: post.media_url))
                                      : FadeInImage(
                                          image: NetworkImage(post.media_url),
                                          placeholder:
                                              AssetImage('assets/template.jpg'),
                                          fit: BoxFit.cover,
                                        )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  height: 1.0,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.grey[300]),
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.all(0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 0.0, 20.0, 15.0),
                                  child: row(post, current),
                                ),
                              ],
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        
      );
    }
  }

  void rat(Post post) {
    print(ating.toString());
    double tot;
    int toot;
    tot = post.dou * post.nopr;
    tot = tot + ating;
    post.nopr++;
    tot = (tot / post.nopr);
    tot = tot * 100;
    toot = tot.round();
    tot = toot / 100;
    Firestore.instance
        .collection("POST")
        .document(snaps.documentID)
        .updateData({
      "dou": tot,
      "nopr": post.nopr,
    });
    Firestore.instance.collection("RATING").add(
        {"user": login.uid, "post": snaps.documentID, "rating": ating.round()});
    print('The post has been  rated');
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('The post has been  rated'),
      duration: Duration(seconds: 2),
    ));
  }

  row(Post post, double curre) {
    if (curre == 0.01) curre = 0;
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        // star(),
        // extended(),
        // extended1(post),
        Container(
            child: Column(
          children: <Widget>[
          (!reveal)?  Icon(
              Icons.star,
              size: 33,
              color: Colors.grey[500],
            ):Container(),
           (!reveal)? Text(
              curre.toString(),
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                fontFamily: 'Open Sans',
                color: Colors.grey[600],
              ),
            ):Container(),
            extended(post),
          ],
        )),
        extended1(post)
      ],
    );
  }

  star() {
    return GestureDetector(
        onTap: () {
          setState(() {
            reveal = !reveal;
            ating = 0;
          });
        },
        child: Icon(
          Icons.star,
          size: 33,
          color: Colors.grey[500],
        ));
  }

  extended(post) {
    if (!reveal) {
      return Container();
    } else {
      return SmoothStarRating(
        borderColor: Colors.grey[600],
        // color: Color(0xffffbf00),
        color: Color(0xff2284a1),
        allowHalfRating: false,
        rating: ating,
        size: 40.0,
        starCount: 5,
        spacing: 2.0,
        onRatingChanged: (value) async {
          setState(() {
            ating = value;
          });

     Timer(Duration(seconds: 1), (){

           setState(() {
          reveal = !reveal;
        });
         });
           print("ontap");
        
        final QuerySnapshot result = await Firestore.instance
            .collection('RATING')
            .where('user', isEqualTo: login.uid)
            .where('post', isEqualTo: post.id)
            .limit(1)
            .getDocuments();
        final List<DocumentSnapshot> documents = result.documents;
        if (documents.length == 1) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('You  have already Rated this post'),
            duration: Duration(seconds: 2),
          ));
          print("nope");
        } else {
          rat(post);
        }




        },
      );
    }
  }

  extended1(Post post) {
    if (reveal) {
      return Container();
    }
    return GestureDetector(
      onTap: () async {
        print("ontap");
        setState(() {
          reveal = !reveal;
        });
        final QuerySnapshot result = await Firestore.instance
            .collection('RATING')
            .where('user', isEqualTo: login.uid)
            .where('post', isEqualTo: post.id)
            .limit(1)
            .getDocuments();
        final List<DocumentSnapshot> documents = result.documents;
        if (documents.length == 1) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('You  have already Rated this post'),
            duration: Duration(seconds: 2),
          ));
          print("nope");
        } else {
          rat(post);
        }
      },
      child: Text(
        "RATE",
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          fontFamily: 'Open Sans',
          color: Colors.grey[600],
        ),
      ),
    );
  }

  timediff(post) {
    int th = DateTime.now().difference(post.datetime).inHours;
    int td = DateTime.now().difference(post.datetime).inDays;
    double week = td / 7;
    int tw = week.round();
    if (th < 24) {
      if (th == 0)
        return "just now";
      else if (th == 1)
        return "1 hour ago";
      else
        return th.toString() + " hours ago";
    } else if (td < 7) {
      if (td == 1)
        return "1 day ago";
      else
        return td.toString() + " days ago";
    } else {
      if (tw == 1)
        return "1 week ago";
      else
        return tw.toString() + " weeks ago";
    }
  }
}
