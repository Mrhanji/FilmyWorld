import 'dart:convert';

import 'package:flimyworld/api/api_info.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class Combined_credit extends StatefulWidget {
  var id;
  Combined_credit({Key key, @required this.id}) : super(key: key);

  @override
  _Combined_creditState createState() => _Combined_creditState();
}

class _Combined_creditState extends State<Combined_credit> {
  List cast;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var url = siteurl +
        widget.id.toString() +
        '/combined_credits?api_key=' +
        api +
        "&language=en-US";
    http.get(Uri.parse(url)).then((value) {
      if (value.statusCode == 200) {
        setState(() {
          Map first = jsonDecode(value.body);
          cast = first['cast'];
          print(cast);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ListView( scrollDirection: Axis.horizontal,
        children: cast != null
            ? cast.map((e) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                  child: Column(
                      children: [
                        Container(
                          height: size.height * 0.35,
                          width: size.width * 0.45,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(urls +e['poster_path'].toString()),
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
                              ' '+ e['original_title'].toString(),
                              style: TextStyle(fontSize: size.height * 0.025,color: Colors.white),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                        
                        Row(
                          children: [
                            Icon(
                              Icons.star_rounded,
                              color: Colors.amber.shade600,
                            ),
                            Text( '  '+e['vote_average'].toString(),
                                style:
                                    TextStyle(fontSize: size.height * 0.023,color: Colors.white))
                          ],
                        ),
                      ],
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
