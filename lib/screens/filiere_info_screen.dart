import 'package:flutter/material.dart';
import 'package:gde/models/filiere.dart';
import 'package:gde/screens/option_screen.dart';
import 'package:gde/services/data_provider.dart';
import 'package:gde/widgets/expandable_text.dart';
import 'package:gde/widgets/mytext.dart';
import 'package:provider/provider.dart';

class FiliereInfo extends StatefulWidget {
  final Filiere filiere;
  const FiliereInfo({super.key, required this.filiere});

  @override
  State<FiliereInfo> createState() => _FiliereInfoState();
}

class _FiliereInfoState extends State<FiliereInfo> {
  late DataProvider provider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider = Provider.of<DataProvider>(context, listen: false);
    if (provider.option_liste.isEmpty) {
      provider.getOption();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, value, child) {
        print(value.option_liste.length);
        var thisOptiont = [];
        for (var fiel in value.option_liste) {
          if (fiel.filiere_id == widget.filiere.id) {
            thisOptiont.add(fiel);
          }
        }
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
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
                  child: Column(children: [
                    Card(
                        elevation: 10,
                        child: Image.network(widget.filiere.image!)),
                    const SizedBox(
                      height: 10,
                    ),
                    // CText(
                    //   widget.filiere.description,
                    //   size: 18,
                    // ),
                    ExpandableTextWidget(
                        text: widget.filiere.description, maxLines: 2),
                    const SizedBox(
                      height: 10,
                    ),
                    const CText(
                      "Options",
                      size: 20,
                      weight: FontWeight.w600,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: value.option_liste.isEmpty
                          ? const Center(
                              child: CText(
                                "Aucune option",
                                size: 18,
                                color: Colors.white,
                              ),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(
                                  parent: NeverScrollableScrollPhysics()),
                              itemBuilder: (context, i) {
                                var op = thisOptiont[i];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return OptionScreen(option: op);
                                    }));
                                  },
                                  child: Card(
                                    child: Row(
                                      children: [
                                        Image.network(
                                          op.image!,
                                          width: 90,
                                          //height: 60,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Flexible(
                                          child: CText(
                                            op.denomination,
                                            weight: FontWeight.w600,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, inw) {
                                return const SizedBox(
                                  height: 2,
                                );
                              },
                              itemCount: thisOptiont.length),
                    ),
                    const SizedBox(
                      height: 15,
                    )
                  ]),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
