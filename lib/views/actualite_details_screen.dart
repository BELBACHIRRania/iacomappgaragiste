import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iacomappgaragiste/models/actualite.dart';
import 'package:iacomappgaragiste/views/actualite_list.dart';
import 'package:iacomappgaragiste/views/nav_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class ActualiteDetailsScreen extends StatelessWidget {
  final Actualite actualite;

  ActualiteDetailsScreen(this.actualite);

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
                    MaterialPageRoute(builder: (context) => ActualiteScreen()),
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
                  "Actualités",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: "QueenBold"),
                )),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    'http://iacomapp.cest-la-base.fr/${actualite.image_act}',
                    fit: BoxFit.cover,
                    width: 300,
                    height: 200,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${actualite.titre_act}',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w900),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  '${actualite.description_act}',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
              ),
              GestureDetector(
                  child: actualite.moreLink == null
                      ? Container()
                      : new Text(
                          "${actualite.moreLink}",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.indigo,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w900),
                        ),
                  onTap: () {
                    launch('${actualite.moreLink}');
                  }),
              Padding(
                padding: const EdgeInsets.all(8.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
