import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iacomappgaragiste/models/article.dart';
import 'package:iacomappgaragiste/services/vehicule_occasion-api.dart';
import 'package:iacomappgaragiste/views/nos_services/vehicule_occasion_details.dart';

class VehiculeOList extends StatefulWidget {
  @override
  _VehiculeOListState createState() => _VehiculeOListState();
}

class _VehiculeOListState extends State<VehiculeOList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                      Article vehiculeO = snapshot.data[index];
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  VehiculeODetailsScreen(vehiculeO),
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height / 5,
                              margin: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
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
                            ),
                            Positioned(
                              top: 10,
                              left: 20,
                              right: 150,
                              child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 5,
                                            bottom: 5),
                                        child: Text(
                                          '${vehiculeO.nom_art}',
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black,
                                            fontFamily: "QueenBold",
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 5,
                                            bottom: 5),
                                        child: Text(
                                          '${vehiculeO.sous_titre}',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontFamily: "QueenSemiBold",
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                            ),
                            Positioned(
                              bottom: 5,
                              left: 20,
                              right: 170,
                              child: Container(
                                        margin: EdgeInsets.only(
                                            left: 20, right: 5, bottom: 10),
                                        child: Text(
                                          '${vehiculeO.prix_art} €',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w100,
                                            fontFamily: "QueenBold",
                                          ),
                                        ),
                                      ),
                            ),
                            Positioned(
                              top: 10,
                              left: 220,
                              right: 27,
                              bottom: 10,
                              child: Image.network(
                                'http://iacomapp.cest-la-base.fr/${vehiculeO.image_art}',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
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
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xFF4267B2),),
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
