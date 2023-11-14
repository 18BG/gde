import 'package:flutter/material.dart';
import 'package:gde/services/providerUsage.dart';
import 'package:gde/widgets/chatItem.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key, this.messageTopics});
  static const String id = 'chat';
  final String? messageTopics;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isSpeacking = false;
  ScrollController _controller = ScrollController();
  late FlutterTts text_to_speech;
  Future _speack(String texte) async {
    await text_to_speech.setLanguage('en-US');
    await text_to_speech.setPitch(1.0);
    await text_to_speech.speak(texte);
  }

  String currentMessage = '';
  Future stop() async {
    await text_to_speech.stop();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollToBottom();
    text_to_speech = FlutterTts();
  }

  @override
  Widget build(BuildContext context) {
    final chatModel = Provider.of<ChatModelProvider>(context, listen: false);
    if (chatModel.messages.isNotEmpty) {
      currentMessage = chatModel.messages.last.message;
    }
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Row(
          children: [
            GestureDetector(
              child: const Icon(
                Icons.close,
              ),
              onTap: () async {
                //_closeSession;
                // ignore: use_build_context_synchronousl
                //chatModel.dispose();
                setState(() {
                  chatModel.messages.clear();
                  chatModel.changeforHome();
                  print(chatModel.isHome);
                  stop();
                });
              },
            ),
            Spacer(),
            Text("Le Guide"),
            Spacer(),
            IconButton(
                onPressed: () async {
                  await stop();
                  setState(() {
                    isSpeacking = !isSpeacking;
                    print(isSpeacking);
                  });
                  if (isSpeacking) {
                    _speack(currentMessage).then((value) {
                      setState(() {
                        isSpeacking = false;
                      });
                    });
                  } else {
                    await stop();
                    setState(() {
                      isSpeacking = false;
                    });
                  }
                  print(isSpeacking);
                },
                icon: const Icon(Icons.volume_up)),
            SizedBox(
              width: 10,
            ),
            Icon(Icons.share)
          ],
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatModel.messages.length,
              controller: _controller,
              itemBuilder: (context, index) {
                currentMessage = chatModel.messages.last.message;
                return ChatItem(
                  text: chatModel.messages[index].message,
                  isMe: chatModel.messages[index].isUser,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.animateTo(_controller.position.maxScrollExtent,
          duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
  }
}
