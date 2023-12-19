import 'package:flutter/material.dart';
import 'package:gde/models/Structure.dart';
import 'package:gde/services/data_provider.dart';
import 'package:gde/widgets/mytext.dart';
import 'package:gde/widgets/publicationt_widget.dart';
import 'package:provider/provider.dart';

class StrucutureHome extends StatefulWidget {
  final Structure str;
  const StrucutureHome({super.key, required this.str});

  @override
  State<StrucutureHome> createState() => _StrucutureHomeState();
}

class _StrucutureHomeState extends State<StrucutureHome> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    double appBarHeight = MediaQuery.of(context).size.height / 5;
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            //automaticallyImplyLeading: false,

            title: const CText(
              "INTEC SUP",
              size: 20,
            ),
          ),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                  automaticallyImplyLeading: false,
                  // backgroundColor: Colors.grey,
                  pinned: true,
                  floating: false,
                  expandedHeight: 200,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: const EdgeInsets.only(bottom: 10),
                    background: Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Image.network(
                        "https://intec-sup.com/wp-content/uploads/2022/11/cropped-logo_INTEC_nom_Horizon-1-3-1-1.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  //toolbarHeight: 150,
                  // title: Row(
                  //   children: [
                  //     Container(
                  //       width: 120,
                  //       height: 120,
                  //       padding: EdgeInsets.all(5),
                  //       decoration: BoxDecoration(
                  //           border:
                  //               Border.all(color: Colors.blueGrey, width: 2),
                  //           borderRadius: BorderRadius.circular(100)),
                  //       child: ClipRRect(
                  //         borderRadius: BorderRadius.circular(50),
                  //         child: Image.network(
                  //           "https://edukiya.com/wp-content/uploads/2020/05/Universit%C3%A9-des-Sciences-des-Techniques-et-des-Technologies-de-Bamako-USTTB-1024x768.png",
                  //           fit: BoxFit.cover,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  bottom: const PreferredSize(
                      preferredSize: Size.fromHeight(35),
                      child: TabBar(tabs: [
                        Tab(
                          child: CText("Accueil"),
                        ),
                        Tab(
                          child: CText(
                            "Posts",
                            size: 19,
                            weight: FontWeight.w600,
                          ),
                        ),
                        Tab(
                          child: CText(
                            "Formation",
                            size: 19,
                            weight: FontWeight.w600,
                          ),
                        )
                      ]))),
              SliverFillRemaining(
                child: TabBarView(children: [
                  StructureAccueil(),
                  // Posts(),
                  ListeFormation(
                    str: widget.str,
                  )
                ]),
              )
            ],
          )),
    );
  }
}

class ListeFormation extends StatefulWidget {
  final Structure str;
  const ListeFormation({super.key, required this.str});

  @override
  State<ListeFormation> createState() => _ListeFormationState();
}

class _ListeFormationState extends State<ListeFormation> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, value, child) {
        var thFiliere = [];
        for (var y in value.fil_struc_list) {
          for (var fil in value.field) {
            if (fil.id == y.filiere_id &&
                widget.str.structure_id == y.structure_id) {
              thFiliere.add(fil);
            }
          }
        }
        return ListView.builder(
            itemCount: thFiliere.length,
            itemBuilder: (context, i) {
              var filiere = thFiliere[i];
              return Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Image.network(filiere.image!),
                  title: CText(filiere.nom),
                ),
              );
            });
      },
    );
  }
}

// class Posts extends StatefulWidget {
//   const Posts({super.key});

//   @override
//   State<Posts> createState() => _PostsState();
// }

