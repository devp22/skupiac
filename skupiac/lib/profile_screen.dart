import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:skupiac/reusable_widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = "";
  String firstName = "";
  String lastName = "";
  String email = "";
  String contact = "";

  Future<void> _getUserName() async {
    await FirebaseFirestore.instance
        .collection('skupiac_users')
        .where("UserId",
            isEqualTo: FirebaseAuth.instance.currentUser!.uid.toString().trim())
        .get()
        .then((value) {
      setState(() {
        print(value.toString());
        userName = value.docs.first.data()["Username"].toString();
        firstName = value.docs.first.data()["First Name"].toString();
        lastName = value.docs.first.data()["Last Name"].toString();
        email = value.docs.first.data()["E-Mail ID"].toString();
        contact = value.docs.first.data()["Contact Number"].toString();
        print(userName);
      });
    });
  }

  void initState() {
    super.initState();
    _getUserName();
  }

  void dispose() {
    super.dispose();
  }

  int _page = 0;
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
            const SizedBox(
              height: 20,
            ),
            Column(
              children: const [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Your Profile",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Georgia",
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 240.0,
                    width: 240.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/images/baymax.png'),
                        fit: BoxFit.fill,
                        alignment: Alignment.center,
                      ),
                      border: Border.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 5,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Table(
                  defaultColumnWidth: FixedColumnWidth(
                      MediaQuery.of(context).size.width * 0.45),
                  border: TableBorder.all(
                      color: Colors.black, style: BorderStyle.solid, width: 2),
                  children: [
                    dp_tablerow("Username", userName),
                    dp_tablerow("First Name", firstName),
                    dp_tablerow("Last Name", lastName),
                    dp_tablerow("E-Mail Address", email),
                    dp_tablerow("Contact", contact),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () => {
                    FirebaseAuth.instance.signOut().then(
                          (value) => Navigator.pushNamed(context, "/login"),
                        ),
                  },
                  child: const Text(
                    "Sign Out",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black, // background (button) color
                    onPrimary: Colors.white, // foreground (text) color
                    minimumSize: Size(175, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: 2,
        items: const <Widget>[
          Icon(
            Icons.home,
            size: 30,
          ),
          Icon(Icons.search, size: 30),
          Icon(Icons.person, size: 30),
        ],
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
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
