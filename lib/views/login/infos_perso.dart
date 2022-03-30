import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iacomappgaragiste/views/login/modifier_profil.dart';
import 'package:iacomappgaragiste/views/login/sharedloginregister.dart';
import 'package:iacomappgaragiste/views/nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qr_flutter/qr_flutter.dart';

class InfosPerso extends StatefulWidget {
  final VoidCallback signOut;
  String name, email, mobile, password, points;

  InfosPerso(this.signOut, this.name, this.email, this.mobile, this.password, this.points);

  @override
  _InfosPersoState createState() => _InfosPersoState();
}

class _InfosPersoState extends State<InfosPerso> {
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
      id_user = "",
      mobile = "",
      password = "",
      status = "",
      points = "";
  TabController tabController;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.reload();
      id_user = preferences.getString("id_user");
      email = preferences.getString("email");
      name = preferences.getString("name");
      password = preferences.getString("password");
      points = preferences.getString("points");
      mobile = preferences.getString("mobile");
    });
  }

  void initState() {
    // TODO: implement initState
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MainMenu(signOut, id_user, name,
                            email, mobile, password, status, points)),
                  );
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
      body: Center(
        child: ListView(
          children: <Widget>[
            Center(
              child: Container(
                child: Form(
                  key: _key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                      ),
                      QrImage(

                        foregroundColor: Color(0xFF4267B2),
                        backgroundColor: Colors.white,
                        data: email,
                        version: QrVersions.auto,
                        size: 270.0,
                        gapless: false,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: 40,
                        width: 250,
                        child: Text(
                          name,
                          style: TextStyle(
                            fontSize: 13.7,
                            color: Colors.black,
                            fontFamily: "QueenBold",
                            //fontWeight: FontWeight.w900
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 250,
                        child: Text(
                          '$email',
                          style: TextStyle(
                            fontSize: 13.7,
                            color: Colors.black,
                            fontFamily: "QueenBold",
                            //fontWeight: FontWeight.w900
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 250,
                        child: Text(
                          '$mobile',
                          style: TextStyle(
                            fontSize: 13.7,
                            color: Colors.black,
                            fontFamily: "QueenBold",
                            //fontWeight: FontWeight.w900
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                        height: 44.0,
                        width: 200,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Text(
                              "Modifier profil",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Queen",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900),
                            ),
                            textColor: Colors.black,
                            color: Colors.white,
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ModifierProfil(
                                        id_user,
                                        email,
                                        name,
                                        mobile,
                                        password,
                                        signOut)),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