// class _PostsState extends State<Posts> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         itemCount: 5,
//         itemBuilder: (context, index) {
//           return PublicationWidget(
//             imagesrc:
//                 "https://th.bing.com/th/id/R.70f89a0414e0223e13d16283355e632d?rik=Ula9fTUxg7LiRw&pid=ImgRaw&r=0",
//             description:
//                 "La Faculté des Sciences et Techniques (FST) est une structure d’enseignement public du Mali créée en 1996 avec l’Université du Mali. Elle est aujourd’hui une structure de l’Université des Sciences, des Techniques et des Technologies de Bamako 1",
//             username: "Abkass",
//             structureName: "FST",
//             listimage: [
//               "https://th.bing.com/th/id/R.702f0916de3e4df05e872ae44972db98?rik=Az3SwCyVLIw7jQ&pid=ImgRaw&r=0"
//             ],
//           );
//         });
//   }
// }

class StructureAccueil extends StatefulWidget {
  const StructureAccueil({super.key});

  @override
  State<StructureAccueil> createState() => _StructureAccueilState();
}

class _StructureAccueilState extends State<StructureAccueil> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          // SizedBox(
          //   height: 300,
          //   child: Image.network(
          //     "https://th.bing.com/th/id/R.0c2ed4d5abd4a68f350073efd71885f7?rik=L4wEqNwj5yJyNQ&pid=ImgRaw&r=0",
          //     fit: BoxFit.cover,
          //   ),
          // ),
          // const SizedBox(
          //   height: 5,
          // ),
          Container(
            padding: const EdgeInsets.all(10),
            child: const Center(
              child: CText(
                "Université des Sciences, des Techniques et des Technologies de Bamako alias USTTB",
                size: 20,
                weight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
                // gradient: LinearGradient(
                //     begin: Alignment.topLeft,
                //     end: Alignment.topRight,
                //     colors: [
                //   Colors.blueGrey,
                //   Colors.white,
                //   Colors.white70,
                // ])
                ),
            child: const CText(
              "'L''université des Sciences, des Techniques et des Technologies de Bamako est issus de la précédente université de Bamako Scindé en Quatre(4) université thématiques en fin 2011. L''USTTB est un établissement public à caractère scientifique, Technologiques et culturelle créée par l''ordonnance N° 2011-020/PRM du 28 septembre 2011",
              size: 19,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            decoration: const BoxDecoration(color: Colors.blueGrey),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                          top: Radius.elliptical(10, 10))),
                  child: const Center(
                    child: CText(
                      "Les facultés et institus",
                      size: 20,
                      weight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 0.5)),
                  child: Column(
                    children: [
                      Card(
                        shadowColor: Colors.black,
                        elevation: 10,
                        child: Image.network(
                          "https://th.bing.com/th/id/R.0c2ed4d5abd4a68f350073efd71885f7?rik=L4wEqNwj5yJyNQ&pid=ImgRaw&r=0",
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const CText(
                        "La Faculté des Sciences et Techniques(FST) est une structure d’enseignement public du Mali crée en 1996 avec l’Université du Mali. Aujourd'hui, elle est une structure de l'Université des Sciences, des Techniques et des Technologies de Bamako.Depuis sa création, elle a formé de nombreux étudiants dans le domaine des sciences et techniques, du niveau DEUG au niveau Doctorat.",
                        size: 18,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 40,
                        color: Colors.green,
                        child: const Center(
                            child: CText(
                          "F S T",
                          size: 20,
                          color: Colors.white,
                        )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(color: Colors.blueGrey[200]),
            child: Column(
              children: [
                const CText(
                  "Contact",
                  size: 19,
                  weight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 10,
                ),
                const CText("Telephone : +223 74982398"),
                const CText("Fax: (+223) 20 29 04 08 / (+223) 20 29 04 18"),
                const CText("Email: usttbinfo@gmail.com"),
                const SizedBox(
                  height: 10,
                ),
                const CText(
                    "Localisation : Hamdalaye ACI 2000 Rue: 405, Porte: 359; BP: E 423 Bamako-Mali"),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Image.asset(
                      "assets/images/Screenshot 2023-12-13 at 12.05.42 AM.png"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
