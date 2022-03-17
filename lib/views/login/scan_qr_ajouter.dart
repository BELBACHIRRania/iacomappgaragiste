import 'dart:convert';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ScanQRAjouter extends StatefulWidget {
  ScanQRAjouter({Key key}) : super(key: key);

  @override
  _ScanQRAjouterState createState() => _ScanQRAjouterState();
}

String qrData = "' '";
var data;
bool hasdata = false;

class _ScanQRAjouterState extends State<ScanQRAjouter> {
  String points, id, id_user;
  String email;
  int counter = 0;

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
      counter = int.parse(points);
      counter = counter + 1;
      points = counter.toString();
      submit();
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

  submit() async {
    final response = await http
        .post("http://iacomapp.cest-la-base.fr/editpoints.php", body: {
      "email": email,
      "points": points,
    });

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      pointToast(message);
      setState(() {
        savePref(points);
      });
    } else {
      pointToast(message);
    }
  }

  savePref(String points) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("points", points);
      preferences.commit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "Scan QR",
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Color(0xFF4267B2), Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 90,
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
                height: 150,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      "Résultat de votre scan:  ${(qrData)}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13.7,
                        color: Colors.black,
                        fontFamily: "QueenBold",
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              SizedBox(
                height: 44.0,
                width: 200,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  child: Text(
                    "Scanner code QR",
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Queen",
                        color: Colors.black,
                        fontWeight: FontWeight.w900),
                  ),
                  textColor: Colors.black,
                  color: Colors.white,
                  onPressed: () async {
                    var options = ScanOptions(
                      autoEnableFlash: false,
                    );

                    var data = await BarcodeScanner.scan(options: options);
                    setState(() {
                      qrData = data.rawContent.toString();
                      hasdata = true;
                    });
                    email = qrData;
                    point();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
