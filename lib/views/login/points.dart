import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iacomappgaragiste/views/nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Points extends StatefulWidget {
  final VoidCallback signOut;
  String points;

  Points(this.signOut, this.points);

  @override
  _PointsState createState() => _PointsState();
}

class _PointsState extends State<Points> {
  final _key = new GlobalKey<FormState>();

  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  int currentIndex = 0;
  String selectedIndex = 'TAB: 0';
  String email = "",
      name = "",
      id = "",
      mobile = "",
      password = "",
      points = "";
  TabController tabController;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.reload();
      id = preferences.getString("id");
      email = preferences.getString("email");
      points = preferences.getString("points");
    });
  }

  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Color(0xFF4267B2),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.keyboard_backspace),
                iconSize: 30,
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                }),
            SizedBox(
              width: 90,
            ),
            Container(
                margin: EdgeInsets.only(
                  top: 10,
                ),
                child: Text(
                  "Mon espace",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: "QueenBold"),
                )),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          Center(
            child: Container(
              child: Form(
                key: _key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: 300,
                      child: Text(
                        "CUMULEZ VOS POINTS!",
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: "Queen",
                            color: Colors.black,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 300,
                      child: Text(
                        "Gagnez des points de fidélité avec votre application IΛCOM Garagiste",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Queen",
                            color: Colors.black,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    ClipRRect(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        child: Container(
                          color: Color(0xFF4267B2),
                          height: 200,
                          width: 250,
                          child: Align(
                            alignment: Alignment(0, 0),
                            widthFactor: 0.5,
                            heightFactor: 0.5,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              child: Container(
                                  color: Color(0xFFb0caff),
                                  height: 150,
                                  width: 200,
                                  child: Center(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            '$points',
                                            style: TextStyle(
                                                fontSize: 60,
                                                fontFamily: "Queen",
                                                color: Colors.black,
                                                fontWeight: FontWeight.w900),
                                          ),
                                          Text(
                                            "Points",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: "Queen",
                                                color: Colors.black,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        ]),
                                  )),
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
