import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:iacomappgaragiste/views/body.dart';
import 'package:iacomappgaragiste/views/nav_bar.dart';
import 'package:intl/intl.dart';

class ReservationVN extends StatefulWidget {
  @override
  _ReservationVNState createState() => _ReservationVNState();
}

class _ReservationVNState extends State<ReservationVN> {
  final _key = new GlobalKey<FormState>();

  List dataAllVN = List();
  String selectedVN;

  Future getAllVN()async{
    var response = await http.get("http://iacomapp.cest-la-base.fr/vehicule_neuf.php", headers: {"Accept":"application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    setState((){
      dataAllVN = jsonData;
    });
  }


  String nom = "", mail = "", tel = "", detail = "";

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      submit();
    }
  }

  submit() async {
    final response = await http
        .post("http://iacomapp.cest-la-base.fr/reservation_garagiste.php", body: {
      "nom": nom,
      "mail": mail,
      "tel": tel,
      "vehicule_n": selectedVN,
      "vehicule_o": "",
      "info_complementaire": detail,
      "dates_resa": "${DateFormat('yyyy/MM/dd').format(selectedDateResa.toLocal())}".split(' ')[0],
      "heure_resa": '${time.hour}:${time.minute}',
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      print(message);
      editToast(message);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Body()),
      );
    } else {
      print(message);
      editToast(message);
    }
  }

  editToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 2,
        backgroundColor: Color(0xFF4267B2),
        textColor: Colors.white);
  }
  /////////////////////////////////////////////////date picker //////////////////////////////////////////////////////////

  List<DateTime> datesResa;
  DateTime selectedDateResa = DateTime.now();
  DateTime dates_resa;

  Future<void> _selectDateResa(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        locale: const Locale("fr", "FR"),
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2023),
        //selectableDayPredicate: (DateTime val) => datesResa.contains(val),
        builder: (context, child) {
          return Theme(
            data: ThemeData(
              primaryColor: const Color(0xFF4267B2),
              accentColor: const Color(0xFF4267B2),
              colorScheme: ColorScheme.light(primary: const Color(0xFF4267B2),),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child,
          );
        });
    if (picked != null && picked != selectedDateResa)
      setState(() {
        selectedDateResa = picked as DateTime;
        print("selectedDateResa");
        print(selectedDateResa);
      });
  }

  /////////////////////////////////////////////////time picker //////////////////////////////////////////////////////////

  TimeOfDay time, picked;

  @override
  void initState(){
    super.initState();
    time = TimeOfDay.now();
    getAllVN();
  }

  Future<Null> selectTime(BuildContext context) async{
    picked = await showTimePicker(
      context: context,
      initialTime: time,
      initialEntryMode: TimePickerEntryMode.input,
      builder: (context, child) {
        return new Localizations.override(
            context: context,
            locale: const Locale("fr", "FR"),
            child: child,
          );
      },
    );
    if(picked != null){
      setState(() {
        time = picked;
        print(time);
        print("time");
      });
    }
  }

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
                  Navigator.pop(context);
                }),
            SizedBox(
              width: 90,
            ),
            Container(
                margin: EdgeInsets.only(
                  top: 10,
                ),
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
              child: Form(
                key: _key,
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 0, bottom: 5),
                      child: Text(
                        "RÉSERVEZ MAINTENANT!",
                        style: TextStyle(
                          fontSize: 13.7,
                          color: Colors.black,
                          fontFamily: "QueenBold",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Card(
                      color: Color(0xFF4267B2),
                      margin: const EdgeInsets.only(
                          right: 60, left: 60, bottom: 10, top: 10),
                      elevation: 6.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: TextFormField(
                        onSaved: (e) => nom = e,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 20, right: 15),
                              child: Icon(Icons.person, color: Colors.white),
                            ),
                            contentPadding: EdgeInsets.all(10),
                            labelStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: "Queen",
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                            labelText: "Nom et Prénom"),
                      ),
                    ),
                    Card(
                      color: Color(0xFF4267B2),
                      margin: const EdgeInsets.only(
                          right: 60, left: 60, bottom: 10, top: 10),
                      elevation: 6.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (e) {
                          if (e.isEmpty) {
                            return "Veuillez entrer votre mail";
                          } else if (!EmailValidator.validate(e)) {
                            return "Mail invalide";
                          }
                        },
                        onSaved: (e) => mail = e,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 20, right: 15),
                              child: Icon(Icons.mail, color: Colors.white),
                            ),
                            contentPadding: EdgeInsets.all(10),
                            labelStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: "Queen",
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                            labelText: "E-mail"),
                      ),
                    ),
                    Card(
                      color: Color(0xFF4267B2),
                      margin: const EdgeInsets.only(
                          right: 60, left: 60, bottom: 10, top: 10),
                      elevation: 6.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (e) {
                          if (e.isEmpty) {
                            return "Saisissez votre numéro de téléphone";
                          } else if (e.length < 10) {
                            return "Numéro de téléphone est invalide";
                          }
                        },
                        onSaved: (e) => tel = e,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 20, right: 15),
                              child: Icon(Icons.phone, color: Colors.white),
                            ),
                            contentPadding: EdgeInsets.all(10),
                            labelStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: "Queen",
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                            labelText: "Téléphone"),
                      ),
                    ),
                    Card(
                      color: Color(0xFF4267B2),
                      margin: const EdgeInsets.only(
                          right: 60, left: 60, bottom: 10, top: 10),
                      elevation: 6.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                              padding:
                                  EdgeInsets.only(left: 60, top: 11, right: 20),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  dropdownColor: Color(0xFF5689f0),
                                  hint: Text(
                                    'Véhicule neuf',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Queen",
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  value: selectedVN,
                                  onChanged: (newValue) async {
                                    setState(() {
                                      selectedVN = newValue;
                                    });
                                    if(selectedVN == null){
                                      selectedVN = "";
                                    }
                                  },
                                  items: dataAllVN.map((list) {
                                    return DropdownMenuItem(
                                      child: new Text(list['nom_art']),
                                      value: list['nom_art'].toString(),
                                    );
                                  }).toList(),
                                ),
                              ))
                        ],
                      ),
                    ),
                    Card(
                      color: Color(0xFF4267B2),
                      margin: const EdgeInsets.only(
                          right: 60, left: 60, bottom: 10, top: 10),
                      elevation: 6.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: TextFormField(
                        maxLength: 2000,
                        maxLines: null,
                        onSaved: (e) => detail = e,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 20, right: 15),
                              child: Icon(Icons.blur_on, color: Colors.white),
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.all(10),
                            labelStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: "Queen",
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                            labelText: "Détail sur votre réservation"),
                      ),
                    ),
                    GestureDetector(
                  onTap: () async {
                    await _selectDateResa(context);
                  },
                  child:Card(
                    margin: const EdgeInsets.only(
                        right: 60, left: 60, bottom: 10, top: 10),
                    color: Color(0xFF4267B2),
                    elevation: 6.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Icon(FontAwesomeIcons.calendarAlt,
                                color: Colors.white),
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 10, bottom: 5, top: 5),
                                  child: Text(
                                    "Date réservation",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Queen",
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 10, bottom: 5, top: 5),
                                  child: Text(
                                    "${DateFormat('dd/MM/yyyy').format(selectedDateResa.toLocal())}"
                                        .split(' ')[0],
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Queen",
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900),
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                    GestureDetector(
                        onTap: () async {
                          await selectTime(context);
                        },
                        child:Card(
                          margin: const EdgeInsets.only(
                              right: 60, left: 60, bottom: 10, top: 10),
                          color: Color(0xFF4267B2),
                          elevation: 6.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Icon(Icons.watch_later, color: Colors.white),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 10, bottom: 5, top: 5),
                                        child: Text(
                                          "Heure réservation",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: "Queen",
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 15, bottom: 5, top: 5),
                                        child: Text(
                                          '${time.hour}:${time.minute}',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: "Queen",
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 2,
                      shadowColor: Colors.blueGrey,
                      child: Container(
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            check();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Envoyer votre demande",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "Queen",
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}