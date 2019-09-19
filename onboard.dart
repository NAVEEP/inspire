import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:Container(
      // height: 1000.0,
      child: PageView(
          onPageChanged: (int inr) {},
          controller: pageController,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Image.asset('assets/log.png',
                        height: MediaQuery.of(context).size.height / 1.1,
                        width: double.infinity),
                    Container(
                      color: Colors.grey[600],
                      margin: EdgeInsets.all(6.0),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).size.height / 1.1 -
                          12,
                      child: RaisedButton(
                          color: Color(0xffe73131),
                          child: Text(
                            "Get Started",
                            style: TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                          onPressed: () {
                            // initiateFacebookLogin();

                            pageController.jumpToPage(1);
                          }),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width / 6,
                      MediaQuery.of(context).size.height / 4,
                      0.0,
                      0.0),
                  child: Text(
                    "inspire",
                    textScaleFactor: 6.0,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
            SingleChildScrollView(
              
              child: Container(
                height: MediaQuery.of(context).size.height / 1.1,
                color: Colors.blueGrey,
                child:Column(
                
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  Padding(padding: EdgeInsets.only(top: 5.0)),
                  Card(
                    
                    child:Container(
                      height: MediaQuery.of(context).size.height / 1.5,
                     decoration: BoxDecoration(
                              color: Colors.grey[300],
                              shape: BoxShape.circle,
                              //border: Border.all(color: Colors.white, width: 2),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                    'assets/pablo-uploading.png',
                    
                  ) ,),
                            )),),
                  
                  
                ],
              ),),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 5.0)),
                  Card(
                    
                    child:Container(
                      height: MediaQuery.of(context).size.height / 1.5,
                     decoration: BoxDecoration(
                              color: Colors.grey[300],
                              shape: BoxShape.circle,
                              //border: Border.all(color: Colors.white, width: 2),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                    'assets/pablo-success-1.png',
                    
                  ) ,),
                            )),),
                 
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Card(
                    
                    child:Container(
                      height: MediaQuery.of(context).size.height / 1.5,
                     decoration: BoxDecoration(
                              color: Colors.grey[300],
                              shape: BoxShape.circle,
                              //border: Border.all(color: Colors.white, width: 2),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                    'assets/pablo-basketball-game.png',
                    
                  ) ,),
                            )),)
                  
                  
                  
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                   Card(
                    
                    child:Container(
                      height: MediaQuery.of(context).size.height / 1.5,
                     decoration: BoxDecoration(
                              color: Colors.grey[300],
                              shape: BoxShape.circle,
                              //border: Border.all(color: Colors.white, width: 2),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                   'assets/pablo-car-rental.png',
                    
                  ) ,),
                            )),)
                  
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Card(
                    
                    child:Container(
                      height: MediaQuery.of(context).size.height / 1.5,
                     decoration: BoxDecoration(
                              color: Colors.grey[300],
                              shape: BoxShape.circle,
                              //border: Border.all(color: Colors.white, width: 2),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                  'assets/pablo-sign-in.png',
                    
                  ) ,),
                            )),),
                  
                  
                  Container(
                    margin: EdgeInsets.all(6.0),
                    height: 25.0,
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                        color: Color(0xffe73131),
                        child: Text(
                          "Login with Facebook",
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                        onPressed: () {
                          
                          // pageController.jumpToPage(1);
                        }),
                  ),
                ],
              ),
            ),
          ]),
    ),
      
    );
  }
}