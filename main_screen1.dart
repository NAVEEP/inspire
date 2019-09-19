import 'package:flutter/material.dart';
import 'challenges3.dart' as challenge;
import 'stats4.dart' as stats;
import 'search.dart' as search;
import 'notification.dart' as notif;
import 'drawer.dart' as drawer;
import 'home2.dart' as feed1;
import 'home3.dart' as feed;
import 'widget_image.dart' as w;
//import 'package:swipedetector/swipedetector.dart';
//import 'adv.dart' as adv;


bool appbar=true;
class TabsDemoScreen extends StatefulWidget {
  // String uname;
  TabsDemoScreen();

  @override
  TabsDemoScreenState createState() => TabsDemoScreenState();
}

class TabsDemoScreenState extends State<TabsDemoScreen> {
  // String uname;
  TabsDemoScreenState();
  int currentTabIndex = 0;

  // List<Widget> tabs = [
  //   challenge.MyHomePage(),
  //   Fed(),
  //   stats.MyApp(),
  // ];
  
  
  @override
  Widget build(BuildContext context) {
    // int currentTabIndex = 0;
     List<Widget> tabs = [
    challenge.MyHomePage(),
    Fed(),
    stats.MyApp(),
  ];
    var scaffold = Scaffold(
        //drawer
        body: tabs[currentTabIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTapped,
          currentIndex: currentTabIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.outlined_flag),
              title: Text("Challenges"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.web),
              title: Text("Feed"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sort),
              title: Text("Stats"),
            )
          ],
        ));
    return MaterialApp(
      theme: ThemeData(primaryColor: Color(0xffe73131),),
      home: scaffold,
    );
  }

  onTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }
}

class Fed extends StatefulWidget {
  Fed({
    Key key,
  }) : super(key: key);

  @override
  FedState createState() => FedState();
}

class FedState extends State<Fed> with TickerProviderStateMixin {
  @override

  @override
 
TabController _tabController;
ScrollController _scrollViewController;

@override
  void initState() {
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
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Color(0xffe73131),),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          
           
            body: NestedScrollView(
              controller: _scrollViewController,
              headerSliverBuilder: (BuildContext context, bool boxIsScrolled){

                return [
                  
                  SliverAppBar(title: Text("hgjh"),
                  //drawer:drawer.drawer(context),
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


            body:
               
              TabBarView(
              children: <Widget>[
             // crop.ImageCapture(),
               feed.MyHomePage(),
                
                //adv.MyApp(),
                feed1.MyHomePage(),
               
                
              ],
              controller: _tabController,
            ),)
    ))
    );
  }
}
