import 'dart:convert';

import 'package:flimyworld/Screens/HomeScreen.dart';
import 'package:flimyworld/api/api_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glass_container/glass_container.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

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
          known = data['known_for_department'];
          name = data['name'];
          place = data['place_of_birth'];
          popularity = data['popularity'];

          if (deathday == null) {
            deathday = false;
          }
        });

        print(img);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(name.toString()),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              icon: Icon(CupertinoIcons.left_chevron),
            )),
        body: img != null
            ? Container(
                 height: size.height ,
                    width: size.width,
              child: Stack(
                children: [
                  Positioned(bottom:0,left:-120,child: Image.asset('assets/images/camera.png')),
                  Positioned(
                   top: 0,left: 0,right: 0,
                    child: Container( width: size.width,
                
                height: size.height * 0.37,
                      child: GlassContainer(
                       shadowBlurRadius: 1,
                       shadowSpreadRadius: 1,
                       contColor: Colors.white10,
                        child: Row(
                          children: [
                            Container(
                              height: size.height * 0.3,
                              width: size.width * 0.5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  image: DecorationImage(
                                      image: NetworkImage(urls + img))),
                            ),
                            Column(
                              children: [
                                Text(
                                  name.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  birthday.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(deathday==false?'':deathday.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),

                                Text(
                                 known.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
              
               Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 12.0, left: 5, bottom: 0),
                      child: Text(
                        'Biography',
                        style:
                            GoogleFonts.ubuntu(fontSize: size.height * 0.023),
                      ),
                    ),
                  ],
                ),
              
                ],
              ),
            )
            : Center(child: Lottie.asset('assets/animations/loading.json')),
      ),
    );
  }
}
