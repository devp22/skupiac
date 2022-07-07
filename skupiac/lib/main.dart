import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skupiac/home_screen.dart';
import 'package:skupiac/loading_screen.dart';
import 'package:skupiac/login_Screen.dart';
import 'package:skupiac/profile_screen.dart';
import 'package:skupiac/search_screen.dart';
import 'package:skupiac/signin_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (BuildContext context) => const LoadingScreen(),
        "/home": (BuildContext context) => const HomeScreen(),
        "/signin": (context) => SignInScreen(),
        "/login": (context) => const LoginScreen(),
        "/search": (context) => const SearchScreen(),
        "/profile": (context) => ProfileScreen(),
      },
    );
  }
}
