import 'package:flutter/material.dart';
import 'package:gde/models/publication_model.dart';
import 'package:gde/services/data_provider.dart';
import 'package:gde/widgets/publicationt_widget.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late DataProvider provider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider = Provider.of<DataProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (provider.field.isEmpty) {
        provider.getPub();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, value, child) {
        print("object");

        print(value.listepub.length);
        return Scaffold(
            body: (value.listepub.isNotEmpty)
                ? CustomScrollView(
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
                            Publication pub = value.listepub[index];
                            List<String> url = [];
                            for (var im in pub.image!) {
                              url.add(im.imageUrl);
                            }

                            return PublicationWidget(
                                publication: pub,
                                username: "Abkass",
                                listimage: url);
                          },
                          childCount: value.listepub
                              .length, // Change this to your desired number of news items
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ));
      },
    );
  }
}
