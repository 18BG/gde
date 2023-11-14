import 'package:gde/models/Options.dart';
import 'package:gde/models/Poste.dart';
import 'package:gde/models/formation.dart';

class Structure {
  String nom;
  String description;
  String typeStructure;
  String logo;
  String localisation;
  List<Publication>? publications;
  List<Formation>? formations;
  List<Option>? options;
  Structure(
      {this.publications,
      this.formations,
      this.options,
      required this.nom,
      required this.description,
      required this.logo,
      required this.localisation,
      required this.typeStructure});
}
