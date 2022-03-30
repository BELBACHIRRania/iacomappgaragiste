import 'dart:convert';
import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:iacomappgaragiste/views/body.dart';
import 'package:iacomappgaragiste/views/login/ajouter_actualites.dart';
import 'package:iacomappgaragiste/views/login/infos_perso.dart';
import 'package:iacomappgaragiste/views/login/modifier_password.dart';
import 'package:iacomappgaragiste/views/login/points.dart';
import 'package:iacomappgaragiste/views/login/reservations_list.dart';
import 'package:iacomappgaragiste/views/login/scan_qr_ajouter.dart';
import 'package:iacomappgaragiste/views/login/scan_qr_supprimer.dart';
import 'package:iacomappgaragiste/views/nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:email_validator/email_validator.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

enum LoginStatus { notSignIn, signIn }

class _LoginState extends State<Login> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  String email, name, mobile, password, status, actif, points, id_user;
  final _key = new GlobalKey<FormState>();

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
      login();
    }
  }

  login() async {
    final response = await http
        .post("http://iacomapp.cest-la-base.fr/api_verification.php", body: {
      "flag": 1.toString(),
      "email": email,
      "password": password,
      "fcm_token": "test_fcm_token",
    });

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    String emailAPI = data['email'];
    String nameAPI = data['name'];
    String mobileAPI = data['mobile'];
    String passwordAPI = data['password'];
    String id_user = data['id_user'];
    String statusAPI = data['status'];
    String actifAPI = data['actif'];
    String pointsAPI = data['points'];
    if (value == 1) {
      setState(() {
        _loginStatus = LoginStatus.signIn;
        savePref(value, emailAPI, nameAPI, password, mobileAPI, id_user,
            statusAPI, actifAPI, pointsAPI);
      });
      loginToast(message);
    } else {
      print(message);
      loginToast(message);
    }
  }

  loginToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Color(0xFF4267B2),
        textColor: Colors.white);
  }

  savePref(int value, String email, String name, String password, String mobile,
      String id_user, String status, String actif, String points) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("name", name);
      preferences.setString("mobile", mobile);
      preferences.setString("email", email);
      preferences.setString("password", password);
      preferences.setString("id_user", id_user);
      preferences.setString("status", status);
      preferences.setString("actif", actif);
      preferences.setString("points", points);
      preferences.commit();
    });
  }

  var value;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
      points = preferences.getString("points");

      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", null);
      preferences.setString("name", null);
      preferences.setString("email", null);
      preferences.setString("id", null);

      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  int currentindex = 0;

  savePrefindex(int currentindex) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("currentindex", currentindex);
      preferences.commit();
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return Scaffold(
          endDrawer: NavBar(),
          body: ListView(
            children: <Widget>[
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [Color(0xFF4267B2), Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )),
                  child: Form(
                    key: _key,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 30,
                            ),
                            SizedBox(
                                height: 50,
                                width: 50,
                                child: RaisedButton(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0),
                                    ),
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      size: 15,
                                    ),
                                    onPressed: () {
                                      currentindex=0;
                                    savePrefindex(currentindex);
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => Body()),
                                    );
                                    }))
                          ],
                        ),
                        SizedBox(
                          height: 150,
                        ),
                        Card(
                          color: Color(0xFF4267B2),
                          margin: const EdgeInsets.only(
                              right: 60, left: 60, bottom: 10, top: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            validator: (e) {
                              if (e.isEmpty) {
                                return "Veuillez entrer votre mail";
                              } else if (!EmailValidator.validate(e)) {
                                return "Votre mail est invalide";
                              }
                            },
                            onSaved: (e) => email = e,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(left: 20, right: 15),
                                  child:
                                      Icon(Icons.person, color: Colors.white),
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
                            onSaved: (e) => password = e,
                            validator: (e) {
                              if (e.isEmpty) {
                                return "Veuillez entrer votre mot de passe";
                              } else if (e.length < 8) {
                                return "Votre mot de passe est invalide";
                              }
                            },
                            obscureText: _secureText,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "Mot de passe",
                              labelStyle: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Queen",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(left: 20, right: 15),
                                child: Icon(Icons.phonelink_lock,
                                    color: Colors.white),
                              ),
                              suffixIcon: IconButton(
                                onPressed: showHide,
                                icon: Icon(_secureText
                                    ? Icons.visibility_off
                                    : Icons.visibility, color: Colors.white,),
                              ),
                              contentPadding: EdgeInsets.all(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        new Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: 210,
                              ),
                              FlatButton(
                                onPressed: null,
                                child: Text(
                                  "Mot de passe oublié ?",
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                            ]),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 44.0,
                          width: 200,
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Text(
                                "Se connecter",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "Queen",
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900),
                              ),
                              color: Colors.white,
                              onPressed: () {
                                check();
                              }),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 50.0,
                          child: Text(
                            "______________________ Ou ______________________",
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 11,
                                color: Colors.black,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                              height: 13.0,
                              child: Text(
                                "Vous n’avez pas de compte  ?",
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 11,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            SizedBox(
                              height: 50.0,
                              child: FlatButton(
                                  child: Text(
                                    "Inscrivez-vous",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Queen",
                                        color: Color(0xFF34518c),
                                        fontWeight: FontWeight.w900),
                                  ),
                                  color: Colors.transparent,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Register()),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
        break;
      case LoginStatus.signIn:
        return MainMenu(
            signOut, id_user, name, email, mobile, password, status, points);
        break;
    }
  }
}

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String name, email, mobile, password;
  final _key = new GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  save() async {
    final response = await http
        .post("http://iacomapp.cest-la-base.fr/api_verification.php", body: {
      "flag": 2.toString(),
      "name": name,
      "email": email,
      "mobile": mobile,
      "password": password,
      "fcm_token": "test_fcm_token",
    });

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      setState(() {});
      sendOTP();
    } else if (value == 2) {
      print(message);
      registerToast(message);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    } else {
      print(message);
      registerToast(message);
    }
  }

  registerToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Color(0xFF4267B2),
        textColor: Colors.white);
  }

  void sendOTP() async {
    EmailAuth.sessionName = "IΛCOM";
    var res = await (EmailAuth.sendOtp(receiverMail: _emailController.text));
    if (res) {
      print('Mail envoyé. Vérifiez votre boite e-mail');
      sentToast('Mail envoyé. Vérifiez votre boite e-mail');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Verify(
                mail: _emailController,
                email: email,
                name: name,
                password: password,
                mobile: mobile)),
      );
    } else
      print('Adresse mail non valide!');
  }

  sentToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Color(0xFF4267B2),
        textColor: Colors.white);
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [Color(0xFF4267B2), Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
              child: Form(
                key: _key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        SizedBox(
                            height: 50,
                            width: 50,
                            child: RaisedButton(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  size: 15,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                }))
                      ],
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Card(
                      color: Color(0xFF4267B2),
                      margin: const EdgeInsets.only(
                          right: 60, left: 60, bottom: 10, top: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: TextFormField(
                        validator: (e) {
                          if (e.isEmpty) {
                            return "Veuillez entrer votre nom et prénom";
                          }
                        },
                        onSaved: (e) => name = e,
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        validator: (e) {
                          if (e.isEmpty) {
                            return "Veuillez entrer votre mail";
                          } else if (!EmailValidator.validate(e)) {
                            return "Mail invalide";
                          }
                        },
                        onSaved: (e) => email = e,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 20, right: 15),
                              child: Icon(Icons.email, color: Colors.white),
                            ),
                            contentPadding: EdgeInsets.all(10),
                            labelStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: "Queen",
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                            labelText: "Email"),
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
                        validator: (e) {
                          if (e.isEmpty) {
                            return "Veuillez entrer votre numéro de téléphone";
                          } else if (e.length < 10) {
                            return "Numéro de téléphone invalide";
                          }
                        },
                        onSaved: (e) => mobile = e,
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
                          labelText: "Numéro de téléphone",
                          labelStyle: TextStyle(
                              fontSize: 14,
                              fontFamily: "Queen",
                              color: Colors.white,
                              fontWeight: FontWeight.w900),
                        ),
                        keyboardType: TextInputType.number,
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
                        validator: (e) {
                          if (e.isEmpty) {
                            return "Veuillez entrer votre mot de passe";
                          } else if (e.length < 8) {
                            return "Minimum 8 caractères";
                          }
                        },
                        obscureText: _secureText,
                        onSaved: (e) => password = e,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              onPressed: showHide,
                              icon: Icon(_secureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,color: Colors.white,),
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 20, right: 15),
                              child: Icon(Icons.phonelink_lock,
                                  color: Colors.white),
                            ),
                            contentPadding: EdgeInsets.all(10),
                            labelStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: "Queen",
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                            labelText: "Mot de passe"),
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
                            "S'inscrire",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Queen",
                                color: Colors.black,
                                fontWeight: FontWeight.w900),
                          ),
                          textColor: Colors.white,
                          color: Colors.white,
                          onPressed: () {
                            check();
                          }),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 50.0,
                      child: Text(
                        "______________________ Ou ______________________",
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 11,
                            color: Colors.black,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          height: 13.0,
                          child: Text(
                            "Vous avez déjà un compte  ?",
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 11,
                                color: Colors.black,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                        SizedBox(
                          height: 50.0,
                          child: FlatButton(
                              child: Text(
                                "Connectez-vous",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "Queen",
                                    color: Color(0xFF34518c),
                                    fontWeight: FontWeight.w900),
                              ),
                              color: Colors.transparent,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()),
                                );
                              }),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 44,
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

