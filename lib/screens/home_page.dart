import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gde/models/pub_model.dart';
import 'package:gde/services/get.dart';
import 'package:gde/widgets/mytext.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:gde/widgets/mytext.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  List<PubModel> pub = [
    PubModel(
        titre: "PUB!",
        description:
            "L’Institut des Sciences Appliquées (ISA), structure de l’Université des Sciences, des Techniques et des Technologies de Bamako (USTTB), a été crée par ordonnance N° 2011/020/PRM du 28 septembre 2011, ratifiée par la loi N° 2011-082 du 29 décembre 2011.",
        image: "assets/images/images.jpeg",
        source:
            "http://www.usttb.edu.ml/index.php/structures/instituit-des-sciences-appliquees/presentation-de-l-isa"),
    PubModel(
        titre: "FAST",
        description:
            "La Faculté des Sciences et Techniques est une structure d’enseignement public du Mali crée en 1996 avec l’Université du Mali. Aujourd'hui, elle est une structure de l'Université des Sciences, des Techniques et des Technologies de Bamako",
        image: "assets/images/download.jpeg",
        source:
            "http://www.usttb.edu.ml/index.php/structures/faculte-des-sciences-et-techniques/presentation-de-fst")
  ];

  int _currentPage = 0;
  int _numPages = 0;
  final _duration =
      const Duration(seconds: 5); // Durée entre chaque défilement automatique
  final _stream = Supabase.instance.client
      .from('structure')
      .stream(primaryKey: ['structure_id']);

  @override
  void initState() {
    _pageController = PageController();
    //getData();
    super.initState();
    _startAutoScroll();
    _numPages = pub.length;
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
    return Container(
      child: Column(
        children: [
          Container(
            height: 200,
            color: Colors.teal,
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
          const SizedBox(
            height: 10,
          ),
          StreamBuilder<List<Map<String, dynamic>>>(
            stream: _stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final struc = snapshot.data;
              return Container(
                height: 50,
                child: ListView.builder(
                  itemCount: struc!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(struc[index]['nom']),
                    );
                  },
                ),
              );
            },
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            height: 150,
            width: double.infinity,
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
                            height: 90,
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
          const Expanded(child: Text("Autres ...")),
        ],
      ),
    );
  }
}
