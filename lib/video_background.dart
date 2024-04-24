import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoBG extends StatefulWidget {
  @override
  VideoBGState createState() => VideoBGState();
}

class VideoBGState extends State<VideoBG> {
  VideoPlayerController _controller;

  // Future<ClosedCaptionFile> _loadCaptions() async {
  //   final String fileContents = await DefaultAssetBundle.of(context)
  //       .loadString('assets/bumble_bee_captions.srt');
  //   return SubRipCaptionFile(fileContents);
  // }

  @override
  void initState() {
    super.initState();
    // _controller = VideoPlayerController.network(

    //   'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    _controller = VideoPlayerController.asset('assets/videos/covid2.mp4');
    // closedCaptionFile: _loadCaptions(),
    // videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),

    _controller.addListener(() {
      setState(() {});
    });

    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // fit: StackFit.expand,
        children: <Widget>[
          SizedBox.expand(
            child: FittedBox(
              alignment: Alignment(-0.03, 0),
              fit: BoxFit.fitHeight,
              child: SizedBox(
                // width: _controller.value.size?.width ?? 0,

                height: _controller.value.size?.height ?? 0,
                width: 800,
                // height: 600,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