class MainMenu extends StatefulWidget {
  final VoidCallback signOut;
  String id_user, name, email, mobile, password, status, points;

  MainMenu(this.signOut, this.id_user, this.name, this.email, this.mobile,
      this.password, this.status, this.points);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  String id,
      id_user,
      name,
      email,
      mobile,
      password,
      status,
      points,
      titre,
      description,
      morelink,
      moreTextlink,
      actif;

  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.reload();
      id_user = preferences.getString("id_user");
      email = preferences.getString("email");
      name = preferences.getString("name");
      password = preferences.getString("password");
      mobile = preferences.getString("mobile");
      status = preferences.getString("status");
      points = preferences.getString("points");

      print("id_user " + id_user);
      print("email " + email);
      print("name " + name);
      print("password " + password);
      print("mobile " + mobile);
      print("status " + status);
      print("points" + points);
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  point() async {
    final response =
        await http.post("http://iacomapp.cest-la-base.fr/points.php", body: {
      "email": email,
    });

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    String pointsAPInew = data['points'];
    if (value == 1) {
      points = pointsAPInew;
    } else {
      print("fail");
    }
  }

  pointToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Color(0xFF4267B2),
        textColor: Colors.white);
  }

  savePref(String email, String name, String password, String mobile, String id_user, String status, String actif, String points) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("name", name);
      preferences.setString("mobile", mobile);
      preferences.setString("email", email);
      preferences.setString("password", password);
      preferences.setString("id_user", id_user);
      preferences.setString("status", status);
      preferences.setString("actif", actif);
      preferences.setString("points", points);
      preferences.commit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.only(left: 10, right: 0, bottom: 5),
                        child: Text(
                          "Bienvenue ${name}! ",
                          style: TextStyle(
                            fontSize: 13.7,
                            color: Colors.black,
                            fontFamily: "QueenBold",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        height: 44.0,
                        width: 250,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(Icons.person, color: Colors.white,),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Text(
                                    "Informations personnelles",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Queen",
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ]),
                            textColor: Colors.black,
                            color: Color(0xFF4267B2),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InfosPerso(signOut,
                                        name, email, mobile, password, points)),
                              );
                            }),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        height: 44.0,
                        width: 250,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(Icons.phonelink_lock,color: Colors.white,),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Text(
                                    "Changer mot de passe",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Queen",
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ]),
                            textColor: Colors.black,
                            color: Color(0xFF4267B2),
                            onPressed: () {
                              print(password);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ModifierPassword(
                                        id_user,
                                        email,
                                        name,
                                        mobile,
                                        password,
                                        signOut)),
                              );
                            }),
                      ),
                      if (status == 'client')
                        SizedBox(
                          height: 40,
                        ),
                      if (status == 'client')
                        Offstage(
                          child: SizedBox(
                            height: 44.0,
                            width: 250,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(Icons.star),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      Text(
                                        "Mes points",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: "Queen",
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ]),
                                textColor: Colors.white,
                                color: Color(0xFF4267B2),
                                onPressed: () async {
                                  await point();
                                  await savePref(email, name, password, mobile,
                                      id_user, status, actif, points);

                                  print(points);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Points(signOut, points)),
                                  );
                                }),
                          ),
                          offstage: false,
                        ),
                      if (status == 'admin')
                        SizedBox(
                          height: 40,
                        ),
                      if (status == 'admin')
                        Offstage(
                          child: SizedBox(
                            height: 44.0,
                            width: 250,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(Icons.filter_center_focus,color: Colors.white,),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      Text(
                                        "Scanner Code QR",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: "Queen",
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ]),
                                textColor: Colors.black,
                                color: Color(0xFF4267B2),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0))),
                                          scrollable: true,
                                          title: Text('Voulez-vous ?'),
                                          actions: [
                                            Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  SizedBox(
                                                    height: 44.0,
                                                    width: 250,
                                                    child: RaisedButton(
                                                        color: Colors.white,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.0)),
                                                        child: Text(
                                                          "Ajouter des points",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  "Queen",
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          ScanQRAjouter()));
                                                        }),
                                                  ),
                                                  SizedBox(
                                                    height: 20.0,
                                                  ),
                                                  SizedBox(
                                                    height: 44.0,
                                                    width: 250,
                                                    child: RaisedButton(
                                                        color: Colors.white,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.0)),
                                                        child: Text(
                                                          "Supprimer des points",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  "Queen",
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          ScanQRSupprimer()));
                                                        }),
                                                  ),
                                                ]),
                                          ],
                                        );
                                      });
                                }),
                          ),
                          offstage: false,
                        ),
                      if (status == 'admin')
                        SizedBox(
                          height: 40,
                        ),
                      if (status == 'admin')
                        Offstage(
                          child: SizedBox(
                            height: 44.0,
                            width: 250,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(Icons.blur_on,color: Colors.white,),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      Text(
                                        "Ajouter des Actualités",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: "Queen",
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ]),
                                textColor: Colors.black,
                                color: Color(0xFF4267B2),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AjouterActualites(
                                                  signOut,
                                                  id,
                                                  titre,
                                                  description,
                                                  morelink,
                                                  moreTextlink,
                                                  actif)));
                                }),
                          ),
                          offstage: false,
                        ),
                      if (status == 'admin')
                        SizedBox(
                          height: 40,
                        ),
                      if (status == 'admin')
                        Offstage(
                          child: SizedBox(
                            height: 44.0,
                            width: 250,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(Icons.bookmark,color: Colors.white,),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      Text(
                                        "Réservations",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: "Queen",
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ]),
                                textColor: Colors.black,
                                color: Color(0xFF4267B2),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ReservationsList()));
                                }),
                          ),
                          offstage: false,
                        ),
                      SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        height: 44.0,
                        width: 250,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(Icons.lock_open,color: Colors.white,),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Text(
                                    "Se déconnecter",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Queen",
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ]),
                            textColor: Colors.black,
                            color: Color(0xFF4267B2),
                            onPressed: () async{
                              await signOut();
                            }
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Verify extends StatefulWidget {
  TextEditingController mail = TextEditingController();
  String name, email, mobile, password;

  Verify(
      {Key key,
      @required this.mail,
      @required this.email,
      @required this.name,
      @required this.mobile,
      @required this.password});

  @override
  _VerifyState createState() => _VerifyState(
      mail: mail, email: email, name: name, password: password, mobile: mobile);
}

