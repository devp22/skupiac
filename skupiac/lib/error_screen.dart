import 'package:flutter/material.dart';

class ErrorScreen extends StatefulWidget {
  final errorMessage;
  const ErrorScreen({required this.errorMessage}) : super();

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  late String errorMessage = widget.errorMessage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("You have following error"),
      ),
      body: Container(
        child: Text(errorMessage),
      ),
    );
  }
}
