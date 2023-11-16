import 'package:flutter/material.dart';
import 'package:gde/services/data_provider.dart';
import 'package:gde/widgets/mytext.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, value, child) {
        var im = value.field[0].image!;

        String url2 =
            'https://www.pgsoftware.fr/images/blog/Image_1_gestion_des_ITAM.png';
        String url =
            'https://upload.wikimedia.org/wikipedia/commons/2/20/Salle_informatique_de_la_biblioth%C3%A8que_d%27Art_et_d%27Arch%C3%A9ologie_de_Gen%C3%A8ve.jpg';
        return Center(
          child: Container(
              child: value.field.isNotEmpty
                  ? MyImageWidget(image: url2)
                  : CText("Aucun")),
        );
      },
    );
  }
}

class MyImageWidget extends StatelessWidget {
  final String image;
  const MyImageWidget({super.key, required this.image});
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
