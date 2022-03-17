import 'package:flutter/material.dart';

class Horaires extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(2, 2),
                      blurRadius: 5,
                      spreadRadius: 1.0,
                      color: Color(0xFFB0CCE1).withOpacity(0.15),
                    ),
                  ],
                ),
                margin: EdgeInsets.only(top: 20, left: 50, right: 50),
                padding: EdgeInsets.only(top: 10, left: 20, right: 15),
                child: Center(
                  child: Text(
                    "Du Lundi au Samedi de 10h à 15h et de 19h à 22h30",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontFamily: "QueenSemiBold",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
