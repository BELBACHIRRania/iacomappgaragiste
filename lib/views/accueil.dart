import 'package:flutter/material.dart';
import 'package:iacomappgaragiste/views/carousel_slider/main_carousel_slider.dart';
import 'package:iacomappgaragiste/views/nav_bar.dart';

class Accueil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
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
                width: 90,
              ),
              Container(
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "IΛCOM Garagiste",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: "QueenBold"),
                      ))),
            ],
          ),
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
                child: Column(
                    children: <Widget>[
                      SizedBox(height: 20),
                      Container(height: 230, child: CarouselDemo()),
                      SizedBox(height: 5),
                      Container(
                    height: 400,
                    width: 500,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0x73000000),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(2, 2),
                          blurRadius: 5,
                          spreadRadius: 5,
                          color: Color(0xFFB0CCE1).withOpacity(0.15),
                        ),
                      ],
                    ),
                    margin: EdgeInsets.only(left: 30, right: 30),
                    padding:
                        EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                    child: Text(
                        "IΛCOM Restaurant est un restaurant asiatique situé dans le département de la Gironde, à Bassens. Spécialisés dans la cuisine japonaise et thaïlandaise, nous vous proposons le meilleur Sushi à Bassens\n"
                        "\nDe la décoration jusqu’à dans l'assiette notre maître mot est le dépaysement. La légendaire zénitude asiatique s’exprime à travers une décoration branchée aux tons neutres, un cadre en osmose avec la musique d’ambiance aux airs chill-out. Fraîcheur et qualité supérieure sont les mots d’ordre côté cuisine. ",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontFamily: "QueenSemiBold"),
                        textAlign: TextAlign.justify),
                  ),
                    ]
                )
            )
        )
    );
  }
}
