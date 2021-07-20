import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutCovid extends StatefulWidget {
  @override
  _AboutCovidState createState() => _AboutCovidState();
}

class _AboutCovidState extends State<AboutCovid> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late VideoPlayerController _controller2;

  @override
  void initState() {
    // TODO: implement initState
    _controller2 = VideoPlayerController.asset("assets/videos/covid.mkv");
    _controller2.initialize().then((_) => setState(() {}));
    getData();
    super.initState();
  }

  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/info/info.txt');
  }

  String info = 'Loading....';

  void getData() async {
    info = await loadAsset();
    print(info);
  }

  @override
  void dispose() {
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("About Covid-19"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.showSnackBar(
                SnackBar(content: Text(
                  'https://www.who.int/emergencies/diseases/novel-coronavirus-2019',
                  textAlign: TextAlign.center,
                ),action: SnackBarAction(
                  label: 'Open',
                  onPressed: ()=> launch('https://www.who.int/emergencies/diseases/novel-coronavirus-2019'),
                ),),
              );
            },
            icon: Icon(Icons.info_outline),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            playVideo(_controller2),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                info,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container playVideo(VideoPlayerController controller) {
    return Container(
      padding: EdgeInsets.all(5),
      child: AspectRatio(
        aspectRatio: _controller2.value.aspectRatio,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            VideoPlayer(controller),
            ClosedCaption(text: controller.value.caption.text),
            _PlayPauseOverlay(controller: controller),
            VideoProgressIndicator(controller, allowScrubbing: true),
          ],
        ),
      ),
    );
  }
}

class _PlayPauseOverlay extends StatefulWidget {
  const _PlayPauseOverlay({Key? key, required this.controller})
      : super(key: key);

  final VideoPlayerController controller;

  @override
  __PlayPauseOverlayState createState() => __PlayPauseOverlayState();
}

class __PlayPauseOverlayState extends State<_PlayPauseOverlay> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: widget.controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_circle_outline,
                      color: Colors.white,
                      size: 100.0,
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            setState(
              () {
                widget.controller.value.isPlaying
                    ? widget.controller.pause()
                    : widget.controller.play();
              },
            );
          },
        ),
      ],
    );
  }
}
