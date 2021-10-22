import 'dart:convert';

import 'package:flimyworld/Screens/HomeScreen.dart';
import 'package:flimyworld/api/api_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MoviesView extends StatefulWidget {
  var mid;
  MoviesView({Key key, @required this.mid}) : super(key: key);

  @override
  _MoviesViewState createState() => _MoviesViewState();
}

class _MoviesViewState extends State<MoviesView> {
  List info;
  var img, name, poster, ratting, overview, tagline, rat;
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
        tagline = tempdata['tagline'];
        ratting = tempdata['vote_average'];
        overview = tempdata['overview'];
        var s = ratting.toInt();
        // rat = s.toDouble();
        rat = double.tryParse('0.' + s.toString());
      
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
         
          body: img != null
              ? Stack(
                  children: [
                    Positioned(
                        top: 1,
                        child: Container(
                            child: Image.network(urls + img.toString()))),
                    Positioned(
                        top: 1,
                        child: Container(
                          height: size.height * 0.34,
                          width: size.width,
                          color: Colors.white12,
                        )),
                    Positioned(
                        top: size.height * 0.05,
                        left: 1,
                        child: Container(
                          width: size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Positioned(
                        top: size.height * 0.2,
                        left: 15,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Hero(tag: widget.mid,
                              child: Container(
                                height: size.height * 0.3,
                                width: size.width * 0.4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            urls + poster.toString()))),
                              ),
                            ),
                            Container(
                              width: size.width,
                              padding: EdgeInsets.only(
                                  top: size.height * 0.085, left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container( width: size.width * 0.5,
                                    child: Text(name.toString(),
                                        style: GoogleFonts.actor(
                                            color: Colors.white,
                                            fontSize: size.height * 0.03),maxLines: 2,overflow: TextOverflow.ellipsis,),
                                  ),
                                  Container(
                                    width: size.width * 0.6,
                                    child: Text(tagline.toString(),
                                        style: GoogleFonts.actor(
                                            color: Colors.grey,
                                            fontSize: size.height * 0.018),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                    Positioned(
                        top: size.height * 0.29,
                        right: 5,
                        //left: size.width * 0.5,
                        child: CircularPercentIndicator(
                          radius: 60.0,
                          animation: true,
                          lineWidth: 5.0,
                          animationDuration: 1500,
                          percent: rat,
                          center: new Text(ratting.toString(),
                              style: TextStyle(color: Colors.white)),
                          progressColor: Colors.amber,
                        )),



Positioned(top:size.height*0.5,
  child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12.0, left: 5, bottom: 0),
                                    child: Text(
                                      'Overview',
                                      style: GoogleFonts.ubuntu(
                                          fontSize: size.height * 0.023,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),),

Positioned(top: size.height*0.55,
  child: Container(width: size.width,
  padding:EdgeInsets.only(left:10,right: 10),
  
    child: Text(overview.toString(),style:TextStyle(color: Colors.grey))))




                  ],
                )
              : Lottie.asset('assets/animations/loading.json'),
        ));
  }
}
