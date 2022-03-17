import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iacomappgaragiste/views/contact_option_pages/gps.dart';
import 'package:iacomappgaragiste/views/contact_option_pages/horaires.dart';
import 'package:iacomappgaragiste/views/contact_option_pages/information.dart';
import 'package:iacomappgaragiste/views/nav_bar.dart';

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        backgroundColor: Colors.white,
        endDrawer: NavBar(),
        appBar: AppBar(
          backgroundColor: Color(0xFF4267B2),
          automaticallyImplyLeading: false,
          elevation: 5,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 140,
              ),
              Text(
                "Contact",
                style: TextStyle(
                    fontSize: 20, color: Colors.white, fontFamily: "QueenBold"),
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size(100, 50),
            child: Container(
              width: 400,
              child: TabBar(
                  indicatorColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: <Widget>[
                    Tab(
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "INFOS",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Queen",
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                          )),
                    ),
                    Tab(
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "HORAIRES",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Queen",
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                          )),
                    ),
                    Tab(
                      child: Container(
                          width: 180,
                          child: Text(
                            "PLAN D'ACCES",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Queen",
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                          )),
                    ),
                  ]),
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Information(),
            Horaires(),
            PlanAcces(),
          ],
        ),
      ),
      length: 3,
      initialIndex: 0,
    );
  }
}
