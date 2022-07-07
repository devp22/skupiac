import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:skupiac/playlist_screen.dart';
import 'reusable_widgets.dart';
import 'package:http/http.dart' as http;
import 'newplaylist.dart';
import 'newplaylist_data.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List _items = [];
  List<NewPlaylist> songsData = <NewPlaylist>[];
  List<NewPlaylist> songsDisplay = <NewPlaylist>[];
  @override
  int _page = 0;
  // Future<void> readJson() async {
  //   final String response = await rootBundle.loadString('assets/playlist.json');
  //   final data = await json.decode(response);
  //   setState(() {
  //     _items = data["playlist"];
  //   });
  // }

  Future<List<NewPlaylist>> parseSongs(String responseBody) async {
    var list = await json.decode(responseBody) as List<dynamic>;
    var songs = list.map((e) => NewPlaylist.fromJson(e)).toList();
    print("SONGS: $songs");
    return songs;
  }

  Future<List<NewPlaylist>> fetchSongs() async {
    print("ENTERED FETCHING SONGS");
    http.Response response = await http
        .get(Uri.parse('https://devp22.github.io/json/newplaylist.json'));
    print("URL FETCHED, RESPONSE CODE IS: ${response.statusCode}");
    if (response.statusCode == 200) {
      // print(response.body);
      var list = await json.decode(response.body) as List<dynamic>;
      var songs = list.map((e) => NewPlaylist.fromJson(e)).toList();
      print("SONGS: $songs");
      return songs;
    } else {
      throw Exception("EXCEPTION: ${response.statusCode}");
    }
  }

  @override
  void initState() {
    print("STATE BEGINS");
    fetchSongs().then((value) {
      setState(() {
        print("SETTING STATE IN FETCHSONGS");
        songsData.addAll(value);
        songsDisplay = songsData;
        print("SONGS DISPLAY: ${songsDisplay}");
      });
    });
    super.initState();
    print("AFTER SUPER INIT STATE");

    // readJson();
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
        child: ListView.builder(
          itemBuilder: (context, index) {
            print("INDEX: ${index}");
            return index == 0
                ? searchBar()
                : NewPlaylistData(
                    newPlaylist: songsDisplay[index - 1],
                  );
          },
          itemCount: songsDisplay.length + 1,
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: 1,
        items: <Widget>[
          const Icon(Icons.home, size: 30),
          const Icon(Icons.search, size: 30),
          const Icon(Icons.person, size: 30),
        ],
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

  searchBar() {
    print("ENTERED SEARCH BAR");

    return Container(
      //Search container
      padding: const EdgeInsets.all(1.0),
      margin: const EdgeInsets.only(left: 25, right: 25, top: 30, bottom: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            child: const Icon(
              Icons.search,
              color: Colors.indigo,
            ),
            margin: const EdgeInsets.fromLTRB(2, 0, 10, 0),
          ),
          Expanded(
            child: TextField(
              // controller: searchController,
              textInputAction: TextInputAction.search,
              onChanged: (text) {
                text = text.toLowerCase();
                setState(() {
                  if (kDebugMode) {
                    print("TEXT: $text");
                  }
                  songsDisplay = songsData.where((element) {
                    var albumname = element.Name.toLowerCase();
                    if (kDebugMode) {
                      print("Album NAME: $albumname");
                    }
                    return albumname.contains(text);
                  }).toList();
                });
              },

              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // listItem(index) {
  //   return GestureDetector(
  //     onTap: () => Navigator.of(context).push(
  //       MaterialPageRoute(
  //         builder: (context) => Playlist(
  //           playlistName: _items[index]["Name"],
  //         ),
  //       ),
  //     ),
  //     child: Container(
  //       constraints: const BoxConstraints(maxWidth: 350, minWidth: 250),
  //       padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
  //       margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
  //       decoration: BoxDecoration(
  //         borderRadius: const BorderRadius.all(const Radius.circular(10)),
  //         gradient: dp_lineargradient(
  //           Alignment.topLeft,
  //           Alignment.bottomRight,
  //           Colors.grey,
  //           const Color.fromARGB(255, 196, 221, 115),
  //         ),
  //         border: Border.all(
  //           width: 2.0,
  //           color: Colors.black,
  //         ),
  //       ),
  //       child: FittedBox(
  //         fit: BoxFit.fill,
  //         child: Row(
  //           children: [
  //             Container(
  //               width: 190.0,
  //               height: 190.0,
  //               decoration: BoxDecoration(
  //                 shape: BoxShape.rectangle,
  //                 borderRadius:
  //                     const BorderRadius.all(const Radius.circular(10)),
  //                 image: DecorationImage(
  //                   fit: BoxFit.fill,
  //                   image: NetworkImage(
  //                     _items[index]["image"],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Column(
  //               children: [
  //                 Text("${_items[index]["Name"]}",
  //                     maxLines: 1,
  //                     softWrap: true,
  //                     overflow: TextOverflow.fade,
  //                     style: const TextStyle(
  //                       fontSize: 30,
  //                       fontWeight: FontWeight.bold,
  //                       fontStyle: FontStyle.italic,
  //                       fontFamily: "Times New Roman",
  //                     ),
  //                     textAlign: TextAlign.left),
  //                 const SizedBox(
  //                   height: 10,
  //                 ),
  //                 Row(
  //                   children: [
  //                     const Text(
  //                       "Publisher: ",
  //                       style: const TextStyle(
  //                           fontSize: 20, fontWeight: FontWeight.bold),
  //                       textAlign: TextAlign.left,
  //                     ),
  //                     Text("${_items[index]["Publisher"]}",
  //                         style: const TextStyle(fontSize: 20),
  //                         textAlign: TextAlign.left),
  //                   ],
  //                 ),
  //                 const SizedBox(
  //                   height: 10,
  //                 ),
  //                 Row(
  //                   children: [
  //                     const Text(
  //                       "Number of songs: ",
  //                       style: const TextStyle(
  //                           fontSize: 20, fontWeight: FontWeight.bold),
  //                       textAlign: TextAlign.left,
  //                     ),
  //                     Text("${_items[index]["NumberOfSongs"]}",
  //                         style: const TextStyle(fontSize: 20),
  //                         textAlign: TextAlign.left),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
