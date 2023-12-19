import 'package:flutter/material.dart';
import 'package:gde/models/Structure.dart';
import 'package:gde/models/filiere.dart';
import 'package:gde/screens/detail_page.dart';
import 'package:gde/screens/filiere_info_screen.dart';
import 'package:gde/screens/structure_home_screen.dart';
import 'package:gde/services/data_provider.dart';
import 'package:gde/widgets/custom_textfield.dart';
import 'package:gde/widgets/mytext.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryState();
}

class _CategoryState extends State<CategoryScreen> {
  bool isExpanded = false;
  late DataProvider provider;
  Structure str = Structure(
      structure_id: 1,
      nom: "nom",
      description: "description",
      logo: "logo",
      localisation: "localisation",
      typeStructure: "typeStructure");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider = Provider.of<DataProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (provider.field.isEmpty) {
        provider.getFiliere();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, value, child) {
        var filiere = value.field;

        return Scaffold(
          //backgroundColor: Colors.black87,
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(),
                    child: MyFields(
                      hint: "Recherche",
                      icon: Icons.search,
                      border: true,
                      prefix: true,
                    ),
                  ),
                  // FutureBuilder(
                  //   future: provider.getFiliere(),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.hasError) {
                  //       return const Center(child: CText("Erreur"));
                  //     } else if (snapshot.connectionState ==
                  //         ConnectionState.waiting) {
                  (value.field.isEmpty)
                      ? const Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            CircularProgressIndicator(),
                          ],
                        )
                      :
                      // } else {
                      Column(
                          children: [
                            BoxComponents3(
                                onTap1: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return StrucutureHome(str: str);
                                  }));
                                },
                                onTap2: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return StrucutureHome(str: str);
                                  }));
                                },
                                c: context,
                                // filiere: [],
                                isLink: false,
                                color: Colors.blueGrey,
                                name0: 'USTTB',
                                image0: "assets/images/Usttb.png",
                                name1: 'ULSHB',
                                image1: "assets/images/photo_cak1.gif",
                                title: "Universités"),
                            const SizedBox(
                              height: 8,
                            ),
                            BoxComponents3(
                                onTap1: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return StrucutureHome(str: str);
                                  }));
                                },
                                onTap2: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return StrucutureHome(str: str);
                                  }));
                                },
                                c: context,
                                isLink: false,
                                color: Colors.blueGrey,
                                name0: 'Centre Aoua Keita',
                                image0: "assets/images/photo_cak1.gif",
                                name1: 'CEFTI',
                                image1: "assets/images/cefti.png",
                                title: "Centre de formation"),
                            const SizedBox(
                              height: 8,
                            ),
                            BoxComponents3(
                                c: context,
                                isLink: false,
                                color: Colors.blueGrey,
                                name0: 'IPSMART',
                                image0: "assets/images/ipsmart.png",
                                name1: 'INTEC-SUP',
                                image1: "assets/images/intecsup.png",
                                title: 'Institut'),
                            const SizedBox(
                              height: 8,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            BoxComponents3(
                                onTap1: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return FiliereInfo(filiere: filiere[0]);
                                  }));
                                },
                                onTap2: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return FiliereInfo(filiere: filiere[1]);
                                  }));
                                },
                                c: context,
                                filiere: value.field,
                                isLink: true,
                                color: Colors.blueGrey,
                                name0: filiere[0].nom,
                                image0: filiere[0].image!,
                                name1: filiere[1].nom,
                                image1: filiere[1].image!,
                                title: 'Filieres'),
                          ],
                        )
                  // }
                  //  },
                  // )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class UBoxe extends StatelessWidget {
  final String name;
  final String image;
  final bool isLink;
  final bool isIn;
  final bool big;
  void Function()? onTap;
  UBoxe(
      {super.key,
      required this.name,
      required this.isLink,
      required this.image,
      required this.isIn,
      required this.big,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double wi = width - 50;
    double hi = height / 3.5;
    double bi_wi = width / 1.5;
    double big_hi = height / 4.7;
    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //           return to_page;
    //         }));
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(
            height: big ? big_hi : hi / 2.5,
            width: big ? bi_wi : wi / 2.5,
            child: Card(
              elevation: 5,
              shadowColor: Colors.black,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: !isLink
                      ? Image.asset(
                          image,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          image,
                          fit: BoxFit.cover,
                        )),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          CText(
            name,
            size: 19,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}

class BoxComponents3 extends StatefulWidget {
  final String name0;
  final String image0;
  final String name1;
  final String image1;
  final String title;
  final bool isLink;
  final Color color;
  void Function()? onTap1;
  void Function()? onTap2;

  final BuildContext c;
  final List<Filiere>? filiere;

  BoxComponents3({
    Key? key,
    required this.isLink,
    required this.c,
    this.filiere,
    this.onTap1,
    this.onTap2,
    required this.color,
    required this.name0,
    required this.image0,
    required this.name1,
    required this.image1,
    required this.title,
  }) : super(key: key);

  @override
  _BoxComponentsState3 createState() => _BoxComponentsState3();
}

class _BoxComponentsState3 extends State<BoxComponents3> {
  bool isLastPage = false;
  bool isExpanded = false;
  Structure str = Structure(
      structure_id: 3,
      nom: "nom",
      description: "description",
      logo: "logo",
      localisation: "localisation",
      typeStructure: "typeStructure");
  late PageController _pageController;
  late int currentPage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
    currentPage = _pageController.initialPage;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        //color: widget.color,
        color: Colors.blueGrey[300],
        borderRadius: const BorderRadius.only(
          topRight: Radius.elliptical(30, 20),
          bottomLeft: Radius.elliptical(20, 30),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: CText(
                  widget.title,
                  size: 19,
                  weight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  icon: isExpanded
                      ? const Icon(
                          Icons.arrow_drop_up,
                          size: 40,
                          color: Colors.green,
                        )
                      : const Icon(
                          Icons.arrow_drop_down,
                          size: 40,
                        ))
            ],
          ),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 600),
            firstChild: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  UBoxe(
                    onTap: widget.onTap1,
                    isIn: false,
                    big: false,
                    isLink: widget.isLink,
                    name: widget.name0,
                    image: widget.image0,
                  ),
                  UBoxe(
                    onTap: widget.onTap2,
                    big: false,
                    isIn: false,
                    isLink: widget.isLink,
                    name: widget.name1,
                    image: widget.image1,
                  ),
                ],
              ),
            ),
            secondChild: (widget.filiere != null)
                ? Stack(
                    children: [
                      Container(
                        height: 690,
                        child: PageView.builder(
                            onPageChanged: (value) {
                              setState(() {
                                currentPage = value;
                              });
                            },
                            controller: _pageController,
                            itemCount: (widget.filiere!.length / 3).ceil(),
                            itemBuilder: (context, i) {
                              //var fi = widget.filiere![i];
                              int startIndex = i * 3;
                              int endIndex = (i + 1) * 3;
                              endIndex = endIndex > widget.filiere!.length
                                  ? widget.filiere!.length
                                  : endIndex;

                              List<Filiere> currentPageUniversities =
                                  widget.filiere!.sublist(startIndex, endIndex);

                              return Column(children: [
                                for (var fil in currentPageUniversities)
                                  Container(
                                    padding: const EdgeInsets.all(2.0),
                                    margin: const EdgeInsets.only(bottom: 5),
                                    child: UBoxe(
                                      onTap: () {
                                        showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            builder: (context) =>
                                                DetailPage(filiere: fil));
                                      },
                                      big: true,
                                      isIn: true,
                                      isLink: true,
                                      name: fil.nom,
                                      image: fil.image!,
                                    ),
                                  ),
                              ]);
                            }),
                      ),
                      Positioned(
                        top: 0.0,
                        bottom: 0.0,
                        right: 0.0,
                        child: IconButton(
                          color: currentPage <
                                  (widget.filiere!.length / 2).ceil() - 1
                              ? Colors.white
                              : Colors.black.withOpacity(0.5),
                          icon: Icon(Icons.chevron_right, size: 50),
                          onPressed: () {
                            if (_pageController.page! <
                                (widget.filiere!.length / 2).ceil() - 1) {
                              _pageController.nextPage(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                            }
                          },
                        ),
                      ),
                      Positioned(
                        top: 0.0,
                        bottom: 0.0,
                        left: 0.0,
                        child: IconButton(
                          color: currentPage == 0
                              ? Colors.black.withOpacity(0.5)
                              : Colors.white,
                          icon: Icon(Icons.chevron_left, size: 50),
                          onPressed: () {
                            print(_pageController.page!);
                            if (_pageController.page! > 0) {
                              _pageController.previousPage(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                            }
                          },
                        ),
                      ),
                    ],
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        UBoxe(
                          big: true,
                          isIn: true,
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return StrucutureHome(str: str);
                            }));
                          },
                          isLink: widget.isLink,
                          name: widget.name0,
                          image: widget.image0,
                        ),
                        UBoxe(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return StrucutureHome(str: str);
                            }));
                          },
                          big: true,
                          isIn: true,
                          isLink: widget.isLink,
                          name: widget.name1,
                          image: widget.image1,
                        ),
                        // Ajoutez ici les éléments supplémentaires à afficher
                        // lorsque le panneau est déplié.
                        // Par exemple, vous pouvez ajouter d'autres UBoxe.
                      ],
                    ),
                  ),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
          ),
        ],
      ),
    );
  }
  // Container(
  //             width: MediaQuery.of(context).size.width,
  //             child: Column(
  //               children: [
  //                 UBoxe(
  //                   isLink: widget.isLink,
  //                   name: widget.name0,
  //                   image: widget.image0,
  //                 ),
  //                 UBoxe(
  //                   isLink: widget.isLink,
  //                   name: widget.name1,
  //                   image: widget.image1,
  //                 ),
  //                 // Ajoutez ici les éléments supplémentaires à afficher
  //                 // lorsque le panneau est déplié.
  //                 // Par exemple, vous pouvez ajouter d'autres UBoxe.
  //               ],
  //             ),
  //           ),
}
