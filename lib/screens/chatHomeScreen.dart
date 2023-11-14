import 'package:flutter/material.dart';
import 'package:gde/screens/chatScreenPage.dart';
import 'package:gde/services/providerUsage.dart';
import 'package:gde/widgets/MessageInput.dart';
import 'package:gde/widgets/suggestion_topics.dart';
import 'package:provider/provider.dart';

class ChatHomeScreen extends StatefulWidget {
  static const String id = 'home';

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  final ScrollController _scrollController = ScrollController();

  //final FirebaseMangement firebaseMangement = FirebaseMangement();
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<String>? apikey;

  // void getKey() async {
  //   AIHandler.api = await firebaseMangement.getAdmin();
  // }

  @override
  void initState() {
    super.initState();
  }

  void _openSession() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(),
      ),
    );
  }

  int selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    final chatModel = Provider.of<ChatModelProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.topLeft,
              child: const Text(
                "Suggestions de discussions",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: topics.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectIndex = index;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(left: 15),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: selectIndex == index
                            ? Colors.blue
                            : Colors
                                .white12, // Change la couleur du conteneur si c'est la sélection actuelle
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            topics[index].icon,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            topics[index].sujet,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.47, // Ajustez la hauteur de la ListView selon vos besoins
              child: ListView.builder(
                controller: _scrollController,
                itemCount: topics[selectIndex].suggestions.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      setState(() {
                        chatModel.focused();
                        MessageInput.sended = topics[selectIndex]
                            .suggestions[index]
                            .suggestionPrompt;
                        MessageInput.isfocused = chatModel.isFocused;
                        MessageInput.myFocuseNode.requestFocus();
                      });
                      chatModel.change();
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white12,
                      ),
                      child: Text(
                        topics[selectIndex].suggestions[index].suggestions,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
