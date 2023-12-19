import 'package:gde/models/Structure.dart';
import 'package:gde/utilities/constant.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseManager {
  var _db = Supabase.instance.client;

  Future<dynamic> getStructure() async {
    var data;
    try {
      data = await _db.from("structure").select("*");
      print("----");
    } catch (e) {
      print(e);
    }
    return data;
  }

  Future<dynamic> getPublication() async {
    var data;
    try {
      data = await _db.from("publication").select("*");
      print("----");
    } catch (e) {
      print(e);
    }
    return data;
  }

  Future<dynamic> getPubImage() async {
    var data;
    try {
      data = await _db.from("image").select("*");
      print("----");
    } catch (e) {
      print(e);
    }
    return data;
  }

  Future<dynamic> getFiliereStructure() async {
    var data;
    try {
      data = await _db.from("filiere_structure").select("*");
      print("----");
    } catch (e) {
      print(e);
    }
    return data;
  }

  Future<dynamic> getFiliere() async {
    print("-----------");
    final data = await _db.from(fl).select('*');

    return data;
  }

  Future<dynamic> getOption() async {
    print("Launched...");
    try {
      final data = await _db.from(opt).select('*');

      print("-------------------------------");
      return data;
    } catch (e) {
      print("Error.... $e");
    }
  }

  Future<dynamic> getDebouche() async {
    print("Launched...");
    try {
      final data = await _db.from(tabledebouche).select('*');

      print("-------------------------------");
      return data;
    } catch (e) {
      print("Error.... $e");
    }
  }

  Future<dynamic> getImSal() async {
    print("Getting image...");
    try {
      final im_sal = await _db.from('image_salaire').select('*');
      return im_sal;
    } catch (e) {
      print("Erreur ---- $e");
    }
  }
}

//  final _stream = Supabase.instance.client
//       .from('structure')
//       .stream(primaryKey: ['structure_id']);
