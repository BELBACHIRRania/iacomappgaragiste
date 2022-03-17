import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:iacomappgaragiste/views/login/infos_perso.dart';
import 'package:iacomappgaragiste/views/nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModifierProfil extends StatefulWidget {
  final String id_user, email, name, mobile, password;
  final VoidCallback signOut;

  ModifierProfil(this.id_user, this.email, this.name, this.mobile,
      this.password, this.signOut);

  @override
  _ModifierProfilState createState() => _ModifierProfilState();
}

class _ModifierProfilState extends State<ModifierProfil> {
  String id_user,
      name = "",
      email = "",
      mobile = "",
      password = "",
      points = "";
  final _key = new GlobalKey<FormState>();

  TextEditingController txtname,
      txtmobile,
      txtpassword,
      txtnewpassword,
      txtconfirmnewpassword;

  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  setup() {
    txtname = TextEditingController(text: widget.name);
    txtmobile = TextEditingController(text: widget.mobile);
    txtpassword = TextEditingController();
    txtnewpassword = TextEditingController();
    txtconfirmnewpassword = TextEditingController();
  }

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      submit();
    }
  }

  submit() async {
    final response = await http
        .post("http://iacomapp.cest-la-base.fr/modifier_profil.php", body: {
      "id_user": widget.id_user,
      "name": name,
      "mobile": mobile,
      "password": password,
    });

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      print(message);
      editToast(message);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                InfosPerso(signOut, name, email, mobile, password, points)),
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
        timeInSecForIos: 1,
        backgroundColor: Color(0xFF4267B2),
        textColor: Colors.white);
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.reload();
      name = preferences.getString("name");
      mobile = preferences.getString("mobile");
      password = preferences.getString("password");
    });
  }

  @override
  void initState() {
    super.initState();
    setup();
  }

  savePref(String name, String mobile, String password) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("name", name);
      preferences.setString("mobile", mobile);
      preferences.setString("password", password);
      preferences.commit();
    });
  }

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
                child: Text(
                  "Mon espace",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: "QueenBold"),
                )),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          Center(
            child: Container(
              child: Form(
                key: _key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 4,
                    ),
                    Card(
                      color: Color(0xFF4267B2),
                      margin: const EdgeInsets.only(
                          right: 60, left: 60, bottom: 10, top: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: TextFormField(
                        controller: txtname,
                        onSaved: (e) => name = e,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 20, right: 15),
                              child: Icon(Icons.person, color: Colors.black),
                            ),
                            contentPadding: EdgeInsets.all(10),
                            labelStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: "Queen",
                                color: Colors.black,
                                fontWeight: FontWeight.w900),
                            labelText: "Nom et Prénom"),
                      ),
                    ),
                    Card(
                      color: Color(0xFF4267B2),
                      margin: const EdgeInsets.only(
                          right: 60, left: 60, bottom: 10, top: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: TextFormField(
                        controller: txtmobile,
                        validator: (e) {
                          if (e.isEmpty) {
                            return "Saisissez votre numéro de téléphone";
                          } else if (e.length < 10) {
                            return "Votre numéro de téléphone est invalide";
                          }
                        },
                        onSaved: (e) => mobile = e,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 20, right: 15),
                            child: Icon(Icons.phone, color: Colors.black),
                          ),
                          contentPadding: EdgeInsets.all(10),
                          labelStyle: TextStyle(
                              fontSize: 14,
                              fontFamily: "Queen",
                              color: Colors.black,
                              fontWeight: FontWeight.w900),
                          labelText: "Numéro de téléphone",
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(12.0),
                    ),
                    SizedBox(
                      height: 44.0,
                      width: 250,
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Text(
                            "Confirmer",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Queen",
                                color: Colors.black,
                                fontWeight: FontWeight.w900),
                          ),
                          textColor: Colors.black,
                          color: Colors.white,
                          onPressed: () {
                            check();
                            savePref(name, mobile, password);
                          }),
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
