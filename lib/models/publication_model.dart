import 'package:gde/models/Structure.dart';
import 'package:gde/models/pub_image.dart';
import 'package:intl/intl.dart';

class Publication {
  Structure? structure;

  String description;
  String date;
  int strucutre_id;
  List<PubImage>? image;
  String id;

  Publication(this.image, this.structure,
      {required this.description,
      required this.id,
      required this.date,
      required this.strucutre_id});

  factory Publication.fromJson(dynamic json) {
    DateTime temps = DateTime.parse(json["date"]);
    String dat = DateFormat('dd/MM/yyyy à HH:mm:ss').format(temps);

    return Publication(
      [],
      null,
      strucutre_id: json['structure_id'],
      description: json["description"],
      date: dat,
      id: json['id'],
    );
  }
}
