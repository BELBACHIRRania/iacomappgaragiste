import 'dart:convert';

List<Plats> platsFromJson(String str) =>
    List<Plats>.from(json.decode(str).map((x) => Plats.fromMap(x)));

String platsToJson(List<Plats> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Plats {
  String id_act;
  String nom_art;
  String sous_titre;
  String description;
  String prix_art;
  String duree;
  String image_art;

  Plats({
    this.id_act,
    this.nom_art,
    this.sous_titre,
    this.description,
    this.prix_art,
    this.duree,
    this.image_art,
  });

  factory Plats.fromMap(Map<String, dynamic> json) => Plats(
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
