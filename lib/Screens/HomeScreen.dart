import 'package:flimyworld/Screens/Allshows.dart';
import 'package:flimyworld/api/api_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List TrendingMovielist, TrendingTvshowslist, personlist;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//call our api
    LoadTrendingMovies();
  }

  LoadTrendingMovies() async {
    TMDB tmdbCustome = TMDB(ApiKeys(api, auth),
        logConfig: ConfigLogger(showErrorLogs: true, showLogs: true));
    Map TrendingTemp = await tmdbCustome.v3.trending
        .getTrending(mediaType: MediaType.movie, timeWindow: TimeWindow.day);
    Map Trendingtv = await tmdbCustome.v3.trending
        .getTrending(mediaType: MediaType.tv, timeWindow: TimeWindow.day);
    Map Persons = await tmdbCustome.v3.trending.getTrending(
      mediaType: MediaType.person,
    );
    setState(() {
      TrendingMovielist = TrendingTemp['results'];
      personlist = Persons['results'];
      TrendingTvshowslist = Trendingtv['results'];
      print(TrendingTvshowslist);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark, accentColor: Colors.transparent),
      home: Scaffold(
        appBar: AppBar(
          leading: Image.asset('assets/images/fwlogo-trans.png'),
          title: Text('Filmy World',
              style: GoogleFonts.arapey(
                  fontSize: size.height * 0.028, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(CupertinoIcons.search),
              onPressed: () => null,
            )
          ],
        ),
        backgroundColor: Colors.black,
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 12.0, left: 8, bottom: 1),
                      child: Text(
                        'Trending Movies',
                        style:
                            GoogleFonts.ubuntu(fontSize: size.height * 0.023),
                      ),
                    ),
                  ],
                ),
                Container(
                    height: size.height * 0.45,
                    width: size.width,
                    child: TrendingMovielist != null
                        ? ListView.builder(
                            itemCount: TrendingMovielist.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 5.0),
                                child: Container(
                                    height: size.height * 0.4,
                                    width: size.width * 0.5,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          child: Container(
                                              decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(urls +
                                                  TrendingMovielist[index]
                                                          ['poster_path']
                                                      .toString()),
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25)),
                                          )),
                                        ),
                                        Positioned(
                                            bottom: 0,
                                            left: 0,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  TrendingMovielist[index]
                                                          ['original_title']
                                                      .toString(),
                                                  style: GoogleFonts.ubuntu(
                                                      fontSize:
                                                          size.height * 0.023),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  '⭐ ' +
                                                      TrendingMovielist[index]
                                                              ['vote_average']
                                                          .toString(),
                                                  style: GoogleFonts.ubuntu(
                                                      fontSize:
                                                          size.height * 0.023),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ))
                                      ],
                                    )),
                              );
                            },
                          )
                        : Container(
                            child: Center(
                              child: Lottie.asset(
                                  'assets/animations/loading.json'),
                            ),
                          )),

                // Persons
                Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 12.0, left: 8, bottom: 5),
                      child: Text(
                        'Popular Persons',
                        style:
                            GoogleFonts.ubuntu(fontSize: size.height * 0.023),
                      ),
                    ),
                  ],
                ),

                Container(
                    height: size.height * 0.1,
                    width: size.width,
                    child: personlist != null
                        ? ListView.builder(
                            itemCount: personlist.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Container(
                                    height: size.height * 0.1,
                                    //  color: Colors.amber,
                                    width: size.width * 0.25,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 30.0,
                                          backgroundImage: NetworkImage(personlist[
                                                      index]['profile_path'] !=
                                                  null
                                              ? urls +
                                                  personlist[index]
                                                          ['profile_path']
                                                      .toString()
                                              : 'https://via.placeholder.com/150'),
                                        ),
                                        Text(
                                          personlist[index]['name'].toString(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                  ));
                            },
                          )
                        : Container(
                            child: Center(
                              child: Lottie.asset(
                                  'assets/animations/loading.json'),
                            ),
                          )),

                //Trending Tv Shows Area

                Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 12.0, left: 8, bottom: 1),
                      child: Text(
                        'Trending Tv Show',
                        style:
                            GoogleFonts.ubuntu(fontSize: size.height * 0.023),
                      ),
                    ),
                  ],
                ),
                Container(
                    height: size.height * 0.45,
                    width: size.width,
                    child: TrendingTvshowslist != null
                        ? ListView.builder(
                            itemCount: TrendingTvshowslist.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 5.0),
                                child: Container(
                                    height: size.height * 0.4,
                                    width: size.width * 0.5,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          child: Container(
                                              decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(urls +
                                                  TrendingTvshowslist[index]
                                                          ['poster_path']
                                                      .toString()),
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25)),
                                          )),
                                        ),
                                        Positioned(
                                            bottom: 0,
                                            left: 0,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  TrendingTvshowslist[index]
                                                          ['original_name']
                                                      .toString(),
                                                  style: GoogleFonts.ubuntu(
                                                      fontSize:
                                                          size.height * 0.023),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  '⭐ ' +
                                                      TrendingTvshowslist[index]
                                                              ['vote_average']
                                                          .toString(),
                                                  style: GoogleFonts.ubuntu(
                                                      fontSize:
                                                          size.height * 0.023),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ))
                                      ],
                                    )),
                              );
                            },
                          )
                        : Container(
                            child: Center(
                              child: Lottie.asset(
                                  'assets/animations/loading.json'),
                            ),
                          )),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.black87,
          width: size.width,
          height: size.height * 0.08,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  icon: Icon(
                    CupertinoIcons.house_fill,
                    color: Colors.white,
                  ),
                  onPressed: () {}),
              IconButton(
                  icon: Icon(
                    CupertinoIcons.tv,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Allshows()));
                  }),
              IconButton(
                  icon: Icon(
                    CupertinoIcons.person,
                    color: Colors.white,
                  ),
                  onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
