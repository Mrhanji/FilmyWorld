import 'dart:convert';

import 'package:flimyworld/Screens/MoviesView.dart';
import 'package:flimyworld/api/api_info.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class SimilarMovieView extends StatefulWidget {
  var mid;
  SimilarMovieView({Key key, @required this.mid}) : super(key: key);

  @override
  _SimilarMovieViewState createState() => _SimilarMovieViewState();
}

class _SimilarMovieViewState extends State<SimilarMovieView> {
  List poster;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var url = Uri.parse("https://api.themoviedb.org/3/movie/" +
        widget.mid.toString() +
        "/similar?api_key=" +
        api +
        "&language=en-US");

    http.get(url).then((value) {
      setState(() {
        Map tempdata = jsonDecode(value.body);
        poster = tempdata['results'];
       
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
                  padding: const EdgeInsets.all(8.0),
                  child: Hero(
                    tag: e['id'],
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MoviesView(mid: e['id'],)));
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
                              ' ' + e['original_title'].toString(),
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
