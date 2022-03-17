import 'dart:convert';

List<Menus> menusFromJson(String str) =>
    List<Menus>.from(json.decode(str).map((x) => Menus.fromMap(x)));

String menusToJson(List<Menus> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Menus {
  String id_act;
  String nom_art;
  String prix_art;
  String duree;
  String description;
  String image_art;

  Menus({
    this.id_act,
    this.nom_art,
    this.prix_art,
    this.duree,
    this.description,
    this.image_art,
  });

  factory Menus.fromMap(Map<String, dynamic> json) => Menus(
        id_act: json["id_act"],
        nom_art: json["nom_art"],
        prix_art: json["prix_art"],
        duree: json["duree"],
        description: json["description"],
        image_art: json["image_art"],
      );

  Map<String, dynamic> toJson() => {
        "id_act": id_act,
        "nom_art": nom_art,
        "prix_art": prix_art,
        "duree": duree,
        "description": description,
        "image_art": image_art,
      };
}
