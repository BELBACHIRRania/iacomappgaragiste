import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:iacomappgaragiste/views/body.dart';
import 'package:image_picker/image_picker.dart';

class AjouterActualites extends StatefulWidget {
  final VoidCallback signOut;
  final String id, titre, description, morelink, moreTextlink, actif;

  AjouterActualites(this.signOut, this.id, this.titre, this.description,
      this.morelink, this.moreTextlink, this.actif);

  @override
  _AjouterActualitesState createState() => _AjouterActualitesState();
}

class _AjouterActualitesState extends State<AjouterActualites> {
  String id = "",titre, description, morelink, moreTextlink, actif, image, id_app, showInWebsite;
  String name = "", email = "", mobile = "", password = "", points = "", id_user = "";
  int selectedRadio,pubsite;

  final _key = new GlobalKey<FormState>();
  bool _secureText = true;

  String fileName;

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String token1;

  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      actif = selectedRadio.toString();
      showInWebsite = pubsite.toString();
      if (null == tmpFile) {
        setStatus(error);
        return;
      }
      String fileName = tmpFile.path.split('/').last;
      submit(fileName);
    }
  }

  submit(String fileName) async {
    final response = await http.post(
        "http://iacomapp.cest-la-base.fr/ajouter_actualite.php",
        body: {
          "id": id,
          "titre": titre,
          "description": description,
          "morelink": morelink,
          "moreTextlink": moreTextlink,
          "actif": actif,
          "id_app": "17",
          "showInWebsite": showInWebsite,
          "image_act": base64Image,
          "name": fileName,
        });

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      print(message);
      actToast(message);
      if (selectedRadio == 1) {
        getQue();
        subscribeToTopic('iacomgarage');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Body()));
      }
    } else {
      print(message);
      actToast(message);
    }
  }

  actToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Color(0xFF4267B2),
        textColor: Colors.white);
  }

  void firebaseCloudMessaging_Listeners() {
    _firebaseMessaging.getToken().then((token) {
      setState(() {
        token1 = token;
      });
    });
  }

  Future getQue() async {
    if (token1 != null) {
      print("hey");
      var response = await http
          .post("http://iacomapp.cest-la-base.fr/notif_iacomgarage.php", body: {
        "token": token1,
        "title": titre,
        "body": description,
      });
      return json.decode(response.body);
    } else {
      print("Token is null");
    }
  }

  subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    selectedRadio = 1;
    pubsite = 1;
    subscribeToTopic('iacomgarage');
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('${message['notification']['title']}'),
                content: Text('${message['notification']['body']}'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      },
    );

    firebaseCloudMessaging_Listeners();
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  setpubsite(int val) {
    setState(() {
      pubsite = val;
    });
  }

  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String error = 'Error';

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
    setStatus('');
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
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
                      height: 20,
                    ),
                    Card(
                      color: Color(0xFF4267B2),
                      margin:
                          const EdgeInsets.only(right: 60, left: 60, top: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: TextFormField(
                        onSaved: (e) => titre = e,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 20, right: 15),
                              child: Icon(Icons.blur_on, color: Colors.white),
                            ),
                            contentPadding: EdgeInsets.all(10),
                            labelStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: "Queen",
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                            labelText: "Titre"),
                      ),
                    ),
                    Card(
                      color: Color(0xFF4267B2),
                      margin: const EdgeInsets.only(
                          right: 60, left: 60, top: 10, bottom: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: TextFormField(
                        maxLength: 2000,
                        maxLines: null,
                        onSaved: (e) => description = e,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,),
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
                            labelText: "Description"),
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      child: FutureBuilder<File>(
                        future: file,
                        builder: (BuildContext context,
                            AsyncSnapshot<File> snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              null != snapshot.data) {
                            tmpFile = snapshot.data;
                            base64Image =
                                base64Encode(snapshot.data.readAsBytesSync());
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              margin: EdgeInsets.only(left: 15, right: 15),
                              child: Material(
                                elevation: 3.0,
                                child: Image.file(
                                  snapshot.data,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          } else if (null != snapshot.error) {
                            return const Text(
                              'Error!',
                              textAlign: TextAlign.center,
                            );
                          } else {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              margin: const EdgeInsets.only(
                                  right: 60, left: 60, top: 10),
                              child: Material(
                                color: Colors.transparent,
                                elevation: 0.0,
                                child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Container(
                                      child: Image.asset(
                                          'assets/placeholder-image.png'),
                                    ),
                                    SizedBox(
                                      height: 55,
                                      width: 400,
                                      child: RaisedButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          child: Text(
                                            "Choisir une image",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: "Queen",
                                                color: Colors.white,
                                                fontWeight: FontWeight.w900),
                                          ),
                                          color: Color(0xFF4267B2),
                                          onPressed: () {
                                            chooseImage();
                                          }),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    Card(
                      color: Color(0xFF4267B2),
                      margin:
                          const EdgeInsets.only(right: 60, left: 60, top: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: TextFormField(
                        onSaved: (e) => morelink = e,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 20, right: 15),
                              child: Icon(Icons.blur_on, color: Colors.white),
                            ),
                            contentPadding: EdgeInsets.all(10),
                            labelStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: "Queen",
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                            labelText: "Lien"),
                      ),
                    ),
                    Card(
                      color: Color(0xFF4267B2),
                      margin:
                          const EdgeInsets.only(right: 60, left: 60, top: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: TextFormField(
                        onSaved: (e) => moreTextlink = e,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 20, right: 15),
                              child: Icon(Icons.blur_on, color: Colors.white),
                            ),
                            contentPadding: EdgeInsets.all(10),
                            labelStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: "Queen",
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                            labelText: "Source"),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Activer la notication",
                            style: TextStyle(
                              fontSize: 13.7,
                              color: Colors.black,
                              fontFamily: "QueenBold",
                              //fontWeight: FontWeight.w900
                            ),
                          ),
                        ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonBar(
                          alignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Oui",
                              style: TextStyle(
                                fontSize: 13.7,
                                color: Colors.black,
                                fontFamily: "QueenBold",
                                //fontWeight: FontWeight.w900
                              ),
                            ),
                            Radio(
                                value: 1,
                                groupValue: selectedRadio,
                                activeColor: Color(0xFF4267B2),
                                onChanged: (val) {
                                  print(val);
                                  setSelectedRadio(val);
                                }),
                            Text(
                              "Non",
                              style: TextStyle(
                                fontSize: 13.7,
                                color: Colors.black,
                                fontFamily: "QueenBold",
                                //fontWeight: FontWeight.w900
                              ),
                            ),
                            Radio(
                                value: 0,
                                groupValue: selectedRadio,
                                activeColor: Color(0xFF4267B2),
                                onChanged: (val) {
                                  print(val);
                                  setSelectedRadio(val);
                                }),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 44.0,
                      width: 200,
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Text(
                            "Ajouter",
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
