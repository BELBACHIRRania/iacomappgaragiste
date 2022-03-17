import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:iacomappgaragiste/views/login/sharedloginregister.dart';
import 'package:iacomappgaragiste/views/nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModifierPassword extends StatefulWidget {
  final String id_user, email, name, mobile, password;
  final VoidCallback signOut;

  ModifierPassword(this.id_user, this.email, this.name, this.mobile,
      this.password, this.signOut);

  @override
  _ModifierPasswordState createState() => _ModifierPasswordState();
}

class _ModifierPasswordState extends State<ModifierPassword> {
  String id_user,
      name = "",
      email = "",
      mobile = "",
      password = "",
      points = "",
      status = "";
  final _key = new GlobalKey<FormState>();

  TextEditingController txtpassword, txtnewpassword, txtconfirmnewpassword;

  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  setup() {
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
        .post("http://iacomapp.cest-la-base.fr/modifier_password.php", body: {
      "id_user": widget.id_user,
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
            builder: (context) => MainMenu(signOut, id_user, name, email,
                mobile, password, status, points)),
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
        backgroundColor: Color(0xFFFFCC80),
        textColor: Colors.white);
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.reload();
      password = preferences.getString("password");
      print("password");
      print(password);
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
    setup();
  }

  savePref(String password) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
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
                        controller: txtpassword,
                        validator: (e) {
                          if (e.isEmpty) {
                            return "Saisissez votre mot de passe";
                          } else if (e.length < 8) {
                            return "Mot de passe incorrect";
                          } else if (widget.password != txtpassword.text) {
                            return "Mot de passe incorrect";
                          }
                        },
                        obscureText: _secureText,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "Mot de passe",
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 20, right: 15),
                            child:
                                Icon(Icons.phonelink_lock, color: Colors.black),
                          ),
                          suffixIcon: IconButton(
                            onPressed: showHide,
                            icon: Icon(_secureText
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          contentPadding: EdgeInsets.all(10),
                          labelStyle: TextStyle(
                              fontSize: 14,
                              fontFamily: "Queen",
                              color: Colors.black,
                              fontWeight: FontWeight.w900),
                        ),
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
                        controller: txtnewpassword,
                        validator: (e) {
                          if (e.isEmpty) {
                            return "Saisissez un mot de passe";
                          } else if (e.length < 8) {
                            return "Utilisez 8 caractères ou plus";
                          } else if (txtnewpassword.text !=
                              txtconfirmnewpassword.text) {
                            return "les mots de passe ne sont pas identiques!";
                          }
                        },
                        obscureText: _secureText,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "Nouveau mot de passe",
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 20, right: 15),
                            child:
                                Icon(Icons.phonelink_lock, color: Colors.black),
                          ),
                          suffixIcon: IconButton(
                            onPressed: showHide,
                            icon: Icon(_secureText
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          contentPadding: EdgeInsets.all(10),
                          labelStyle: TextStyle(
                              fontSize: 14,
                              fontFamily: "Queen",
                              color: Colors.black,
                              fontWeight: FontWeight.w900),
                        ),
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
                        controller: txtconfirmnewpassword,
                        onSaved: (e) => password = e,
                        validator: (e) {
                          if (e.isEmpty) {
                            return "Saisissez un mot de passe";
                          } else if (e.length < 8) {
                            return "Utilisez 8 caractères ou plus";
                          } else if (txtnewpassword.text !=
                              txtconfirmnewpassword.text) {
                            return "les mots de passe ne sont pas identiques!";
                          }
                        },
                        obscureText: _secureText,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "Confirmer mot de passe",
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 20, right: 15),
                            child:
                                Icon(Icons.phonelink_lock, color: Colors.black),
                          ),
                          suffixIcon: IconButton(
                            onPressed: showHide,
                            icon: Icon(_secureText
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          contentPadding: EdgeInsets.all(10),
                          labelStyle: TextStyle(
                              fontSize: 14,
                              fontFamily: "Queen",
                              color: Colors.black,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(12.0),
                    ),
                    SizedBox(
                      height: 44.0,
                      width: 200,
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
                          onPressed: () async {
                            check();
                            await savePref(password);
                            print(password);
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
