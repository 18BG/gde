class PubModel {
  String titre;
  String auteur;
  String image;
  String contenue;
  String source;
  PubModel(
      {required this.titre,
      required this.auteur,
      required this.contenue,
      required this.image,
      required this.source});

  factory PubModel.fromJson(dynamic json) {
    print(json);
    return PubModel(
        titre: json['Titre'],
        contenue: "description",
        image: "image",
        source: "source",
        auteur: '');
  }
}
