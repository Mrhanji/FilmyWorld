import 'dart:convert';

import 'package:flimyworld/Screens/HomeScreen.dart';
import 'package:flimyworld/api/api_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MoviesView extends StatefulWidget {
  var mid;
  MoviesView({Key key, @required this.mid}) : super(key: key);

  @override
  _MoviesViewState createState() => _MoviesViewState();
}

class _MoviesViewState extends State<MoviesView> {
  List info;
  @override
  void initState() {
    var url = Uri.parse("https://api.themoviedb.org/3/movie/" +
        widget.mid.toString() +
        "?api_key=" +
        api +
        "&language=en-US");
    // TODO: implement initState
    super.initState();
    http.get(url).then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text('All Shows'),
              leading: IconButton(
                  icon: Icon(CupertinoIcons.left_chevron),
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()))),
            )));
  }
}
