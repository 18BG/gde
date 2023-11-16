import 'package:flutter/material.dart';
import 'package:gde/models/filiere.dart';
import 'package:gde/screens/detail_page.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      provider = Provider.of<DataProvider>(context, listen: false);
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
        print(filiere[0].image);
        return Scaffold(
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
                  BoxComponents3(
                      c: context,
                      filiere: [],
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
                      c: context,
                      isLink: false,
                      color: Colors.blueGrey,
                      name0: 'Centre Aoua Keita',
                      image0: "assets/images/photo_cak1.gif",
                      name1: 'CEFTI',
                      image1: "assets/images/cefti.png",
                      title: "Centre de formation"),
                  SizedBox(
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
  const UBoxe(
      {super.key,
      required this.name,
      required this.isLink,
      required this.image,
      required this.isIn});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double wi = width - 50;
    double hi = height / 3.5;

    return Column(
      children: [
        SizedBox(
          height: hi / 3,
          width: wi / 2.5,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
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
        const SizedBox(
          height: 4,
        ),
        CText(
          name,
          size: 19,
          color: Colors.white,
        )
      ],
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
  final BuildContext c;
  final List<Filiere>? filiere;

  const BoxComponents3({
    Key? key,
    required this.isLink,
    required this.c,
    this.filiere,
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
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: widget.color,
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
            duration: const Duration(milliseconds: 300),
            firstChild: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  UBoxe(
                    isIn: false,
                    isLink: widget.isLink,
                    name: widget.name0,
                    image: widget.image0,
                  ),
                  UBoxe(
                    isIn: false,
                    isLink: widget.isLink,
                    name: widget.name1,
                    image: widget.image1,
                  ),
                ],
              ),
            ),
            secondChild: (widget.filiere != null)
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(
                        parent: NeverScrollableScrollPhysics()),
                    itemCount: widget.filiere!.length,
                    itemBuilder: (context, i) {
                      var fi = widget.filiere![i];

                      return Container(
                        padding: const EdgeInsets.all(2.0),
                        margin: const EdgeInsets.only(bottom: 5),
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => DetailPage(filiere: fi));
                          },
                          child: UBoxe(
                            isIn: true,
                            isLink: true,
                            name: fi.nom,
                            image: fi.image!,
                          ),
                        ),
                      );
                    })
                : Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        UBoxe(
                          isIn: true,
                          isLink: widget.isLink,
                          name: widget.name0,
                          image: widget.image0,
                        ),
                        UBoxe(
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
