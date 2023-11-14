import 'package:flutter/material.dart';
import 'package:gde/widgets/custom_textfield.dart';
import 'package:gde/widgets/mytext.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryState();
}

class _CategoryState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
          Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.elliptical(30, 20),
                    bottomRight: Radius.elliptical(20, 30))),
            child: Column(
              children: [
                const CText(
                  "Unversités",
                  size: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const UBoxe(
                        name: 'USTTB', image: "assets/images/Usttb.png"),
                    const UBoxe(
                      name: 'ULSHB',
                      image: "assets/images/photo_cak1.gif",
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          size: 40,
                        ))
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.only(
                    topRight: Radius.elliptical(30, 20),
                    bottomLeft: Radius.elliptical(20, 30))),
            child: Column(
              children: [
                const CText(
                  "Centre de formation",
                  size: 19,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const UBoxe(
                      name: 'Centre Aoua Keita ',
                      image: "assets/images/photo_cak1.gif",
                    ),
                    const UBoxe(
                      name: 'CEFTI',
                      image: "assets/images/cefti.png",
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          size: 40,
                        ))
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.only(
                    topRight: Radius.elliptical(30, 20),
                    bottomLeft: Radius.elliptical(20, 30))),
            child: Column(
              children: [
                const CText(
                  "Institut",
                  size: 19,
                  weight: FontWeight.w500,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const UBoxe(
                      name: 'IPSMART',
                      image: "assets/images/ipsmart.png",
                    ),
                    const UBoxe(
                      name: 'INTEC-SUP',
                      image: "assets/images/intecsup.png",
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          size: 40,
                        ))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UBoxe extends StatelessWidget {
  final String name;
  final String image;
  const UBoxe({super.key, required this.name, required this.image});

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
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
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
