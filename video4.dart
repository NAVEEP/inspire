import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'dart:io';

void main() => runApp(VideoApp());

class VideoApp extends StatefulWidget {
  final File video;
  String thumb;
  VideoApp({Key key, this.video,this.thumb}) : super(key: key);
  
  @override
  _VideoAppState createState() => _VideoAppState(video,thumb);
}

class _VideoAppState extends State<VideoApp> {
  VideoPlayerController _controller;
   File video;
   String thumb;
  _VideoAppState(this.video,this.thumb);

  @override
  void initState() {
    super.initState();
    
    _controller = VideoPlayerController.file(video)
        
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    //return MaterialApp(
      //title: 'Video Demo',
      //home: 
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
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      );
    //);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}