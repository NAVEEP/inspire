import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'MakePostB.dart' as next;
import 'main.dart' as login;


class CameraExampleHome extends StatefulWidget {
  String cname,scat,level;

  CameraExampleHome(
      {Key key,
      
      this.cname,this.scat,this.level})
      : super(key: key);


  @override
  _CameraExampleHomeState createState() {
    return _CameraExampleHomeState(cname,scat,level);
  }
}

/// Returns a suitable camera icon for [direction].
IconData getCameraLensIcon(CameraLensDirection direction) {
  switch (direction) {
    case CameraLensDirection.back:
      return Icons.camera_rear;
    case CameraLensDirection.front:
      return Icons.camera_front;
    case CameraLensDirection.external:
      return Icons.camera;
  }
  throw ArgumentError('Unknown lens direction');
}

void logError(String code, String message) =>
    print('Error: $code\nError Message: $message');

class _CameraExampleHomeState extends State<CameraExampleHome>
    with WidgetsBindingObserver {

      String cname,scat,level;

      _CameraExampleHomeState(this.cname,this.scat,this.level);
  CameraController controller;
  String imagePath;
  String videoPath;
  VideoPlayerController videoController;
  VoidCallback videoPlayerListener;
  bool enableAudio = true;
  bool empty=true;

  @override
  void initState() {
    super.initState();
   
     
     // test();
    // man();
        //  controller.description=
         WidgetsBinding.instance.addObserver(this);
       }
     
       @override
       void dispose() {
         WidgetsBinding.instance.removeObserver(this);
         super.dispose();
       }
     
       @override
       void didChangeAppLifecycleState(AppLifecycleState state) {
         if (state == AppLifecycleState.inactive) {
           controller?.dispose();
         } else if (state == AppLifecycleState.resumed) {
           if (controller != null) {
             onNewCameraSelected(controller.description);
           }
         }
       }
     
       final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
     
       @override
       Widget build(BuildContext context) {

         

         return Scaffold(

           
           key: _scaffoldKey,
          //  appBar: AppBar(
          //    iconTheme: IconThemeData(color: Colors.grey),
          //    backgroundColor: Colors.white,
          //    title: const Text('Camera example',style: TextStyle(color: Colors.grey),),
          //  ),
           body:(login.cameras.length==0)?Center(child:Text("loading..")): Column(
             children: <Widget>[
               Expanded(
                 child: Container(
                   child: Padding(
                     padding: const EdgeInsets.all(0.0),
                     child: Center(
                       child:_cameraPreviewWidget(),
                     ),
                   ),
                   decoration: BoxDecoration(
                     color: Colors.black,
                     border: Border.all(
                       color: controller != null && controller.value.isRecordingVideo
                           ? Colors.transparent
                           : Colors.grey,
                       width: 0.0,
                     ),
                   ),
                 ),
               ),
               _captureControlRowWidget(),
               _toggleAudioWidget(),
               Padding(
                 padding: const EdgeInsets.all(5.0),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                     _cameraTogglesRowWidget(),
                    //  _thumbnailWidget(),
                   ],
                 ),
               ),
             ],
           ),
         );
       }
     
       Widget _cameraPreviewWidget() {
         if (controller == null || !controller.value.isInitialized) {
           return const Text(
             'Tap a camera',
             style: TextStyle(
               color: Colors.white,
               fontSize: 24.0,
               fontWeight: FontWeight.w900,
             ),
           );
         } 
        
         else {
           return AspectRatio(
             aspectRatio: controller.value.aspectRatio,
             child: CameraPreview(controller),
           );
         }
       }
     
       Widget _toggleAudioWidget() {
         return Container();
       }
     
       Widget _thumbnailWidget() {
         return Expanded(
           child: Align(
             alignment: Alignment.centerRight,
             child: Row(
               mainAxisSize: MainAxisSize.min,
               children: <Widget>[
                 videoController == null && imagePath == null
                     ? Container()
                     : SizedBox(
                         child: (videoController == null)
                             ? Image.file(File(imagePath))
                             : Container(
                                 child: Center(
                                   child: AspectRatio(
                                       aspectRatio:
                                           videoController.value.size != null
                                               ? videoController.value.aspectRatio
                                               : 1.0,
                                       child: VideoPlayer(videoController)),
                                 ),
                                 decoration: BoxDecoration(
                                     border: Border.all(color: Colors.pink)),
                               ),
                         width: 64.0,
                         height: 64.0,
                       ),
               ],
             ),
           ),
         );
       }
     
       /// Display the control bar with buttons to take pictures and record videos.
       Widget _captureControlRowWidget() {
         return Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           mainAxisSize: MainAxisSize.max,
           children: <Widget>[
             IconButton(
               icon: const Icon(Icons.camera_alt),
               color: Colors.blue,
               onPressed: controller != null &&
                       controller.value.isInitialized &&
                       !controller.value.isRecordingVideo
                   ? onTakePictureButtonPressed
                   : null,
             ),
             IconButton(
                   icon: controller != null &&
                       controller.value.isInitialized &&
                       controller.value.isRecordingVideo? Icon(Icons.stop):Icon(Icons.fiber_manual_record),
               color: Colors.red,
               onPressed:() {controller != null &&
                       controller.value.isInitialized &&
                       controller.value.isRecordingVideo?
                        // print("1"):print("2");},
                       onStopButtonPressed():onVideoRecordButtonPressed();},
             ),
             
             
           ],
         );
       }
     
       /// Display a row of toggle to select the camera (or a message if no camera is available).
       Widget _cameraTogglesRowWidget() {
         final List<Widget> toggles = <Widget>[];
     
 
           for (CameraDescription cameraDescription in login.cameras) {
             print('1');
              print(cameraDescription);
             toggles.add(
               SizedBox(
                 width: 90.0,
                 child: RadioListTile<CameraDescription>(
                   title: Icon(getCameraLensIcon(cameraDescription.lensDirection)),
                   groupValue: controller?.description,
                   value: cameraDescription,
                   onChanged: controller != null && controller.value.isRecordingVideo
                       ? null
                       : onNewCameraSelected,
                 ),
               ),
             );
           
         }
     
         return Row(children: toggles);
       }
     
       String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
     
       void showInSnackBar(String message) {
        //  _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
       }
     
       void onNewCameraSelected(CameraDescription cameraDescription) async {
         if (controller != null) {
           await controller.dispose();
         }
         controller = CameraController(
           cameraDescription,
           ResolutionPreset.medium,
          //  enableAudio: enableAudio,
         );
     
         // If the controller is updated then update the UI.
         controller.addListener(() {
           if (mounted) setState(() {});
           if (controller.value.hasError) {
             showInSnackBar('Camera error ${controller.value.errorDescription}');
           }
         });
     
         try {
           await controller.initialize();
         } on CameraException catch (e) {
           _showCameraException(e);
         }
     
         if (mounted) {
           setState(() {});
         }
       }
     
       void onTakePictureButtonPressed() {
         takePicture().then((String filePath) {
           if (mounted) {
             setState(() {
               imagePath = filePath;
               videoController?.dispose();
               videoController = null;
             });
             if (filePath != null) 
             {
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) {
                  return next.MyHome(
                      cname: cname,
                      scat: scat,
                      level: level,
                      type: 'i',
                      image: File(filePath));
                }),
              );


             }
           }
           setState(() {
            empty=false; 
           });
         });


       }
     
       void onVideoRecordButtonPressed() {
         print("on video button ");
         startVideoRecording().then((String filePath) {
           if (mounted) setState(() {});
           if (filePath != null) 
           {

 

           }
         });
       }
     
       void onStopButtonPressed() {
         print("stop  button pressed");
         stopVideoRecording().then((_) {
           if (mounted) setState(() {});

           Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) {
                  return next.MyHome(
                      cname: cname,
                      scat: scat,
                      level: level,
                      type: 'v',
                      image: File(videoPath));
                }),
              );
           showInSnackBar('Video recorded to: $videoPath');
         });
       }
     
       Future<String> startVideoRecording() async {
         if (!controller.value.isInitialized) {
           showInSnackBar('Error: select a camera first.');
           return null;
         }
     
         final Directory extDir = await getApplicationDocumentsDirectory();
         final String dirPath = '${extDir.path}/Movies/flutter_test';
         await Directory(dirPath).create(recursive: true);
         final String filePath = '$dirPath/${timestamp()}.mp4';
     
         if (controller.value.isRecordingVideo) {
           // A recording is already started, do nothing.
           return null;
         }
     
         try {
           videoPath = filePath;
           await controller.startVideoRecording(filePath);
         } on CameraException catch (e) {
           _showCameraException(e);
           return null;
         }
         return filePath;
       }
     
       Future<void> stopVideoRecording() async {
         if (!controller.value.isRecordingVideo) {
           return null;
         }
     
         try {
           await controller.stopVideoRecording();
         } on CameraException catch (e) {
           _showCameraException(e);
           return null;
         }
     
        // await _startVideoPlayer();
       }
     
       Future<void> _startVideoPlayer() async {
         final VideoPlayerController vcontroller =
             VideoPlayerController.file(File(videoPath));
         videoPlayerListener = () {
           if (videoController != null && videoController.value.size != null) {
             // Refreshing the state to update video player with the correct ratio.
             if (mounted) setState(() {});
             videoController.removeListener(videoPlayerListener);
           }
         };
         vcontroller.addListener(videoPlayerListener);
         await vcontroller.setLooping(true);
         await vcontroller.initialize();
         await videoController?.dispose();
         if (mounted) {
           setState(() {
             imagePath = null;
             videoController = vcontroller;
           });
         }
         await vcontroller.play();
       }
     
       Future<String> takePicture() async {
         if (!controller.value.isInitialized) {
           showInSnackBar('Error: select a camera first.');
           return null;
         }
         final Directory extDir = await getApplicationDocumentsDirectory();
         final String dirPath = '${extDir.path}/Pictures/flutter_test';
         await Directory(dirPath).create(recursive: true);
         final String filePath = '$dirPath/${timestamp()}.jpg';
     
         if (controller.value.isTakingPicture) {
           // A capture is already pending, do nothing.
           return null;
         }
     
         try {
           await controller.takePicture(filePath);
         } on CameraException catch (e) {
           _showCameraException(e);
           return null;
         }
         return filePath;
       }
     
       void _showCameraException(CameraException e) {
         logError(e.code, e.description);
         showInSnackBar('Error: ${e.code}\n${e.description}');
       }
     
  //      void run() async {
  //         try {
  //   cameras = await availableCameras();
  // } on CameraException catch (e) {
  //   logError(e.code, e.description);
  // }
  //      }
}

class CameraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CameraExampleHome(),
    );
  }
}

// List<CameraDescription> cameras;



// Future<void> man() async {
//   // Fetch the available cameras before initializing the app.
//   try {
//     cameras = await availableCameras();
    
//   } on CameraException catch (e) {
//     logError(e.code, e.description);
//   }
  
// }