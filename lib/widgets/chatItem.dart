import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:share/share.dart';

class ChatItem extends StatefulWidget {
  final String text;
  final bool isMe;
  const ChatItem({
    super.key,
    required this.text,
    required this.isMe,
  });

  @override
  State<ChatItem> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  bool isSpeaking = false;
  late FlutterTts textToSpeech;

  @override
  void initState() {
    super.initState();
    textToSpeech = FlutterTts();
  }

  Future _speak(String texte) async {
    await textToSpeech.setLanguage('en-US');
    await textToSpeech.setPitch(1.0);
    await textToSpeech.speak(texte);
  }

  Future _stop() async {
    await textToSpeech.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: widget.isMe ? Color.fromARGB(255, 40, 54, 40) : Colors.black),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ProfileContainer(isMe: widget.isMe),
              Container(
                padding: const EdgeInsets.all(15),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.85,
                ),
                child: GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: widget.text));
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(seconds: 0),
                      content: Text("Texte copié dans le presse-papiers"),
                    ));
                  },
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileContainer extends StatelessWidget {
  const ProfileContainer({
    super.key,
    required this.isMe,
  });

  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      alignment: Alignment.center,
      width: 40,
      height: 40,
      child: Icon(
        isMe ? Icons.person : Icons.computer,
        color: Theme.of(context).colorScheme.onSecondary,
      ),
    );
  }
}
