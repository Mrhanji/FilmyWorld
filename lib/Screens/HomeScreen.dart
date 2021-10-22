import 'package:flimyworld/Screens/Allshows.dart';
import 'package:flimyworld/Screens/MoviesView.dart';
import 'package:flimyworld/Screens/PersonView.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();
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
        key: _scaffoldkey,
        appBar: AppBar(
          leading: InkWell(
            child: Image.asset('assets/images/fwlogo-trans.png'),
            onTap: () {
              _scaffoldkey.currentState.openDrawer();
            },
          ),
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
        drawer: Drawer(),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 12.0, left: 5, bottom: 1),
                      child: Text(
                        'Trending Movies',
                        style:
                            GoogleFonts.ubuntu(fontSize: size.height * 0.023),
                      ),
                    ),
                  ],
                ),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF000000).withAlpha(60),
                            blurRadius: 6.0,
                            spreadRadius: 0.0,
                            offset: Offset(
                              0.0,
                              3.0,
                            ),
                          ),
                        ]),
                    height: size.height * 0.38,
                    width: size.width,
                    child: TrendingMovielist != null
                        ? ListView.builder(
                            itemCount: TrendingMovielist.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MoviesView(
                                              mid: TrendingMovielist[index]
                                                  ['id'])));
                                },
                                child: Hero(tag: TrendingMovielist[index]['id'],
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, left: 10, right: 10),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          child: Container(
                                            height: size.height * 0.35,
                                            width: size.width * 0.45,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(urls +
                                                        TrendingMovielist[index]
                                                            ['poster_path']),
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
                                        ),
                                        Positioned(
                                            bottom: 35,
                                            right: 0,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.star_rounded,
                                                  color: Colors.amber.shade600,
                                                ),
                                                Text(
                                                    TrendingMovielist[index]
                                                                ['vote_average']
                                                            .toString() +
                                                        '  ',
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.height * 0.023))
                                              ],
                                            )),
                                        Positioned(
                                            bottom: size.height * 0.013,
                                            child: Container(
                                                width: size.width * 0.45,
                                                height: size.height * 0.082,
                                                decoration: BoxDecoration(
                                                  backgroundBlendMode:
                                                      BlendMode.darken,
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        Colors.black12,
                                                        Colors.black
                                                      ],
                                                      begin: Alignment.topCenter,
                                                      end: Alignment.bottomCenter,
                                                      stops: [0.0, 1.1],
                                                      tileMode: TileMode.clamp),
                                                ),
                                                child: Text(
                                                  ' ' +
                                                      TrendingMovielist[index]
                                                          ['title'],
                                                  style: TextStyle(
                                                      fontSize:
                                                          size.height * 0.028),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                )))
                                      ],
                                    ),
                                  ),
                                ),
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
                          const EdgeInsets.only(top: 12.0, left: 5, bottom: 0),
                      child: Text(
                        'Popular People',
                        style:
                            GoogleFonts.ubuntu(fontSize: size.height * 0.023),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.02,
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
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PersonView(
                                                            id: personlist[
                                                                index]['id'])));
                                          },
                                          child: CircleAvatar(
                                            radius: 30.0,
                                            backgroundImage: NetworkImage(
                                                personlist[index]
                                                            ['profile_path'] !=
                                                        null
                                                    ? urls +
                                                        personlist[index]
                                                                ['profile_path']
                                                            .toString()
                                                    : 'https://via.placeholder.com/150'),
                                          ),
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
                SizedBox(
                  height: size.height * 0.02,
                ),
                Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 12.0, left: 5, bottom: 0),
                      child: Text(
                        'Trending Tv Shows',
                        style:
                            GoogleFonts.ubuntu(fontSize: size.height * 0.023),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Container(
                    height: size.height * 0.38,
                    width: size.width,
                    child: TrendingTvshowslist != null
                        ? ListView.builder(
                            itemCount: TrendingTvshowslist.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, left: 10, right: 10),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      child: Container(
                                        height: size.height * 0.35,
                                        width: size.width * 0.45,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(urls +
                                                    TrendingTvshowslist[index]
                                                        ['poster_path']),
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
                                    ),
                                    Positioned(
                                        bottom: size.height * 0.01,
                                        child: Container(
                                            width: size.width * 0.45,
                                            height: size.height * 0.082,
                                            decoration: BoxDecoration(
                                              backgroundBlendMode:
                                                  BlendMode.darken,
                                              gradient: LinearGradient(
                                                  colors: [
                                                    Colors.black12,
                                                    Colors.black
                                                  ],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  stops: [0.0, 1.1],
                                                  tileMode: TileMode.clamp),
                                            ),
                                            child: Text(
                                              ' ' +
                                                  TrendingTvshowslist[index]
                                                      ['original_name'],
                                              style: TextStyle(
                                                  fontSize:
                                                      size.height * 0.025),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ))),
                                    Positioned(
                                        bottom: size.height * 0.06,
                                        right: 0,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.star_rounded,
                                              color: Colors.amber.shade600,
                                            ),
                                            Text(
                                                TrendingTvshowslist[index]
                                                            ['vote_average']
                                                        .toString() +
                                                    '  ',
                                                style: TextStyle(
                                                    fontSize:
                                                        size.height * 0.023))
                                          ],
                                        )),
                                  ],
                                ),
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