class _VerifyState extends State<Verify> {
  final _key = new GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();
  TextEditingController mail = TextEditingController();
  String name, status, actif, email, mobile, password;

  _VerifyState(
      {Key key,
      @required this.mail,
      @required this.email,
      @required this.name,
      @required this.mobile,
      @required this.password});

  update() async {
    final response = await http
        .post("http://iacomapp.cest-la-base.fr/update_status.php", body: {
      "actif": "1",
      "email": email,
    });

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      setState(() {});
    } else if (value == 2) {
      print(message);
      validateToast(message);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    } else {
      print(message);
      validateToast(message);
    }
  }

  void validateOTP() {
    var res = EmailAuth.validate(
        receiverMail: mail.text, userOTP: _otpController.text);
    if (res) {
      update();
      Navigator.pop(context);
      validateToast('Code vérifier');
    } else {
      print('Code invalide! Réessayez à nouveau.');
      validateToast('Code invalide! Réessayez à nouveau.');
    }
  }

  validateToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Color(0xFF4267B2),
        textColor: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [Color(0xFF4267B2), Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
              child: Form(
                key: _key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        SizedBox(
                            height: 50,
                            width: 50,
                            child: RaisedButton(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  size: 15,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                }))
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                    ),
                    Card(
                      color: Color(0xFF4267B2),
                      margin: const EdgeInsets.only(
                          right: 60, left: 60, bottom: 10, top: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (e) {
                          if (e.isEmpty) {
                            return "Veuillez entrer le code";
                          }
                        },
                        controller: _otpController,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 20, right: 15),
                              child: Icon(Icons.phonelink_lock,
                                  color: Colors.white),
                            ),
                            contentPadding: EdgeInsets.all(10),
                            labelStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: "Queen",
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                            labelText: "Code"),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      height: 44.0,
                      width: 200,
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Text(
                            "Verifier code",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Queen",
                                color: Colors.black,
                                fontWeight: FontWeight.w900),
                          ),
                          textColor: Colors.white,
                          color: Colors.white,
                          onPressed: () {
                            validateOTP();
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