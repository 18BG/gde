import 'package:gde/models/Options.dart';

class Filiere {
  String nom;
  String description;
  String? images;
  List<Option>? list_option;
  Filiere(
      {this.images,
      required this.description,
      required this.nom,
      this.list_option});

  // factory Filiere.FromJson(dynamic json){
  //   re
  // }
}
