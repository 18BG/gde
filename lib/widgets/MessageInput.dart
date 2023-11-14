import 'package:flutter/material.dart';
import 'package:gde/services/providerUsage.dart';
import 'package:provider/provider.dart';

class MessageInput extends StatefulWidget {
  MessageInput({super.key});

  @override
  State<MessageInput> createState() => _MessageInputState();
  static int id = 0;
  static int i = 0;
  static String sended = "";
  static bool isfocused = false;
  static late FocusNode myFocuseNode;
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _messageController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MessageInput.i = 0;
    MessageInput.myFocuseNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    final chatModel = Provider.of<ChatModelProvider>(context, listen: false);
    setState(() {
      if (_messageController.text == "" && MessageInput.sended != "") {
        _messageController.text = MessageInput.sended;
        MessageInput.isfocused = chatModel.isFocused;
        MessageInput.myFocuseNode.requestFocus();
        MessageInput.sended = "";
      }
    });

    MessageInput.sended = "";
    int identifiant = 0;
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: Colors.black87, width: 2.0),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              focusNode: MessageInput.myFocuseNode,
              onTap: () async {
                await chatModel.change();
                // Navigation vers l'écran ChatScreen lorsque le TextField est cliqué
                if (MessageInput.i == 0) {
                  setState(() {
                    MessageInput.id = identifiant;
                  });
                  MessageInput.i++;
                  print(MessageInput.i);
                  print(identifiant);
                  print(chatModel.isHome);
                  print(MessageInput.id);
                  MessageInput.myFocuseNode.requestFocus();
                  MessageInput.myFocuseNode = FocusNode();
                }
                print(MessageInput.i);
                setState(() {});
              },
              style: const TextStyle(color: Colors.white),
              controller: _messageController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelStyle: TextStyle(color: Colors.white),
                labelText: 'write your message here',
                border: InputBorder.none, // Supprime la ligne du TextField
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: Theme.of(context).colorScheme.onSecondary,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(15),
            ),
            onPressed: () {
              // Action lorsqu'on appuie sur l'icône d'envoi
              chatModel.sendMessage(_messageController.text, MessageInput.id);
              _messageController.clear();
            },
            child: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
