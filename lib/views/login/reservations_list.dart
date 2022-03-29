import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:iacomappgaragiste/models/reservations.dart';
import 'package:iacomappgaragiste/services/reservations-api.dart';
import 'package:iacomappgaragiste/views/body.dart';
import 'package:iacomappgaragiste/views/nav_bar.dart';

class ReservationsList extends StatelessWidget {
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
            IconButton(
                icon: Icon(Icons.keyboard_backspace),
                iconSize: 30,
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Body()),
                  );
                }),
            SizedBox(
              width: 80,
            ),
            Container(
                margin: EdgeInsets.only(
                  top: 10,
                ),
                child: Text(
                  "Réservations",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: "QueenBold"),
                )),
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 30),
        child: FutureBuilder(
          future: fetchReservations(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      child: Table(
                          border: TableBorder.all(color: Color(0xFF34518c),), // Allows to add a border decoration around your table
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          defaultColumnWidth: FixedColumnWidth(200),
                          children: [
                            TableRow(
                                decoration: BoxDecoration(color: Colors.grey[300], ),
                                children :[
                                  Container(
                                    width: 200,
                                    child: Column(
                                      children: [
                                        Container(
                                            padding: const EdgeInsets.all(15),
                                            height: 50,
                                            width: 200,
                                            child: Text('Nom & Prénom',)
                                        ),
                                        Divider(color: Color(0xFF34518c),thickness: 2,),
                                        Container(
                                          padding: const EdgeInsets.all(15),
                                          height: 50,
                                          width: 200,
                                          child:
                                          Text('E-mail'),
                                        ),
                                        Divider(color: Color(0xFF34518c),thickness: 2,),
                                        Container(
                                          padding: const EdgeInsets.all(15),
                                          height: 50,
                                          width: 200,
                                          child:
                                          Text('Numéro de téléphone'),
                                        ),
                                        Divider(color: Color(0xFF34518c),thickness: 2,),
                                        Container(
                                          padding: const EdgeInsets.all(15),
                                          height: 50,
                                          width: 200,
                                          child:
                                          Text('Véhicule neufs'),
                                        ),
                                        Divider(color: Color(0xFF34518c),thickness: 2,),
                                        Container(
                                            padding: const EdgeInsets.all(15),
                                            height: 50,
                                            width: 200,
                                            child:
                                            Text("Véhicule d'occasion")
                                        ),
                                        Divider(color: Color(0xFF34518c),thickness: 2,),
                                        Container(
                                          padding: const EdgeInsets.all(15),
                                          height: 50,
                                          width: 200,
                                          child:
                                          Text('Informations complémentaires'),
                                        ),
                                        Divider(color: Color(0xFF34518c),thickness: 2,),
                                        Container(
                                          padding: const EdgeInsets.all(15),
                                          height: 50,
                                          width: 200,
                                          child:
                                          Text('Dates de réservation'),
                                        ),
                                        Divider(color: Color(0xFF34518c),thickness: 2,),
                                        Container(
                                          padding: const EdgeInsets.all(15),
                                          height: 50,
                                          width: 200,
                                          child:
                                          Text('Heure de réservation'),
                                        ),
                                      ],
                                    ),
                                  )
                                ]),
                          ]
                      ),
                    ),
                    ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.all(0),
                      itemCount: snapshot.data.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, index) {
                        Reservations reservations = snapshot.data[index];
                        return Table(
                            border: TableBorder.all(color: Color(0xFF34518c),), // Allows to add a border decoration around your table
                            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                            defaultColumnWidth: FixedColumnWidth(250),
                            children: [
                              TableRow(
                                  decoration: BoxDecoration(color: Colors.grey[200], ),
                                  children :[
                                    Container(
                                      child: Column(
                                        children: [
                                          Container(
                                              padding: const EdgeInsets.all(8),
                                              height: 50,
                                              width: 250,
                                              child: Text('${reservations.nom}',)
                                          ),
                                          Divider(color: Color(0xFF34518c),thickness: 2,),
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            height: 50,
                                            width: 250,
                                            child:
                                            Text('${reservations.mail}'),
                                          ),
                                          Divider(color: Color(0xFF34518c),thickness: 2,),
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            height: 50,
                                            width: 250,
                                            child:
                                            Text('0${reservations.tel}'),
                                          ),
                                          Divider(color: Color(0xFF34518c),thickness: 2,),
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            height: 50,
                                            width: 250,
                                            child:
                                            Text('${reservations.vehicule_n}'),
                                          ),
                                          Divider(color: Color(0xFF34518c),thickness: 2,),
                                          '${reservations.vehicule_o}'!=null?
                                          Container(
                                              padding: const EdgeInsets.all(8),
                                              height: 50,
                                              width: 250,
                                              child:
                                              Text('${reservations.vehicule_o}')
                                          ):
                                          Container(
                                              margin: const EdgeInsets.only(left: 80.0, right: 20.0),
                                              child: Text("------")
                                          ),
                                          Divider(color: Color(0xFF34518c),thickness: 2,),
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            height: 50,
                                            width: 250,
                                            child:
                                            Text('${reservations.info_complementaire}'),
                                          ),
                                          Divider(color: Color(0xFF34518c),thickness: 2,),
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            height: 50,
                                            width: 250,
                                            child:
                                            Text('${reservations.dates_resa}'),
                                          ),
                                          Divider(color: Color(0xFF34518c),thickness: 2,),
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            height: 50,
                                            width: 250,
                                            child:
                                            Text('${reservations.heure_resa}'),
                                          ),
                                        ],
                                      ),
                                    )
                                  ]),
                            ]
                        );
                      },
                    )
                  ],
                ),
              );
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
      )
    );
  }
}