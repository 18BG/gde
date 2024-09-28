import 'package:flutter/material.dart';
import 'package:gde/widgets/publicationt_widget.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "News",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Image.network(
                "https://th.bing.com/th/id/R.0c2ed4d5abd4a68f350073efd71885f7?rik=L4wEqNwj5yJyNQ&pid=ImgRaw&r=0",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return PublicationWidget(
                  imagesrc:
                      "https://th.bing.com/th/id/R.70f89a0414e0223e13d16283355e632d?rik=Ula9fTUxg7LiRw&pid=ImgRaw&r=0",
                  description:
                      "La Faculté des Sciences et Techniques (FST) est une structure d’enseignement public du Mali créée en 1996 avec l’Université du Mali. Elle est aujourd’hui une structure de l’Université des Sciences, des Techniques et des Technologies de Bamako 1",
                  username: "Abkass",
                  structureName: "FST",
                  listimage: [
                    "https://th.bing.com/th/id/R.702f0916de3e4df05e872ae44972db98?rik=Az3SwCyVLIw7jQ&pid=ImgRaw&r=0"
                  ],
                );
              },
              childCount:
                  10, // Change this to your desired number of news items
            ),
          ),
        ],
      ),
    );
  }
}
