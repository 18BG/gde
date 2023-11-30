import 'package:flutter/material.dart';
import 'package:gde/models/Options.dart';
import 'package:gde/services/data_provider.dart';
import 'package:gde/widgets/expandable_text.dart';
import 'package:gde/widgets/mytext.dart';
import 'package:provider/provider.dart';

class OptionScreen extends StatefulWidget {
  final Option option;

  const OptionScreen({super.key, required this.option});

  @override
  State<OptionScreen> createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  late DataProvider provider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider = Provider.of<DataProvider>(context, listen: false);
    if (provider.listedebouche.isEmpty) {
      provider.getDebouche();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, value, child) {
        var thisOptiont = [];
        thisOptiont.addAll(value.option_liste);
        // for (var fiel in value.option_liste) {
        //   if (fiel.filiere_id == widget.option.id) {
        //     thisOptiont.add(fiel);
        //   }
        // }
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                CText(
                  widget.option.denomination,
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
                        child: Image.network(widget.option.image!)),
                    const SizedBox(
                      height: 10,
                    ),
                    // CText(
                    //   widget.filiere.description,
                    //   size: 18,
                    // ),
                    ExpandableTextWidget(
                        text: widget.option.description, maxLines: 2),
                    const SizedBox(
                      height: 10,
                    ),
                    const CText(
                      "Débouchés",
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
                      child: widget.option.deboucheliste.isEmpty
                          ? const Center(
                              child: CText(
                                "Aucun débouché",
                                size: 18,
                                color: Colors.white,
                              ),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(
                                  parent: NeverScrollableScrollPhysics()),
                              itemBuilder: (context, i) {
                                var op = widget.option.deboucheliste[i];
                                return InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              CText(op.titre),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Image.network(op.image),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    CText(
                                                      op.contenue,
                                                      size: 19,
                                                      color: Colors.blueGrey,
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    const CText(
                                                        "Salaire annuel approxitif selon certains zones "),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      child: CText(op.salaire),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Card(
                                    child: Row(
                                      children: [
                                        Image.network(
                                          op.image,
                                          width: 90,
                                          //height: 60,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Flexible(
                                          child: CText(
                                            op.titre,
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
                              itemCount: widget.option.deboucheliste.length),
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

  Widget _buildRecommendation(String title, String? desc) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CText(
              title,
              weight: FontWeight.bold,
              color: Colors.green,
              size: 20,
            ),
            const SizedBox(height: 5),
            CText(desc!),
          ],
        ),
      ),
    );
  }
}
