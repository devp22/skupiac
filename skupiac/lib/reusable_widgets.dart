import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
TextField dp_textfield(String text, IconData icon_, bool boolType,
    TextEditingController txtcontroller) {
  return TextField(
    obscureText: boolType,
    controller: txtcontroller,
    decoration: InputDecoration(
      labelText: text,
      prefixIcon: Icon(icon_),
    ),
  );
}

LinearGradient dp_lineargradient(Alignment beginalign, Alignment endalign,
    Color beginColor, Color endColor) {
  return LinearGradient(
    begin: beginalign,
    end: endalign,
    colors: [beginColor, endColor],
  );
}

Container dp_contaienr_playlists(Color c, String t) {
  return Container(
    width: 200,
    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
    margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)), color: c),
    child: Text(t),
  );
}

FloatingActionButton dp_floatbutton(Color c, IconData _icon, Function fn) {
  return FloatingActionButton(
    onPressed: () => fn,
    backgroundColor: c,
    child: Icon(_icon),
  );
}

Container dp_details_container(String name, String value) {
  return Container(
    child: Row(
      children: [
        Text(
          "${name}: ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: "Times New Roman",
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontFamily: "Times New Roman",
          ),
        ),
      ],
    ),
  );
}

TableRow dp_tablerow(String fieldname, String data) {
  return TableRow(
    children: [
      Column(
        children: [
          Text(
            fieldname,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Georgia',
              fontSize: 15,
            ),
          ),
        ],
      ),
      Column(
        children: [
          Text(
            data,
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 15,
            ),
          ),
        ],
      ),
    ],
  );
}
