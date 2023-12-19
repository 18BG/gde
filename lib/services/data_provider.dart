import 'package:flutter/material.dart';
import 'package:gde/models/Options.dart';
import 'package:gde/models/Structure.dart';
import 'package:gde/models/debouche_model.dart';
import 'package:gde/models/filiere.dart';
import 'package:gde/models/filiere_strucutre.dart';
import 'package:gde/models/image_salaire.dart';
import 'package:gde/models/pub_image.dart';
import 'package:gde/models/publication_model.dart';
import 'package:gde/services/supabase_management.dart';

class DataProvider extends ChangeNotifier {
  List<Filiere> field = [];
  List<Structure> liste_structure = [];
  List<FiliereStrucuture> fil_struc_list = [];
  List<Option> option_liste = [];
  List<Debouche> listedebouche = [];
  List<ImageSalaire> list_im_sal = [];
  List<Publication> listepub = [];
  List<PubImage> listeimage = [];

  static bool isFinish = false;
  SupabaseManager sup = SupabaseManager();

////////////////////Get pub////////////////////
  Future<void> getPub() async {
    if (liste_structure.isEmpty) {
      var dyn = await sup.getStructure();
      for (var data in dyn) {
        var current = Structure.fromJson(data);
        liste_structure.add(current);
      }
    }
    print(liste_structure.length);

    if (listepub.isEmpty) {
      var images = await sup.getPubImage();
      for (var image in images) {
        var im = PubImage.fromjson(image);
        listeimage.add(im);
        print(listepub.length);
      }
      var pubs = await sup.getPublication();
      for (var pub in pubs) {
        var pu = Publication.fromJson(pub);
        for (var i in listeimage) {
          if (i.id_pub == pu.id) {
            pu.image!.add(i);
          }
        }
        for (var i in liste_structure) {
          if (i.structure_id == pu.strucutre_id) {
            pu.structure = i;
            break;
          }
        }
        listepub.add(pu);
      }
    }
    notifyListeners();
  }

  Future<int> getFiliere() async {
    if (liste_structure.isEmpty) {
      await getStrucutre();
    }
    // https: //ihrtyyxbykdgxmiahzws.supabase.co/storage/v1/object/sign/photo_video_pub/CCMD.jpeg?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJwaG90b192aWRlb19wdWIvQ0NNRC5qcGVnIiwiaWF0IjoxNzAyNzM5MjMxLCJleHAiOjE3NjU4MTEyMzF9.IR79OszDrLiZ-vXgd7JqtWqCtFYnCBbs319Y9ViQyH4&t=2023-12-16T15%3A07%3A11.693Z

    print(" ${field.length} Filieres");
    // for (var i in field) {
    //   print(i.nom);
    // }
    if (field.length == 0) {
      // print('+' * 50);
      // print("rec---");
      var data = await sup.getFiliere();
      var t = 0;
      for (var i in data) {
        print(t);
        t++;
        Filiere filiere = Filiere.fromJson(i);

        field.add(filiere);
        notifyListeners();
      }
      print("Fin If");
      return 0;
    } else {
      print("Debut else");
      print("Rien trouve");
      return 1;
    }
  }

  Future<void> getStrucutre() async {
    try {
      if (fil_struc_list.isEmpty) {
        var fil_str = await sup.getFiliereStructure();
        for (var data in fil_str) {
          var curr = FiliereStrucuture.fromJson(data);
          fil_struc_list.add(curr);
        }
      }
      if (liste_structure.isEmpty) {
        var dyn = await sup.getStructure();
        for (var data in dyn) {
          var current = Structure.fromJson(data);
          liste_structure.add(current);
        }
      }

      notifyListeners();
    } catch (e) {
      print(e);
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
      var imSal = await sup.getImSal();
      for (var ele in data) {
        var deb = Debouche.fromJson(ele);
        listedebouche.add(deb);
      }
      for (var im_sal in imSal) {
        var newImSal = ImageSalaire.fromJson(im_sal);
        list_im_sal.add(newImSal);
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
