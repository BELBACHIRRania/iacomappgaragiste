import 'dart:convert';

List<Reservations> reservationsFromJson(String str) =>
    List<Reservations>.from(json.decode(str).map((x) => Reservations.fromMap(x)));

String reservationsToJson(List<Reservations> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Reservations {
  String nom;
  String mail;
  String tel;
  String vehicule_n;
  String vehicule_o;
  String dates_resa;
  String info_complementaire;
  String heure_resa;

  Reservations({
    this.nom,
    this.mail,
    this.tel,
    this.vehicule_n,
    this.vehicule_o,
    this.dates_resa,
    this.info_complementaire,
    this.heure_resa,
  });

  factory Reservations.fromMap(Map<String, dynamic> json) => Reservations(
    nom: json["nom"],
    mail: json["mail"],
    tel: json["tel"],
    vehicule_n: json["vehicule_n"],
    vehicule_o: json["vehicule_o"],
    dates_resa: json["dates_resa"],
    info_complementaire: json["info_complementaire"],
    heure_resa: json["heure_resa"],
      );

  Map<String, dynamic> toJson() => {
        "nom": nom,
        "mail": mail,
        "tel": tel,
        "vehicule_n": vehicule_n,
        "vehicule_o": vehicule_o,
        "dates_resa": dates_resa,
        "info_complementaire": info_complementaire,
        "heure_resa": heure_resa,
      };
}
