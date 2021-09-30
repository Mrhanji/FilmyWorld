import 'package:flimyworld/Screens/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Allshows extends StatefulWidget {
  const Allshows({Key key}) : super(key: key);

  @override
  _AllshowsState createState() => _AllshowsState();
}

class _AllshowsState extends State<Allshows> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(backgroundColor: Colors.black,
        title: Text('All Shows'),
          leading: IconButton(
              icon: Icon(CupertinoIcons.left_chevron), onPressed: () => 
                 Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()))
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
                    CupertinoIcons.house,
                    color: Colors.white,
                  ),
                  onPressed: () {
                     Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  }),
              IconButton(
                  icon: Icon(
                    CupertinoIcons.tv_fill,
                    color: Colors.white,
                  ),
                  onPressed: () {}),
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
