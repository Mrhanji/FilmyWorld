import 'dart:convert';

import 'package:flimyworld/Screens/HomeScreen.dart';
import 'package:flimyworld/api/api_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PersonView extends StatefulWidget {
  var id;
  PersonView({Key key, @required this.id}) : super(key: key);

  @override
  _PersonViewState createState() => _PersonViewState();
}

class _PersonViewState extends State<PersonView> {
  Map data;
  List other;
  var img,
      birthday,
      deathday,
      gender,
      homepage,
      known,
      name,
      place,
      popularity,
      bio;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var url =
        siteurl + widget.id.toString() + '?api_key=' + api + "&language=en-US";
    http.get(Uri.parse(url)).then((value) {
      if (value.statusCode == 200) {
        setState(() {
          data = jsonDecode(value.body);
          other = data['also_known_as'];
          img = data['profile_path'];
          birthday = data['birthday'];
          deathday = data['deathday'];
          gender = data['gender'];
          homepage = data['homepage'];
          
        });
        print(img);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text('tile'),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              icon: Icon(CupertinoIcons.left_chevron),
            )),
        body: Image.network(urls + img.toString()),
      ),
    );
  }
}
