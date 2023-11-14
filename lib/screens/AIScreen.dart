import 'package:flutter/material.dart';
import 'package:gde/screens/chatHomeScreen.dart';
import 'package:gde/screens/chatScreenPage.dart';
import 'package:gde/services/providerUsage.dart';
import 'package:gde/widgets/MessageInput.dart';
import 'package:provider/provider.dart';

class StartAIScreen extends StatefulWidget {
  const StartAIScreen({Key? key});
  static const String id = 'start';

  @override
  State<StartAIScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartAIScreen> {
  bool ishome = true;
  @override
  Widget build(BuildContext context) {
    //final chatModel = Provider.of<ChatModelProvider>(context, listen: false);
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: Consumer<ChatModelProvider>(
          builder: (context, value, child) {
            ishome = value.isHome;
            return ishome == true ? ChatHomeScreen() : ChatScreen();
          },
        ),
      ),
      bottomSheet: MessageInput(),
    );
  }
}
