class PubModel {
  String titre;
  String image;
  String description;
  String source;
  PubModel(
      {required this.titre,
      required this.description,
      required this.image,
      required this.source});

  factory PubModel.fromJson(dynamic json) {
    print(json);
    return PubModel(
        titre: json['Titre'],
        description: "description",
        image: "image",
        source: "source");
  }
}
