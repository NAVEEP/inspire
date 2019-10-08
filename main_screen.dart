import 'package:flutter/material.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'challenges3.dart' as challenge;
import 'stats4.dart' as stats;
import 'search.dart' as search;
import 'notification.dart' as notif;
import 'drawer.dart' as drawer;
import 'home2.dart' as feed1;
import 'home3.dart' as feed;
//import 'package:firebase_analytics/observer.dart';
import 'main.dart' as login;
import 'feed.dart' as ms1;
//import 'widget_image.dart' as w;
//import 'media.dart' as share;
import 'share.dart' as share;
import 'camera.dart' as camera;
import 'gallery.dart' as gallery;
import 'camera_video.dart' as video;
import 'onboard.dart' as onboard;
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

final feature1 = "FEATURE_1";
final feature2 = "FEATURE_2";


class TabsDemoScreen extends StatefulWidget {

  FirebaseAnalytics analytics;
FirebaseAnalyticsObserver observer;

TabsDemoScreen({this.analytics,this.observer});

  // String uname;
  

  @override
  TabsDemoScreenState createState() => TabsDemoScreenState(analytics: analytics,observer: observer);
}

class TabsDemoScreenState extends State<TabsDemoScreen> {

  FirebaseAnalytics analytics;
FirebaseAnalyticsObserver observer;

TabsDemoScreenState({this.analytics,this.observer});
  // String uname;
  //TabsDemoScreenState();
 int currentTabIndex =0;
  void initState() {
    
     currentTabIndex = 0;
    super.initState();
  }
  
  Widget get bottomNavigationBar {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(10),
        topLeft: Radius.circular(10),
      ),
      child:BottomNavigationBar(
          elevation: 100.0,
          //backgroundColor: Colors.blueGrey[50],

          onTap: onTapped,
          currentIndex: currentTabIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.outlined_flag,size: 30.0,),
              title: Text("Challenges",style: TextStyle(fontSize:11.0),),
              backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.web,size: 30.0,),
              title: Text("Feed",style: TextStyle(fontSize:11.0)),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sort,size: 30.0,),
              title: Text("Stats",style: TextStyle(fontSize:11.0)),
            )
          ],
      ),);
      
      
      
      }

  @override
  Widget build(BuildContext context) {
     List<Widget> tabs = [
    challenge.MyHomePage(),
    ms1.MyHomePage(),
    stats.MyHomePage(),

  ];
  
    var scaffold = Scaffold(
      
        body: SafeArea(child:Stack(
        children: <Widget>[
          tabs[currentTabIndex],
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: bottomNavigationBar,
          ),
        ],
      ),),);
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

// class Fed extends StatefulWidget {
//   Fed({
//     Key key,
//   }) : super(key: key);

//   @override
//   FedState createState() => FedState();
// }

// class FedState extends State<Fed> with TickerProviderStateMixin {

//   void initState() {
    

//     super.initState();
  

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       FeatureDiscovery.discoverFeatures(
//         context,
//         [ feature1, feature2],
//       );
//     });
//   }
//   @override

//   Widget build(BuildContext context) {
//     return MaterialApp(
//   //     navigatorObservers: [
//   //   FirebaseAnalyticsObserver(analytics: login.analytics),
//   // ],
//       theme: ThemeData(primaryColor: Color(0xffe73131),),
//       home: SafeArea(child:DefaultTabController(
//         length: 2,
//         child: Scaffold(
//             drawer: drawer.drawer(context),
//             appBar: AppBar(
//               iconTheme: new IconThemeData(color: Colors.grey[800]),
//               title: Text(
//                 'Feed',
//                 style: TextStyle(color: Color(0XFF9C9C9C), fontSize: 20),
//               ),
//               backgroundColor: Colors.grey[50],
//               actions: <Widget>[
//                 DescribedFeatureOverlay(
//                   featureId: feature2,
//                 icon: Icons.print,
//                 color: Colors.purple,
//                 contentLocation: ContentOrientation.below,
//                 title: 'Just how you want it',
//                 description:
//                     'Tap the menu icon to switch account',

//                 child:IconButton(
//                     icon: Icon(
//                       Icons.search,
//                       color: Color(0XFF9C9C9C),
//                     ),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => search.SearchPage()),
//                       );
//                     }),),
//                 IconButton(
//                   icon: Icon(
//                     Icons.notifications,
//                     color: Color(0XFF9C9C9C),
//                   ),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => notif.MyHomePage()),
//                     );
//                   },
//                 ),
//               ],
//               bottom: TabBar(
                
//                 unselectedLabelColor: Colors.black,
//                 labelColor: Colors.black,
//                 tabs: <Widget>[
                  
//                   Tab(
//                     child: Text('Following',
//                         style: TextStyle(color: Colors.grey[800])),
//                   ),
//                   Tab(
//                     child: Text('Global',
//                         style: TextStyle(color: Colors.grey[800])),
//                   ),
//                 ],
//               ),
//             ),
//             body: SafeArea(
//             // DescribedFeatureOverlay(
//             // featureId: feature1,
//             //     icon: Icons.print,
//             //     color: Colors.purple,
//             //     contentLocation: ContentOrientation.below,
//             //     title: 'Just how you want it',
//             //     description:
//             //         'Tap the menu icon to switch account',
//              child: TabBarView(
//               children: <Widget>[
//                feed.Feed(),
//                //w.MyHomePage(),
//                feed1.MyHomePage()
//               ],
//             )),),
            
//            // )
//       ),
//     ),);
//   }
// }
