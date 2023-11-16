import 'package:flutter/material.dart';
import 'package:gde/models/filiere.dart';
import 'package:gde/services/supabase_management.dart';

class DataProvider extends ChangeNotifier {
  List<Filiere> field = [];
  static bool isFinish = false;
  SupabaseManager sup = SupabaseManager();
  Future<void> getFiliere() async {
    var data = await sup.getFiliere();
    for (var i in data) {
      Filiere filiere = Filiere.fromJson(i);
      print(filiere);
      field.add(filiere);
      notifyListeners();
    }
  }
}
