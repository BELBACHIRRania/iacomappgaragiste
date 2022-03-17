import 'dart:convert';

List<Actualite> actualiteFromJson(String str) =>
    List<Actualite>.from(json.decode(str).map((x) => Actualite.fromMap(x)));

String actualiteToJson(List<Actualite> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Actualite {
  String id_act;
  String titre_act;
  String description_act;
  String image_act;
  String moreLink;
  String moreTextLink;

  Actualite({
    this.id_act,
    this.titre_act,
    this.description_act,
    this.image_act,
    this.moreLink,
    this.moreTextLink,
  });

  factory Actualite.fromMap(Map<String, dynamic> json) => Actualite(
        id_act: json["id_act"],
        titre_act: json["titre_act"],
        description_act: json["description_act"],
        image_act: json["image_act"],
        moreLink: json["moreLink"],
        moreTextLink: json["moreTextLink"],
      );

  Map<String, dynamic> toJson() => {
        "id_act": id_act,
        "titre_act": titre_act,
        "description_act": description_act,
        "image_act": image_act,
        "moreLink": moreLink,
        "moreTextLink": moreTextLink,
      };
}
