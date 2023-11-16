class Option {
  int id;
  String denomination;
  String description;
  int filiere_id;
  String? image;

  Option(
      {this.image,
      required this.id,
      required this.filiere_id,
      required this.denomination,
      required this.description});
}
