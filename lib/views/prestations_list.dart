import 'package:flutter/material.dart';
import 'package:iacomappgaragiste/models/article.dart';
import 'package:iacomappgaragiste/services/prestations-api.dart';
import 'package:iacomappgaragiste/views/body.dart';
import 'package:iacomappgaragiste/views/nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prestations extends StatefulWidget {
  @override
  _PrestationsState createState() => _PrestationsState();
}

class _PrestationsState extends State<Prestations> {
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
            SizedBox(
              width: 130,
            ),
            Container(
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Prestations",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: "QueenBold"),
                    ))),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder(
            future: fetchArticle(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, index) {
                      Article menus = snapshot.data[index];
                      return GestureDetector(
                          onTap: () async {
                            currentindex = 3;
                        await savePref(currentindex);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Body(),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 20, right: 15, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(2, 2),
                              blurRadius: 5,
                              spreadRadius: 1.0,
                              color: Color(0xFFB0CCE1).withOpacity(0.32),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20),
                              ),
                              child: Image.network(
                                'http://iacomapp.cest-la-base.fr/${menus.image_art}',
                                height: MediaQuery.of(context).size.height / 5,
                                fit: BoxFit.fill,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                            SizedBox(height: 5),

                            SizedBox(height: 10),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Container(
                                    child: Text(
                                      '${menus.nom_art}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontFamily: "QueenBold",
                                      ),
                                    ),
                                  ),
                                ]
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 30),
                              width: 300,
                              alignment: Alignment.center,
                              child: Text(
                                '${menus.sous_titre}',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black,
                                    fontFamily: "QueenSemiBold"),
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      )
                      );
                    });
              }
              return SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xFF4267B2),
                          ),
                          strokeWidth: 5),
                    ],
                  ));
            },
          ),
        ),
      ),
    );
  }
}
