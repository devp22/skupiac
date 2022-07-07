import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:just_audio/just_audio.dart';
import 'package:skupiac/home_screen.dart';
import 'main.dart';
import 'reusable_widgets.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

final player = AudioPlayer();

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
      Duration(seconds: 10),
      () => Navigator.pushNamed(context, "/login"),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            gradient: dp_lineargradient(Alignment.topLeft,
                Alignment.bottomRight, Colors.blueAccent, Colors.redAccent),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const SizedBox(
                height: 200,
              ),
              // ignore: sized_box_for_whitespace
              Container(
                height: 150,
                width: 150,
                child: Image.asset("assets/images/buddhism.png"),
              ),
              const SizedBox(
                height: 150,
              ),
              const SpinKitPouringHourGlass(
                color: Colors.black,
                size: 50.0,
              ),
              const SizedBox(
                height: 200,
              ),
              const Text("Made with love"),
            ],
          )),
    );
  }
}
