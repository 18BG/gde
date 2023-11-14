import 'package:gde/models/Structure.dart';

class AdminStructure {
  String username;
  String nom;
  String prenom;
  String password;
  String email;
  String genre;
  String telephone;
  String? Photo;
  Structure? structure;
  AdminStructure(
      {this.structure,
      required this.username,
      required this.nom,
      required this.prenom,
      required this.password,
      required this.email,
      required this.genre,
      required this.telephone,
      this.Photo});
}
