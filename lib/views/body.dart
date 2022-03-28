import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iacomappgaragiste/views/accueil.dart';
import 'package:iacomappgaragiste/views/nos_services.dart';
import 'package:iacomappgaragiste/views/contact.dart';
import 'package:iacomappgaragiste/views/reservation.dart';
import 'package:iacomappgaragiste/views/prestations_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BodyState();
  }
}

class BodyState extends State<Body> {

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String token1;
  int currentindex=0;

  List<Widget> widgetOptions = <Widget>[
    Accueil(),
    NosServices(),
    Prestations(),
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

  void firebaseCloudMessaging_Listeners() {
    _firebaseMessaging.getToken().then((token) {
      print("Token is " + token);
      setState(() {
        token1 = token;
      });
    });
  }

  subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  @override
  void initState() {
    super.initState();
    getPref();
    changeItem(currentindex);
      subscribeToTopic('iacomgarage');
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('${message['notification']['title']}'),
                content: Text(
                    '${message['notification']['body']}'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      },
    );
    firebaseCloudMessaging_Listeners();
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
              icon: Icon(FontAwesomeIcons.carAlt, color: Colors.white),
              title: 'Service'),
          TabItem(
              icon: Icon(FontAwesomeIcons.wrench,color: Colors.white),
              title: 'Prestation'),
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
