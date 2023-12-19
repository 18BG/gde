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
  bool onOption = true;
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
        var thStructure = [];
        var filier = widget.filiere;
        print("current ${widget.filiere.id}");
        for (var o in value.fil_struc_list) {
          print("${o.filiere_id}  ${o.structure_id}");
        }
        for (var i in value.fil_struc_list) {
          if (widget.filiere.id == i.filiere_id) {
            for (var str in value.liste_structure) {
              if (str.structure_id == i.structure_id) {
                thStructure.add(str);
              }
            }
          }

          print("Les str --- ${thStructure.length}");
        }
        for (var fiel in value.option_liste) {
          if (fiel.filiere_id == widget.filiere.id) {
            thisOptiont.add(fiel);
          }
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 10,
          ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (!onOption) {
                                    onOption = true;
                                  }
                                });
                              },
                              child: const CText(
                                "Options",
                                size: 20,
                                weight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            (onOption)
                                ? Container(
                                    height: 2,
                                    width: 80,
                                    color: Colors.black,
                                  )
                                : Container()
                          ],
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (onOption) {
                                    onOption = false;
                                  }
                                });
                              },
                              child: const CText(
                                "Structures",
                                size: 20,
                                weight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            (!onOption)
                                ? Container(
                                    height: 2,
                                    width: 80,
                                    color: Colors.black,
                                  )
                                : Container()
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
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
                                var op = (onOption)
                                    ? thisOptiont[i]
                                    : thStructure[i];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return OptionScreen(option: op);
                                    }));
                                  },
                                  child: SizedBox(
                                    child: Card(
                                      child: Row(
                                        children: [
                                          Image.network(
                                            (onOption) ? op.image! : op.logo!,
                                            width: 90,
                                            height: 70,
                                            fit: BoxFit.cover,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Flexible(
                                            child: CText(
                                              (onOption)
                                                  ? op.denomination
                                                  : op.nom,
                                              weight: FontWeight.w600,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, inw) {
                                return const SizedBox(
                                  height: 2,
                                );
                              },
                              itemCount: (onOption)
                                  ? thisOptiont.length
                                  : thStructure.length),
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
