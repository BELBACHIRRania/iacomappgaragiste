import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iacomappgaragiste/views/accueil.dart';
import 'package:iacomappgaragiste/views/nos_services.dart';
import 'package:iacomappgaragiste/views/contact.dart';
import 'package:iacomappgaragiste/views/reservation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BodyState();
  }
}

class BodyState extends State<Body> {
  int currentindex;

  List<Widget> widgetOptions = <Widget>[
    Accueil(),
    NosServices(),
    Reservation(),
    Reservation(),
    Contact(),
  ];

  void changeItem(int value) {
    print(value);
    setState(() {
      currentindex = value;
    });
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.reload();
      currentindex = preferences.getInt("currentindex");
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
    changeItem(currentindex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: 'Accueil'),
          TabItem(
              icon: Icon(FontAwesomeIcons.bookOpen, color: Colors.white),
              title: 'Services'),
          TabItem(
              icon: Icon(Icons.restaurant_menu, color: Colors.white),
              title: 'Menu'),
          TabItem(
              icon: Icon(Icons.bookmark, color: Colors.white),
              title: 'Reservation'),
          TabItem(
              icon: Icon(Icons.near_me, color: Colors.white), title: 'Contact'),
        ],
        initialActiveIndex: currentindex,
        onTap: changeItem,
        backgroundColor: Color(0xFF4267B2),
        activeColor: Color(0xFF34518c),
      ),
      body: widgetOptions.elementAt(currentindex),
    );
  }
}
