import 'dart:convert';

List<Article> articleFromJson(String str) =>
    List<Article>.from(json.decode(str).map((x) => Article.fromMap(x)));

String articleToJson(List<Article> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Article {
  String id_act;
  String nom_art;
  String prix_art;
  String duree;
  String description;
  String image_art;
  String sous_titre;

  Article({
    this.id_act,
    this.nom_art,
    this.prix_art,
    this.duree,
    this.description,
    this.image_art,
    this.sous_titre,
  });

  factory Article.fromMap(Map<String, dynamic> json) => Article(
        id_act: json["id_act"],
        nom_art: json["nom_art"],
        prix_art: json["prix_art"],
        duree: json["duree"],
        description: json["description"],
        image_art: json["image_art"],
        sous_titre: json["sous_titre"],
      );

  Map<String, dynamic> toJson() => {
        "id_act": id_act,
        "nom_art": nom_art,
        "prix_art": prix_art,
        "duree": duree,
        "description": description,
        "image_art": image_art,
        "sous_titre": sous_titre,
      };
}
