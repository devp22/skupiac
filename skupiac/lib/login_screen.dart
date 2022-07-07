// ignore: file_names
import 'dart:ui';
import 'package:just_audio/just_audio.dart';

import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/rendering.dart';
import 'package:skupiac/error_screen.dart';
import 'reusable_widgets.dart';

final player = AudioPlayer();

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // player.setUrl(
    //     "https://firebasestorage.googleapis.com/v0/b/skupiac-database.appspot.com/o/chill-abstract-intention-12099.mp3?alt=media&token=7532afef-cfa8-4903-a954-5adc4c389f5c");
    // player.play();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: dp_lineargradient(Alignment.topLeft, Alignment.bottomRight,
              Colors.blueAccent, Colors.redAccent),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 200,
              ),
              Column(
                children: <Widget>[
                  dp_textfield("Enter your mail id", Icons.search, false,
                      _emailController),
                  const SizedBox(
                    height: 50,
                  ),
                  dp_textfield("Enter your password", Icons.password, true,
                      _passwordController),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () => {},
                    child: Container(
                      alignment: Alignment.bottomRight,
                      child: const Text(
                        "Forgot password?",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordController.text)
                          .then(
                              (value) => Navigator.pushNamed(context, "/home"))
                          .onError(
                            (error, stackTrace) => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ErrorScreen(
                                  errorMessage: error.toString(),
                                ),
                              ),
                            ),
                          );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 255, 81, 7),
                    ),
                    child: const Text("Sign In"),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () => {
                      Navigator.pushNamed(context, "/signin"),
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        "Create Account",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Lottie.asset('assets/baymax2.json'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
