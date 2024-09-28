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
  bool isSpeaking = false;
  ScrollController _controller = ScrollController();
  late FlutterTts textToSpeech;
  String currentMessage = '';

  Future _speak(String text) async {
    await textToSpeech.setLanguage('en-US');
    await textToSpeech.setPitch(1.0);
    await textToSpeech.speak(text);
  }

  Future stop() async {
    await textToSpeech.stop();
  }

  @override
  void initState() {
    super.initState();
    _scrollToBottom();
    textToSpeech = FlutterTts();
  }

  @override
  Widget build(BuildContext context) {
    final chatModel = Provider.of<ChatModelProvider>(context, listen: false);

    if (chatModel.messages.isNotEmpty) {
      currentMessage = chatModel.messages.last.message;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            GestureDetector(
              child: const Icon(Icons.close),
              onTap: () async {
                setState(() {
                  chatModel.messages.clear();
                  chatModel.changeforHome();
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
                  isSpeaking = !isSpeaking;
                });

                if (isSpeaking) {
                  _speak(currentMessage).then((value) {
                    setState(() {
                      isSpeaking = false;
                    });
                  });
                } else {
                  await stop();
                  setState(() {
                    isSpeaking = false;
                  });
                }
              },
              icon: Icon(Icons.volume_up),
            ),
            SizedBox(width: 10),
            Icon(Icons.share),
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
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _controller.animateTo(
        _controller.position.maxScrollExtent,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }
}
