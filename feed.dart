import 'package:flutter/material.dart';
import 'challenges3.dart' as challenge;
import 'stats4.dart' as stats;
import 'search.dart' as search;
import 'notification.dart' as notif;
import 'drawer.dart' as drawer;
import 'home2.dart' as home2;
import 'home3.dart' as home3;
import 'package:firebase_analytics/observer.dart';
import 'main.dart' as login;
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollViewController;
  ScrollController control;
  bool up = false;
  @override
  void initState() {
    control = ScrollController();
    // control.addListener(_scrollListener);
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollViewController.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer.drawer(context),
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: true,
              floating: true,
              iconTheme: new IconThemeData(color: Colors.grey[800]),
              title: Text(
                'Feed',
                style: TextStyle(color: Color(0XFF9C9C9C), fontSize: 20.0),
              ),
              backgroundColor: Colors.grey[50],
              actions: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Color(0XFF9C9C9C),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => search.SearchPage()),
                      );
                    }),
                IconButton(
                  icon: Icon(
                    Icons.notifications,
                    //  not(),
                    color: Color(0XFF9C9C9C),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => notif.MyHomePage()),
                    );
                  },
                ),
              ],
              forceElevated: boxIsScrolled,
              bottom: TabBar(
                unselectedLabelColor: Colors.black,
                labelColor: Colors.black,
                tabs: <Widget>[
                  Tab(
                    child: Text('Following',
                        style: TextStyle(color: Colors.grey[800])),
                  ),
                  Tab(
                    child: Text('Global',
                        style: TextStyle(color: Colors.grey[800])),
                  ),
                ],
                controller: _tabController,
              ),
            )
          ];
        },
        body: TabBarView(
          children: <Widget>[
            home3.Feed(), 
          home2.MyHomePage(),
          ],
          controller: _tabController,
        ),
      ),
    );
  }

}
