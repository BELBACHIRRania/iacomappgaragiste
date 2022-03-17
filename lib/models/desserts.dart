import 'dart:convert';

List<Desserts> dessertsFromJson(String str) =>
    List<Desserts>.from(json.decode(str).map((x) => Desserts.fromMap(x)));

String dessertsToJson(List<Desserts> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Desserts {
  String id_act;
  String nom_art;
  String sous_titre;
  String description;
  String prix_art;
  String duree;
  String image_art;

  Desserts({
    this.id_act,
    this.nom_art,
    this.sous_titre,
    this.description,
    this.prix_art,
    this.duree,
    this.image_art,
  });

  factory Desserts.fromMap(Map<String, dynamic> json) => Desserts(
        id_act: json["id_act"],
        nom_art: json["nom_art"],
        sous_titre: json["sous_titre"],
        prix_art: json["prix_art"],
        duree: json["duree"],
        description: json["description"],
        image_art: json["image_art"],
      );

  Map<String, dynamic> toJson() => {
        "id_act": id_act,
        "nom_art": nom_art,
        "sous_titre": sous_titre,
        "prix_art": prix_art,
        "duree": duree,
        "description": description,
        "image_art": image_art,
      };
}
