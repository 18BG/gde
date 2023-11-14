import 'package:gde/models/filiere.dart';

class Option {
  String denomination;
  String description;
  List<Filiere>? filiers;
  Option({this.filiers, required this.denomination, required this.description});
}
