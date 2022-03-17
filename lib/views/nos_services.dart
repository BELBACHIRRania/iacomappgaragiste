import 'package:flutter/material.dart';
import 'package:iacomappgaragiste/views/nav_bar.dart';
import 'package:iacomappgaragiste/views/nos_services/vehicule_neuf_list.dart';

class NosServices extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NosServicesState();
  }
}

class NosServicesState extends State<NosServices> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
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
                width: 120,
              ),
              Text(
                "Nos services",
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
                            "Véhicules neufs",
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
                            "Véhicules d'occasion",
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
            VehiculeNList(),
            VehiculeNList(),
          ],
        ),
      ),
      length: 2,
      initialIndex: 0,
    );
  }
}
