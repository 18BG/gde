import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gde/models/pub_model.dart';
import 'package:gde/services/data_provider.dart';
import 'package:gde/widgets/mytext.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  List<PubModel> pub = [
    PubModel(
        auteur: '',
        titre: "PUB!",
        contenue:
            "L'Institut des Sciences Appliquées (ISA), structure de l'Université des Sciences, des Techniques et des Technologies de Bamako (USTTB), a été crée par ordonnance N° 2011/020/PRM du 28 septembre 2011, ratifiée par la loi N° 2011-082 du 29 décembre 2011.",
        image: "assets/images/images.jpeg",
        source:
            "http://www.usttb.edu.ml/index.php/structures/instituit-des-sciences-appliquees/presentation-de-l-isa"),
    PubModel(
        titre: "FAST",
        auteur: '',
        contenue:
            "La Faculté des Sciences et Techniques est une structure d'enseignement public du Mali crée en 1996 avec l’Université du Mali. Aujourd'hui, elle est une structure de l'Université des Sciences, des Techniques et des Technologies de Bamako",
        image: "assets/images/download.jpeg",
        source:
            "http://www.usttb.edu.ml/index.php/structures/faculte-des-sciences-et-techniques/presentation-de-fst")
  ];

  int _currentPage = 0;
  int _numPages = 0;
  final _duration =
      const Duration(seconds: 5); // Durée entre chaque défilement automatique
  late DataProvider provider;

  @override
  void initState() {
    _numPages = pub.length;
    _pageController = PageController();
    _startAutoScroll();
    //getData();

    super.initState();

    // provider = Provider.of<DataProvider>(context, listen: false);
    // provider.getFiliere();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  void _startAutoScroll() {
    Timer.periodic(_duration, (timer) {
      if (_currentPage < _numPages - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Consumer(
      builder: (context, value, child) {
        return SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Card(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    height: height / 4,
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.teal,
                    )),
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: pub.length,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Image.asset(
                          pub[index].image,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  height: height / 4.5,
                  width: width / 1.1,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  "assets/images/intelligence-artificielle-removebg-preview.png",
                                  height: height / 8,
                                ),
                                const Flexible(
                                  child: CText(
                                    "Consulter notre IA pour vous guider",
                                    weight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [const Spacer(), CText("Assistant IA")],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                //const Expanded(child: Text("Autres ...")),
                const SizedBox(
                  height: 15,
                ),
                CText(
                  "Connaissez vous :",
                  size: 20,
                  weight: FontWeight.w500,
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: height / 4.2,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.teal)),
                  child: PageView.builder(
                    //controller: _pageController,
                    itemCount: pub.length,
                    // onPageChanged: (int page) {
                    //   setState(() {
                    //     _currentPage = page;
                    //   });
                    // },
                    itemBuilder: (context, index) {
                      return Image.asset(
                        pub[index].image,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
  //StreamBuilder<List<Map<String, dynamic>>>(
          //   stream: _stream,
          //   builder: (context, snapshot) {
          //     if (!snapshot.hasData) {
          //       return const Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }
          //     final struc = snapshot.data;
          //     return Container(
          //       height: 50,
          //       child: ListView.builder(
          //         itemCount: struc!.length,
          //         itemBuilder: (context, index) {
          //           return ListTile(
          //             onTap: () {
          //               sup.getFiliere();
          //             },
          //             title: Text(struc[index]['nom']),
          //           );
          //         },
          //       ),
          //     );
          //   },
          // ),

