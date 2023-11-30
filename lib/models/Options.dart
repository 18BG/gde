import 'package:gde/models/debouche_model.dart';

class Option {
  int id;
  String denomination;
  String description;
  int filiere_id;
  String? image;
  List<Debouche> deboucheliste;

  Option(
      {this.image,
      required this.id,
      required this.filiere_id,
      required this.denomination,
      required this.description,
      required this.deboucheliste});

  factory Option.fromJson(dynamic json) {
    return Option(
        id: json['id_option'],
        filiere_id: json['filiere_id'],
        denomination: json['denomination'],
        description: json['description'],
        image: json['image'],
        deboucheliste: []);
  }
}
