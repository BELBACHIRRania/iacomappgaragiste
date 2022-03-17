import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iacomappgaragiste/views/actualite_list.dart';
import 'package:iacomappgaragiste/views/body.dart';
import 'package:iacomappgaragiste/views/login/sharedloginregister.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NavBarState();
  }
}

class NavBarState extends State<NavBar> {
  int currentindex = 0;

  savePref(int currentindex) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("currentindex", currentindex);
      preferences.commit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 200,
            color: Color(0xFF4267B2),
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(
                        left: 60, right: 5, bottom: 10, top: 60),
                    color: Color(0xFF4267B2),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "IΛCOM",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: "QueenBold"),
                    )
                ),
                Card(
                  margin: EdgeInsets.only(left: 95, right: 20, bottom: 10),
                  color: Colors.white,
                  child: Text(
                    " Garagiste ",
                    style: TextStyle(
                        color: Color(0xFF4267B2),
                        fontSize: 20,
                        fontFamily: "QueenBold"),
                  ),
                )
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.person, color: Colors.black87),
            title: Text(
              'Mon espace',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontFamily: "QueenSemiBold",
              ),
            ),
            onTap: () async {
              currentindex = 0;
              await savePref(currentindex);
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
          ),
          ListTile(
              leading: Icon(Icons.home, color: Colors.black87),
              title: Text(
                'Accueil',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontFamily: "QueenSemiBold",
                ),
              ),
              onTap: () async {
                currentindex = 0;
                await savePref(currentindex);
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Body()),
                );
              }),
          ListTile(
              leading: Icon(FontAwesomeIcons.carAlt, color: Colors.black87),
              title: Text(
                'Nos Services',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontFamily: "QueenSemiBold",
                ),
              ),
              onTap: () async {
                currentindex = 1;
                await savePref(currentindex);
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Body()),
                );
              }),
          ListTile(
              leading: Icon(FontAwesomeIcons.wrench, color: Colors.black87),
              title: Text(
                'Prestations',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontFamily: "QueenSemiBold",
                ),
              ),
              onTap: () async {
                currentindex = 2;
                await savePref(currentindex);
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Body()),
                );
              }),
          ListTile(
            leading: Icon(Icons.bookmark, color: Colors.black87),
            title: Text(
              'Réservation',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontFamily: "QueenSemiBold",
              ),
            ),
            onTap: () async {
              currentindex = 3;
              await savePref(currentindex);
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Body()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.blur_on, color: Colors.black87),
            title: Text(
              'Actualités',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontFamily: "QueenSemiBold",
              ),
            ),
            onTap: () async {
              currentindex = 0;
              await savePref(currentindex);
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ActualiteScreen()),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.near_me,
              color: Colors.black87,
            ),
            title: Text(
              'Nous contacter',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontFamily: "QueenSemiBold",
              ),
            ),
            onTap: () async {
              currentindex = 4;
              await savePref(currentindex);
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Body()),
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text(
              'QUITTER',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontFamily: "QueenSemiBold",
              ),
            ),
            leading: Icon(Icons.exit_to_app, color: Colors.black87),
            onTap: () => null,
          ),
        ],
      ),
    );
  }
}
