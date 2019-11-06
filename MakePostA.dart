import 'package:flutter/material.dart';
// import 'package:image_picker_modern/image_picker_modern.dart';
import 'MakePostB.dart' as next;
import 'video4.dart' as video;



class MyHome extends StatefulWidget {
   String type,cname,scat,level;
   var image;
  MyHome(
      {Key key,
      
      this.image,this.type,this.cname,this.scat,this.level})
      : super(key: key);

  @override
  MyHomeState createState() => MyHomeState(image,type,cname,scat,level);
}


class MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {
  String type,cname,scat,level;
  var image;

  

  MyHomeState(this.image,this.type,this.cname,this.scat,this.level);
 
  

  @override
  void initState() {
    super.initState();

    
    
  }

  @override
  void dispose() {
    // Dispose of the Tab Controller
    
    super.dispose();
    type='f';
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: AppBar(
       
        actions: <Widget>[

          RaisedButton.icon(onPressed: (){

            if(type!='t')
            {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) {
                  return next.MyHome(image:image,type:type,cname:cname,scat:scat,level:level);
                }),
              );

            }
            else if(type=='t')
            {


               Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) {
                  return next.MyHome(type:'t',cname:cname,scat:scat,level:level);
                }),
              );
            }

          },
          icon:Icon(Icons.add_to_photos),
          label: Text("Next"),
          )
        ],
        
        backgroundColor: Colors.blue,
      ),
     body: Container(
       
child:  type!='t'?(type=='i'?Image.file(
                    image,
                    height: MediaQuery.of(context).size.height / 1.1,
                  ):video.VideoApp(video:image)):Image.asset(
                    'assets/flag.png',
                    height: MediaQuery.of(context).size.height / 1.1,
                  ),



     ),
      
      
     
    );
  }
}