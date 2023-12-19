import 'package:gde/models/Options.dart';
import 'package:gde/models/Poste.dart';
import 'package:gde/models/filiere.dart';
import 'package:gde/models/formation.dart';

class Structure {
  int structure_id;
  String nom;
  String description;
  String typeStructure;
  String logo;
  String localisation;
  List<Filiere>? filiere;
  List<Publication>? publications;
  List<Formation>? formations;
  List<Option>? options;
  Structure(
      {this.publications,
      this.formations,
      this.options,
      this.filiere,
      required this.structure_id,
      required this.nom,
      required this.description,
      required this.logo,
      required this.localisation,
      required this.typeStructure});

  factory Structure.fromJson(dynamic data) {
    return Structure(
        structure_id: data['structure_id'],
        nom: data['nom'],
        description: data['description'],
        logo: data['image'],
        localisation: data['localisation'],
        typeStructure: data['type']);
  }
}
