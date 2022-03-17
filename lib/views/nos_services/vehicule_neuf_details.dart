import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iacomappgaragiste/models/article.dart';

class VehiculeNDetailsScreen extends StatelessWidget {
  final Article vehiculeN;

  VehiculeNDetailsScreen(this.vehiculeN);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                        height: 50,
                        width: 50,
                        child: RaisedButton(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 15,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            }))
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      'http://iacomapp.cest-la-base.fr/${vehiculeN.image_art}',
                      fit: BoxFit.fill,
                      width: 250,
                      height: 250,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 45,
                      ),
                      Container(
                            width: 190,
                            child: Text(
                              '${vehiculeN.nom_art}',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                fontFamily: "QueenSemiBold",
                              ),
                            ),
                          ),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 5),
                    child: Text(
                      '${vehiculeN.prix_art}',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w100,
                        fontFamily: "QueenBold",
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      '€',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        fontFamily: "QueenBold",),
                    ),
                  ),
                ]),
                SizedBox(
                  height: 10,
                ),
                Container(width: 300, child: Divider()),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 300,
                  child: Text(
                    'Détails',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontFamily: "QueenSemiBold"),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: 300,
                  child: Text(
                    '${vehiculeN.description}',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 15, color: Colors.black, fontFamily: "Queen"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
