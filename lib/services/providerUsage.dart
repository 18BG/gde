import 'dart:io';
import 'package:flutter/material.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:gde/models/chatModel.dart';

class ChatModelProvider with ChangeNotifier {
  bool isHome = true;
  bool isFocused = false;
  String messageSend = "";
  List<ChatMessage> _messages = [];
  List<ChatMessage> get messages => _messages;

  static bool isFinish = false;

  Future<bool> change() async {
    isHome = false;
    notifyListeners();
    return isHome;
  }

  Future<bool> focused() async {
    isFocused = true;
    notifyListeners();
    return isFocused;
  }

  Future<bool> changeforHome() async {
    isHome = true;
    notifyListeners();
    return isHome;
  }

  Future<void> sendMessage(String message, int sessionId) async {
    isFinish = false;
    _messages.add(ChatMessage(message, true, isAnimation: false));
    notifyListeners();
    try {
      String response = await _callChatGptApi(_messages);

      for (int i = 0; i < response.length; i++) {
        i == 0
            ? _messages.add(ChatMessage(response.substring(0, 1), false,
                isAnimation: false))
            : _messages.last.message = _messages.last.message +
                response.substring(
                    i, i + 1); // Mise à jour de la réponse à chaque itération
        await Future.delayed(const Duration(milliseconds: 50));
        notifyListeners();
      }
      isFinish = true;
    } catch (e) {
      _messages.add(
          ChatMessage("Une erreur s'est produite.", false, isAnimation: false));
      notifyListeners();
    }
    // Réinitialisation de la réponse après avoir terminé de l'ajouter aux messages
  }

  static String apiKey = "sfafafeafdsfdafdafdaf";

  final _openAI = OpenAI.instance.build(
    token: apiKey,
    baseOption: HttpSetup(
      receiveTimeout: const Duration(seconds: 60),
      connectTimeout: const Duration(seconds: 60),
    ),
  );
  // Méthode pour appeler l'API ChatGPT (à remplacer par l'appel réel à l'API)
  Future<String> _callChatGptApi(List<ChatMessage> message) async {
    try {
      final list = <Messages>[];
      message.forEach((element) {
        element.isUser == true
            ? list.add(Messages(role: Role.user, content: element.message))
            : list
                .add(Messages(role: Role.assistant, content: element.message));
      });
      final request = ChatCompleteText(
          messages: list, maxToken: 200, model: GptTurbo0301ChatModel());
      final response = await _openAI.onChatCompletion(request: request);
      if (response != null) {
        String reply = response.choices[0].message!.content.trim();
        //List<String> session = [message, reply];
        //await _databaseManager.saveSession(session);
        return reply;
      }

      return 'Some thing went wrong';
    } catch (e) {
      return 'Bad response';
    }
  }
}
