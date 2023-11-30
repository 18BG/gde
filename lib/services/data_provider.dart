import 'package:flutter/material.dart';
import 'package:gde/models/Options.dart';
import 'package:gde/models/debouche_model.dart';
import 'package:gde/models/filiere.dart';
import 'package:gde/models/image_salaire.dart';
import 'package:gde/services/supabase_management.dart';

class DataProvider extends ChangeNotifier {
  List<Filiere> field = [];
  List<Option> option_liste = [];
  List<Debouche> listedebouche = [];
  List<ImageSalaire> list_im_sal = [];
  static bool isFinish = false;
  SupabaseManager sup = SupabaseManager();
  Future<void> getFiliere() async {
    print('+' * 50);
    print(field.length);
    print(field.isEmpty);
    if (field.isEmpty) {
      var data = await sup.getFiliere();
      for (var i in data) {
        Filiere filiere = Filiere.fromJson(i);

        field.add(filiere);
        notifyListeners();
      }
    }
  }

  Future<void> getOption() async {
    try {
      var data = await sup.getOption();
      for (var el in data) {
        var op = Option.fromJson(el);
        option_liste.add(op);
      }

      if (field.isNotEmpty) {
        for (int i = 0; i < field.length; i++) {
          for (int j = 0; j < option_liste.length; j++) {
            if (option_liste[j].filiere_id == option_liste[i].id) {
              field[i].list_option.add(option_liste[j]);
            }
          }
        }
      }
      notifyListeners();
    } catch (e) {
      print("--" * 10);
      print("Error option $e");
    }
  }

  Future<void> getDebouche() async {
    try {
      var data = await sup.getDebouche();
      var im_sal = await sup.getImSal();
      for (var ele in data) {
        var deb = Debouche.fromJson(ele);
        listedebouche.add(deb);
      }
      for (var im_sal in im_sal) {
        var new_im_sal = ImageSalaire.fromJson(im_sal);
        list_im_sal.add(new_im_sal);
      }
      for (var i in listedebouche) {
        for (var el in list_im_sal) {
          if (i.id == el.id_debouche) {
            i.image = el.image_link;
            i.salaire = el.salaire;
          }
        }
      }
      if (option_liste.isNotEmpty) {
        for (int i = 0; i < option_liste.length; i++) {
          for (int j = 0; j < listedebouche.length; j++) {
            if (listedebouche[j].id_option == option_liste[i].id) {
              option_liste[i].deboucheliste.add(listedebouche[j]);
            }
          }
        }
      }
      notifyListeners();
    } catch (e) {
      print("ErroR $e");
    }
  }
}
