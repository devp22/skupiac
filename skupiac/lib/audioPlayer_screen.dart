// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:skupiac/reusable_widgets.dart';
// import 'package:audioplayers/audioplayers.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
// ignore: depend_on_referenced_packages
import 'package:rxdart/rxdart.dart';

class ThisAudioPlayer extends StatefulWidget {
  final String nameOfSong;
  final String artist;
  final String url;
  final int durationmin;
  final int durationsec;
  // final int numberOfSong;
  // ignore: use_key_in_widget_constructors
  const ThisAudioPlayer({
    required this.nameOfSong,
    required this.artist,
    required this.url,
    required this.durationmin,
    required this.durationsec,
  }) : super();

  @override
  State<ThisAudioPlayer> createState() => _ThisAudioPlayerState();
}

class _ThisAudioPlayerState extends State<ThisAudioPlayer> {
  late String nameOfSong = widget.nameOfSong;
  late String artist = widget.artist;
  late String url = widget.url;
  late Stream<DurationState> _durationState;
  final _player = AudioPlayer();
  late int durationmin = widget.durationmin;
  late int durationsec = widget.durationsec;
  late int total_duration = (durationmin * 60) + durationsec;
  Duration skipto = const Duration(seconds: 5);
  Duration progressk = const Duration(seconds: 0);
  bool isplaying = true;
  IconData playbtn = Icons.pause;
  Duration zero = const Duration(seconds: 0);
  @override
  void initState() {
    _player.setUrl(url);
    _player.play();
    super.initState();
    _durationState = Rx.combineLatest2<Duration, PlaybackEvent, DurationState>(
        _player.positionStream,
        _player.playbackEventStream,
        (position, playbackEvent) => DurationState(
              progress: position,
              buffered: playbackEvent.bufferedPosition,
              total: playbackEvent.duration,
            ));
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool k = durationsec < 10;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: dp_lineargradient(Alignment.topLeft, Alignment.bottomRight,
              Colors.redAccent, Colors.blueAccent),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.20,
            ),
            Center(
              child: Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage(
                      "assets/images/music.png",
                    ),
                  ),
                  border: Border.all(
                    style: BorderStyle.solid,
                    width: 5,
                  ),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Center(
              child: Column(
                children: [
                  Text(
                    nameOfSong,
                    style: TextStyle(
                      fontFamily: "Georgia",
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  _progressBar(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.all(5),
                        child: FloatingActionButton.extended(
                          heroTag: "previousButton",
                          onPressed: () {
                            setState(() {
                              if (progressk <= zero) {
                                progressk = zero;
                              } else {
                                progressk = progressk - skipto;
                              }
                              _player.seek(progressk);
                            });
                          },
                          icon: Icon(
                            Icons.skip_previous,
                            size: 30,
                            color: Colors.black,
                          ),
                          backgroundColor: Colors.grey,
                          label: Text("-5 sec."),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: FloatingActionButton(
                          heroTag: "pause/playButton",
                          child: Icon(
                            playbtn,
                            size: 30,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            if (isplaying == true) {
                              setState(() {
                                playbtn = Icons.play_arrow;
                                isplaying = false;
                                _player.pause();
                              });
                            } else {
                              setState(() {
                                playbtn = Icons.pause;
                                isplaying = true;
                                _player.play();
                              });
                            }
                          },
                          backgroundColor: Colors.grey,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        child: FloatingActionButton.extended(
                          heroTag: "nextButton",
                          onPressed: () {
                            setState(() {
                              progressk = progressk + skipto;
                              _player.seek(progressk);
                            });
                          },
                          icon: Icon(
                            Icons.skip_next,
                            size: 30,
                            color: Colors.black,
                          ),
                          backgroundColor: Colors.grey,
                          label: Text("+5 sec."),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  StreamBuilder<DurationState> _progressBar() {
    return StreamBuilder<DurationState>(
      stream: _durationState,
      builder: (context, snapshot) {
        final durationState = snapshot.data;
        var progress = durationState?.progress ?? Duration.zero;
        final buffered = durationState?.buffered ?? Duration.zero;
        final total = durationState?.total ?? Duration.zero;
        return ProgressBar(
          progress: progressk,
          buffered: buffered,
          total: total,
          onSeek: (duration) {
            setState(() {
              progressk = duration;
              _player.seek(progressk);
            });
          },
          onDragUpdate: (details) {
            debugPrint('${details.timeStamp}, ${details.localPosition}');
          },
        );
      },
    );
  }
}

class DurationState {
  const DurationState({
    required this.progress,
    required this.buffered,
    this.total,
  });
  final Duration progress;
  final Duration buffered;
  final Duration? total;
}
