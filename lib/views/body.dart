import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
  int currentindex;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String token1;
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

  @override
  void initState() {
    super.initState();
    getPref();
    changeItem(currentindex);
    firebaseCloudMessaging_Listeners();
      subscribeToTopic('actus');
    var initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    // flutterLocalNotificationsPlugin.initialize(initializationSettings,
    //     onSelectNotification: selectNotification);
    //super.initState();

    _firebaseMessaging.configure(
      //onBackgroundMessage: myBackgroundHandler,
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
