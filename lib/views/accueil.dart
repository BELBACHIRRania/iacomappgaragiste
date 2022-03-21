import 'package:flutter/material.dart';
import 'package:iacomappgaragiste/views/carousel_slider/main_carousel_slider.dart';
import 'package:iacomappgaragiste/views/nav_bar.dart';

class Accueil extends StatelessWidget {
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
                width: 105,
              ),
              Container(
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "IΛCOM Garage",
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
                    height: 320,
                    width: 500,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
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
                        "Le garage IACOM vous accueille à Biarritz(64), dans le département des Pyrénées-Atlantiques en région Aquitaine.\n"
                            "Votre garage vous offre un service professionnel d'entretien et de réparations de flottes de véhicules commerciaux et institutionnels. Des experts en service automobile vous accompagnent pour l'entretien et les réparation en mécanique générale : pare-brise, vitres d'autos et/ou pneus",style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
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
