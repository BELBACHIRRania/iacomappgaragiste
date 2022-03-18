import 'package:flutter/material.dart';
import 'package:iacomappgaragiste/views/nav_bar.dart';
import 'package:iacomappgaragiste/views/reservation_vn.dart';
import 'package:iacomappgaragiste/views/reservation_vo.dart';

class Reservation extends StatefulWidget {
  @override
  _ReservationState createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
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
                        "Réservation",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: "QueenBold"),
                      ))),
            ],
          ),
        ),
        body: ListView(
            children: [
              Center(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ReservationVN()),
                            );
                          },
                          child: Card(
                              color: Color(0xFF4267B2),
                              margin: const EdgeInsets.only(right: 20, left: 20, bottom: 10, top: 250),
                              elevation: 6.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Container(
                                margin: const EdgeInsets.only(top: 20),
                                width: 220,
                                height: 40,
                                child: Text("Véhicules neufs",textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              )
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ReservationVO()),
                            );
                          },
                          child: Card(
                              color: Color(0xFF4267B2),
                              margin: const EdgeInsets.only(right: 20, left: 20, bottom: 10, top: 20),
                              elevation: 6.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Container(
                                margin: const EdgeInsets.only(top: 20),
                                width: 220,
                                height: 40,
                                child: Text("Véhicules d'occasion",textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              )
                          ),
                        )
                      ]
                    )
                  )
              )
            ]
        )
    );
  }
}
