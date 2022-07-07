import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:skupiac/audioPlayer_screen.dart';
import 'reusable_widgets.dart';

class Playlist extends StatefulWidget {
  final String playlistName;
  const Playlist({required this.playlistName}) : super();

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  List _items = [];
  late String nameofPlaylist = widget.playlistName;
  int _page = 0;
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/songs.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["songs"];
    });
  }

  void initState() {
    super.initState();
    readJson();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: dp_lineargradient(Alignment.topLeft, Alignment.bottomRight,
              Colors.redAccent, Colors.blueAccent),
        ),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: Row(
                children: [
                  _items.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: _items.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () => {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ThisAudioPlayer(
                                        nameOfSong: _items[index]["NameOfSong"],
                                        artist: _items[index]["Artist"],
                                        url: _items[index]["url"],
                                        durationmin: _items[index]
                                            ["DurationMin"],
                                        durationsec: _items[index]
                                            ["DurationSec"],
                                        // numberOfSong: _items[index]["Number"],
                                      ),
                                    ),
                                  ),
                                },
                                child: Container(
                                  constraints: BoxConstraints(
                                      maxWidth: 350, minWidth: 250),
                                  // padding:
                                  //     const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    gradient: dp_lineargradient(
                                      Alignment.topLeft,
                                      Alignment.bottomRight,
                                      Colors.tealAccent,
                                      Colors.lightGreen,
                                    ),
                                    border: Border.all(
                                      width: 2.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text("${_items[index]["NameOfSong"]}",
                                              maxLines: 1,
                                              softWrap: true,
                                              overflow: TextOverflow.fade,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic,
                                                fontFamily: "Times New Roman",
                                              ),
                                              textAlign: TextAlign.left),
                                          Row(
                                            children: [
                                              Text(
                                                "Artist: ",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textAlign: TextAlign.left,
                                              ),
                                              Text("${_items[index]["Artist"]}",
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                  textAlign: TextAlign.left),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Duration: ",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textAlign: TextAlign.left,
                                              ),
                                              (_items[index]["DurationSec"] <
                                                      10)
                                                  ? Text(
                                                      "${_items[index]["DurationMin"]}:0${_items[index]["DurationSec"]}",
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                      textAlign: TextAlign.left)
                                                  : Text(
                                                      "${_items[index]["DurationMin"]}:${_items[index]["DurationSec"]}",
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                      textAlign: TextAlign.left)
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
