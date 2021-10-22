import 'dart:convert';

import 'package:flimyworld/Screens/MoviesView.dart';
import 'package:flimyworld/Screens/TvView.dart';
import 'package:flimyworld/api/api_info.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class SimilarTvView extends StatefulWidget {
  var tid;
  SimilarTvView({Key key, @required this.tid}) : super(key: key);

  @override
  _SimilarTvViewState createState() => _SimilarTvViewState();
}

class _SimilarTvViewState extends State<SimilarTvView> {
  List poster;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var url = Uri.parse("https://api.themoviedb.org/3/tv/" +
        widget.tid.toString() +
        "/similar?api_key=" +
        api +
        "&language=en-US");

    http.get(url).then((value) {
      setState(() {
        Map tempdata = jsonDecode(value.body);
        poster = tempdata['results'];
      poster = List.from(poster.reversed);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ListView(
        scrollDirection: Axis.horizontal,
        children: poster != null
            ? poster.map((e) {
                return Padding(
                  padding: const EdgeInsets.only(left:8.0,right:8),
                  child: InkWell(
                    onTap: () {
                      print(e['id']);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TvView(
                                    tid: e['id'],
                                  )));
                    },
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            height: size.height * 0.35,
                            width: size.width * 0.45,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        urls + e['poster_path'].toString()),
                                    fit: BoxFit.fill),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(18.0),
                                ),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white12,
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                  ),
                                ]),
                          ),
                          Text(
                            ' ' + e['name'].toString(),
                            style: TextStyle(
                                fontSize: size.height * 0.025,
                                color: Colors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star_rounded,
                                color: Colors.amber.shade600,
                              ),
                              Text('  ' + e['vote_average'].toString(),
                                  style: TextStyle(
                                      fontSize: size.height * 0.023,
                                      color: Colors.white))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList()
            : [
                Center(
                  child: Lottie.asset('assets/animations/loading.json'),
                )
              ]);
  }
}
