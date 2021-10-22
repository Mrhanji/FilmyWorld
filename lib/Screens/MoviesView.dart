import 'dart:convert';

import 'package:flimyworld/Screens/HomeScreen.dart';
import 'package:flimyworld/api/api_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class MoviesView extends StatefulWidget {
  var mid;
  MoviesView({Key key, @required this.mid}) : super(key: key);

  @override
  _MoviesViewState createState() => _MoviesViewState();
}

class _MoviesViewState extends State<MoviesView> {
  List info;
  var img, name, poster, ratting, overview;
  @override
  void initState() {
    var url = Uri.parse("https://api.themoviedb.org/3/movie/" +
        widget.mid.toString() +
        "?api_key=" +
        api +
        "&language=en-US");
    // TODO: implement initState
    super.initState();
    http.get(url).then((value) {
      setState(() {
        Map tempdata = jsonDecode(value.body);
        poster = tempdata['poster_path'];
        img = tempdata['backdrop_path'];
        name = tempdata['title'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.black,
          // appBar: AppBar(
          //   backgroundColor: Colors.black,
          //   title: Text(name.toString()),
          //   leading: IconButton(
          //       icon: Icon(CupertinoIcons.left_chevron),
          //       onPressed: () => Navigator.pop(context,
          //           MaterialPageRoute(builder: (context) => HomeScreen()))),
          // ),
          body: img!=null?Stack(
            children: [
              
              Positioned(top: 1, child: Image.network(urls + img.toString())),
              Positioned(
                  top: size.height*0.05,
                  left: 1,
                  child: Container(width: size.width,
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            icon: Icon(
                              CupertinoIcons.left_chevron,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.pop(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()))),




                                    IconButton(
                            icon: Icon(
                              CupertinoIcons.heart,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.pop(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()))),
                      ],
                    ),
                  )),
            ],
          ):Lottie.asset('assets/animations/loading.json'),
        ));
  }
}
