class ChatMessage {
  String message;
  final bool isUser;
  final bool isAnimation;

  ChatMessage(this.message, this.isUser, {this.isAnimation = false});
}
