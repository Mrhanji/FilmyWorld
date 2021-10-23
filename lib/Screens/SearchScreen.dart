import 'dart:convert';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flimyworld/Screens/HomeScreen.dart';
import 'package:flimyworld/Screens/MoviesView.dart';
import 'package:flimyworld/api/api_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class SearchSCreen extends StatefulWidget {
  const SearchSCreen({Key key}) : super(key: key);

  @override
  _SearchSCreenState createState() => _SearchSCreenState();
}

class _SearchSCreenState extends State<SearchSCreen> {
  List result;
  bool err = true;
  var textController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textController.addListener(() {
      var query = Uri.parse(
          "https://api.themoviedb.org/3/search/movie?api_key=" +
              api +
              "&language=en-US&query=" +
              textController.text);
      http.get(query).then((value) {
        if (value.contentLength > 37) {
          setState(() {
            Map data = jsonDecode(value.body);
            result = data['results'];
            err = false;
          });
        } else {
          setState(() {
            err = true;
          });
          print('Error....');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(accentColor: Colors.black, primaryColor: Colors.black),
      home: Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(
                icon: Icon(
                  CupertinoIcons.left_chevron,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.pop(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()))),
            actions: [
              AnimSearchBar(
                width: size.width,
                rtl: true,
                color: Colors.white12,

                helpText: "Search Movie",

                style: TextStyle(color: Colors.white),

                animationDurationInMilli: 600,
                textController: textController,

                closeSearchOnSuffixTap: true,

                onSuffixTap: () {
                  setState(() {
                    textController.clear();
                  });
                },

                //autoFocus: true,
              ),
            ]),
        body: err != true
            ? ListView(
                scrollDirection: Axis.vertical,
                children: result.map((e) {
                  var img = "https://via.placeholder.com/500";
                  if (e['poster_path'] != null) {
                    img = urls + e['poster_path'].toString();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(left: 5.0, top: 8),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MoviesView(
                                      mid: e['id'],
                                    )));
                      },
                      child: ListTile(
                        title: Text(
                          e['original_title'].toString(),
                          style: TextStyle(color: Colors.white),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        leading: Container(
                            height: size.height * 0.5,
                            width: size.width * 0.15,
                            child: Image.network(
                              img,
                              fit: BoxFit.fill,
                            )),
                        subtitle: Text(
                            'Release Date: ' + e['release_date'].toString(),
                            style: TextStyle(color: Colors.grey)),
                      ),
                    ),
                  );
                }).toList(),
              )
            : Center(
                child: Lottie.asset('assets/animations/error.json'),
              ),
      ),
    );
  }
}
