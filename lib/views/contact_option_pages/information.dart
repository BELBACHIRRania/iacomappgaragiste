import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iacomappgaragiste/views/contact_option_pages/launchBrowser.dart';

class Information extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 20, right: 15, top: 5, bottom: 4),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(left: 5, bottom: 5),
                child: Text(
                  "Avez-vous une question à nous poser, un commentaire ou une suggestion concernant nos services, n'hésitez pas à nous contacter !",
                  style: TextStyle(
                    fontSize: 13.7,
                    color: Colors.black,
                    fontFamily: "QueenBold",
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 300,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(2, 2),
                      blurRadius: 5,
                      spreadRadius: 1.0,
                      color: Color(0xFFB0CCE1).withOpacity(0.15),
                    ),
                  ],
                ),
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.white,
                    onPressed: () => makeCall('tel:+33970445545'),
                    child: Row(
                      children: [
                        Icon(Icons.phone, color: Colors.black),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Appeler',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontFamily: "QueenSemiBold",
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Discutez avec nous maintenant',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                fontFamily: "QueenSemiBold",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        )
                      ],
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 300,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(2, 2),
                      blurRadius: 5,
                      spreadRadius: 1.0,
                      color: Color(0xFFB0CCE1).withOpacity(0.15),
                    ),
                  ],
                ),
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.white,
                    onPressed: () => makeMail("mailto:info@iacom.fr"),
                    child: Row(
                      children: [
                        Icon(Icons.email, color: Colors.black),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'E-mail',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontFamily: "QueenSemiBold",
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Envoyer-nous un mail et nous\nreviendrons vers vous rapidement',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                fontFamily: "QueenSemiBold",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        )
                      ],
                    )),
              ),
            ]));
  }
}
