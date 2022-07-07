import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scroll_navigation/scroll_navigation.dart';
import 'dart:math';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:skupiac/playlist_screen.dart';
import 'package:skupiac/reusable_widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List _items = [];
  int _page = 0;
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/playlist.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["playlist"];
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
    final size = MediaQuery.of(context).size;

// generates a new Random object
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: dp_lineargradient(Alignment.topLeft, Alignment.bottomRight,
              Colors.redAccent, Colors.blueAccent),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints.expand(
                      height: size.height / 2.5,
                      width: size.width,
                    ),
                    // child: Image.asset(
                    //   "assets/images/c3.png",
                    //   height: size.height / 2.5,
                    //   width: size.width,
                    // ),
                    child: CarouselSlider(
                      items: [
                        //1st Image of Slider
                        Container(
                          child: Image.asset(
                            "assets/images/c1.png",
                            height: size.height / 2.5,
                            width: size.width,
                          ),
                        ),
                        //1st Image of Slider
                        Container(
                          child: Image.asset(
                            "assets/images/c2.png",
                            height: size.height / 2.5,
                            width: size.width,
                          ),
                        ),
                        //1st Image of Slider
                        Container(
                          child: Image.asset(
                            "assets/images/c3.png",
                            height: size.height / 2.5,
                            width: size.width,
                          ),
                        )
                      ],

                      //Slider Container properties
                      options: CarouselOptions(
                        height: size.height / 2.5,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        viewportFraction: 0.8,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Text(
                    "Top Rated",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                height: 150,
                child: Row(
                  //scrollDirection: Axis.horizontal,
                  children: [
                    _items.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _items.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Playlist(
                                      playlistName: _items[index]["Name"],
                                    ),
                                  ),
                                ),
                                child: Container(
                                  constraints: BoxConstraints(
                                      maxWidth: 350, minWidth: 250),
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    gradient: dp_lineargradient(
                                      Alignment.topLeft,
                                      Alignment.bottomRight,
                                      Color(0xffffd89b),
                                      Color(0xffc4e0e5),
                                    ),
                                    border: Border.all(
                                      width: 2.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: FittedBox(
                                    fit: BoxFit.fill,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 190.0,
                                          height: 190.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                _items[index]["image"],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Text("${_items[index]["Name"]}",
                                                maxLines: 1,
                                                softWrap: true,
                                                overflow: TextOverflow.fade,
                                                style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic,
                                                  fontFamily: "Times New Roman",
                                                ),
                                                textAlign: TextAlign.left),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Publisher: ",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.left,
                                                ),
                                                Text(
                                                    "${_items[index]["Publisher"]}",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                    textAlign: TextAlign.left),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Number of songs: ",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.left,
                                                ),
                                                Text(
                                                    "${_items[index]["NumberOfSongs"]}",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                    textAlign: TextAlign.left),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ))
                        : Container()
                    // GestureDetector(
                    //   // ignore: avoid_returning_null_for_void
                    //   onTap: () => null,
                    //   child: dp_contaienr_playlists(Colors.blue, "1"),
                    // ),
                    // GestureDetector(
                    //   // ignore: avoid_returning_null_for_void
                    //   onTap: () => null,
                    //   child: dp_contaienr_playlists(Colors.blue, "1"),
                    // ),
                    // GestureDetector(
                    //   // ignore: avoid_returning_null_for_void
                    //   onTap: () => null,
                    //   child: dp_contaienr_playlists(Colors.blue, "1"),
                    // ),
                    // GestureDetector(
                    //   // ignore: avoid_returning_null_for_void
                    //   onTap: () => null,
                    //   child: dp_contaienr_playlists(Colors.blue, "1"),
                    // ),
                    // GestureDetector(
                    //   // ignore: avoid_returning_null_for_void
                    //   onTap: () => null,
                    //   child: dp_contaienr_playlists(Colors.blue, "1"),
                    // ),
                    // GestureDetector(
                    //   // ignore: avoid_returning_null_for_void
                    //   onTap: () => null,
                    //   child: dp_contaienr_playlists(Colors.blue, "1"),
                    // ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: Text(
                    "Newly Added",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 150,
                child: Row(
                  // scrollDirection: Axis.horizontal,
                  children: [
                    _items.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _items.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Playlist(
                                      playlistName: _items[index]["Name"],
                                    ),
                                  ),
                                ),
                                child: Container(
                                  constraints: BoxConstraints(
                                      maxWidth: 350, minWidth: 250),
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    gradient: dp_lineargradient(
                                      Alignment.topLeft,
                                      Alignment.bottomRight,
                                      Color(0xffddd6f3),
                                      Color(0xfffaaca8),
                                    ),
                                    border: Border.all(
                                      width: 2.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: FittedBox(
                                    fit: BoxFit.fill,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 190.0,
                                          height: 190.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                _items[index]["image"],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Text("${_items[index]["Name"]}",
                                                maxLines: 1,
                                                softWrap: true,
                                                overflow: TextOverflow.fade,
                                                style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic,
                                                  fontFamily: "Times New Roman",
                                                ),
                                                textAlign: TextAlign.left),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Publisher: ",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.left,
                                                ),
                                                Text(
                                                    "${_items[index]["Publisher"]}",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                    textAlign: TextAlign.left),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Number of songs: ",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.left,
                                                ),
                                                Text(
                                                    "${_items[index]["NumberOfSongs"]}",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                    textAlign: TextAlign.left),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ))
                        : Container()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
          ),
          Icon(Icons.search, size: 30),
          Icon(Icons.person, size: 30),
        ],
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(
            () {
              _page = index;
              if (index == 0) {
                Navigator.pushNamed(context, "/home");
              }
              if (index == 1) {
                Navigator.pushNamed(context, "/search");
              }
              if (index == 2) {
                Navigator.pushNamed(context, "/profile");
              }
            },
          );
        },
      ),
    );
  }
}
