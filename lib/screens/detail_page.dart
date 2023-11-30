import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gde/models/filiere.dart';
import 'package:gde/screens/filiere_info_screen.dart';
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
    return SizedBox(
      //height: MediaQuery.of(context).size.height - 100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 25, bottom: 10),
                        child: RichText(
                          text: TextSpan(
                              text: "Pour plus d'information cette filiere ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                              children: [
                                TextSpan(
                                    text: "cliquer ici",
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pop(context);
                                        print("Tapedd");
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FiliereInfo(
                                                      filiere: widget.filiere,
                                                    )));
                                      })
                              ]),
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
