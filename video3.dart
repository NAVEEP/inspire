import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

void main() => runApp(VideoApp());

class VideoApp extends StatefulWidget {
  final String url;
   VideoApp({Key key, this.url}) : super(key: key);
  
  @override
  _VideoAppState createState() => _VideoAppState(url);
}

class _VideoAppState extends State<VideoApp> {
  final String url;
   _VideoAppState(this.url);

  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    
    _controller = VideoPlayerController.network(
        url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    //return MaterialApp(
     // title: 'Video Demo',
      return Scaffold(
        body: Center(
          child: _controller.value.initialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
        ),
        floatingActionButton: FloatingActionButton(
         // foregroundColor: Colors.deepOrange,
        // CircleBorder(radius:BorderRadius.circular(2.0)),
         backgroundColor: Colors.white70,
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,color: Colors.blue,size: 50.0,
          ),
        ),
      
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}