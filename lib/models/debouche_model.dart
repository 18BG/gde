class Debouche {
  int id;
  String titre;
  String contenue;
  int cle_filiere;
  int id_option;
  String image;
  String salaire;
  Debouche(
      {required this.id,
      required this.titre,
      required this.contenue,
      required this.cle_filiere,
      required this.id_option,
      required this.image,
      required this.salaire});

  factory Debouche.fromJson(dynamic json) {
    return Debouche(
        id: json['id_debouche'],
        titre: json['titre'],
        contenue: json['contenue'],
        cle_filiere: json['cle_filiere'],
        id_option: json['id_option'],
        salaire: '',
        image: '');
  }
}
