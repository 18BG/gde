import 'package:flutter/material.dart';
import 'package:gde/models/filiere.dart';
import 'package:gde/widgets/mytext.dart';

class DetailPage extends StatefulWidget {
  final Filiere filiere;
  const DetailPage({super.key, required this.filiere});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 100,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              CText(
                widget.filiere.nom,
                weight: FontWeight.bold,
                size: 19,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Image.network(widget.filiere.image!),
                      const SizedBox(
                        height: 10,
                      ),
                      CText(
                        widget.filiere.description,
                        size: 18,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CText("Débouché"),
                      CText(widget.filiere.description)
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
