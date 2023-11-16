import 'package:flutter/material.dart';
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
        return SingleChildScrollView(
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
                const BoxComponents3(
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
                const BoxComponents3(
                    isLink: false,
                    color: Colors.teal,
                    name0: 'Centre Aoua Keita',
                    image0: "assets/images/photo_cak1.gif",
                    name1: 'CEFTI',
                    image1: "assets/images/cefti.png",
                    title: "Centre de formation"),
                const SizedBox(
                  height: 8,
                ),
                const BoxComponents3(
                    isLink: false,
                    color: Colors.teal,
                    name0: 'IPSMART',
                    image0: "assets/images/ipsmart.png",
                    name1: 'INTEC-SUP',
                    image1: "assets/images/intecsup.png",
                    title: 'Institut'),
                const SizedBox(
                  height: 8,
                ),
                BoxComponents3(
                    isLink: true,
                    color: Colors.teal,
                    name0: filiere[0].nom,
                    image0: filiere[0].image!,
                    name1: filiere[1].nom,
                    image1: filiere[1].image!,
                    title: 'Filieres'),
                const SizedBox(
                  height: 8,
                ),
                BoxComponents3(
                    isLink: true,
                    color: Colors.teal,
                    name0: filiere[0].nom,
                    image0: filiere[0].image!,
                    name1: filiere[1].nom,
                    image1: filiere[1].image!,
                    title: 'Filieres'),
              ],
            ),
          ),
        );
      },
    );
  }
}

// class BoxComponents extends StatefulWidget {
//   final String name0;
//   final String image0;
//   final String name1;
//   final String image1;
//   final String title;
//   final bool isLink;
//   void Function()? onPressed;
//   Color color;
//   BoxComponents(
//       {super.key,
//       this.onPressed,
//       required this.isLink,
//       required this.color,
//       required this.name0,
//       required this.image0,
//       required this.name1,
//       required this.image1,
//       required this.title});

//   @override
//   State<BoxComponents> createState() => _BoxComponentsState();
// }

// class _BoxComponentsState extends State<BoxComponents> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(5),
//       decoration: BoxDecoration(
//           color: widget.color,
//           borderRadius: const BorderRadius.only(
//               topRight: Radius.elliptical(30, 20),
//               bottomLeft: Radius.elliptical(20, 30))),
//       child: Column(
//         children: [
//           CText(
//             widget.title,
//             size: 19,
//             weight: FontWeight.w500,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               UBoxe(
//                 isLink: widget.isLink,
//                 name: widget.name0,
//                 image: widget.image0,
//               ),
//               UBoxe(
//                 isLink: widget.isLink,
//                 name: widget.name1,
//                 image: widget.image1,
//               ),
//               IconButton(
//                   onPressed: () {},
//                   icon: const Icon(
//                     Icons.arrow_drop_down,
//                     size: 40,
//                   ))
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

class UBoxe extends StatelessWidget {
  final String name;
  final String image;
  final bool isLink;
  const UBoxe(
      {super.key,
      required this.name,
      required this.isLink,
      required this.image});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double wi = width - 50;
    double hi = height / 3.5;

    return Column(
      children: [
        Container(
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
          height: 5,
        ),
        CText(
          name,
          size: 18,
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

  const BoxComponents3({
    Key? key,
    required this.isLink,
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
                  icon: const Icon(
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
                    isLink: widget.isLink,
                    name: widget.name0,
                    image: widget.image0,
                  ),
                  UBoxe(
                    isLink: widget.isLink,
                    name: widget.name1,
                    image: widget.image1,
                  ),
                ],
              ),
            ),
            secondChild: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  UBoxe(
                    isLink: widget.isLink,
                    name: widget.name0,
                    image: widget.image0,
                  ),
                  UBoxe(
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
}
