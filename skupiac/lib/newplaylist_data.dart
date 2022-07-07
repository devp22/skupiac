import 'package:flutter/material.dart';
import 'newplaylist.dart';
import 'playlist_screen.dart';
import 'reusable_widgets.dart';

class NewPlaylistData extends StatelessWidget {
  final NewPlaylist newPlaylist;

  NewPlaylistData({required this.newPlaylist});

  String userTitle() {
    String title = "";
    title = newPlaylist.Name;
    return title;
  }

  @override
  Widget build(BuildContext context) {
    print("IN NEWPLAYLISTDATA PLAYLIST NAME IS $userTitle()");
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Playlist(
            playlistName: newPlaylist.Name,
          ),
        ),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 350, minWidth: 250),
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(const Radius.circular(10)),
          gradient: dp_lineargradient(
            Alignment.topLeft,
            Alignment.bottomRight,
            Colors.grey,
            const Color.fromARGB(255, 196, 221, 115),
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
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(10)),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      newPlaylist.image,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Text("${newPlaylist.Name}",
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontFamily: "Times New Roman",
                      ),
                      textAlign: TextAlign.left),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Publisher: ",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                      Text("${newPlaylist.Publisher}",
                          style: const TextStyle(fontSize: 20),
                          textAlign: TextAlign.left),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Number of songs: ",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                      Text("${newPlaylist.NumberOfSongs}",
                          style: const TextStyle(fontSize: 20),
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
  }
}
