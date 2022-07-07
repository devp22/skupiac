import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skupiac/reusable_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';
import 'error_screen.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  CollectionReference users =
      FirebaseFirestore.instance.collection('auxiliator');

  @override
  Widget build(BuildContext context) {
    TextEditingController _fnameController = TextEditingController();
    TextEditingController _lnameController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _contactController = TextEditingController();
    TextEditingController _usernameController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: dp_lineargradient(Alignment.topLeft, Alignment.bottomRight,
              Colors.redAccent, Colors.blueAccent),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Enter your details",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                child: dp_textfield("Enter your first name:", Icons.abc, false,
                    _fnameController),
              ),
              Container(
                child: dp_textfield("Enter your last name:", Icons.abc, false,
                    _lnameController),
              ),
              Container(
                child: dp_textfield("Enter your e-mail id", Icons.email, false,
                    _emailController),
              ),
              Container(
                child: dp_textfield("Enter your contact number:", Icons.numbers,
                    false, _contactController),
              ),
              Container(
                child: dp_textfield("Enter your username:",
                    Icons.supervised_user_circle, false, _usernameController),
              ),
              Container(
                child: dp_textfield("Enter your password:", Icons.password,
                    true, _passwordController),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text)
                      .then((value) => print("User added successfully"))
                      .onError(
                        (error, stackTrace) => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ErrorScreen(
                              errorMessage: error.toString(),
                            ),
                          ),
                        ),
                      );

                  String userId =
                      FirebaseAuth.instance.currentUser!.uid.toString();

                  await users
                      .add({
                        "First Name": _fnameController.text,
                        "Last Name": _lnameController.text,
                        "E-Mail ID": _emailController.text,
                        "Contact Number": _contactController.text,
                        "Username": _usernameController.text,
                        "Password": _passwordController.text,
                        "UserId": userId == "" ? "" : userId,
                      })
                      .then((value) => Navigator.pushNamed(context, "/login"))
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
                  primary: const Color.fromARGB(255, 255, 81, 7),
                ),
                child: const Text("Create Account"),
              ),
              Lottie.asset('assets/baymax2.json'),
            ],
          ),
        ),
      ),
    );
  }
}
