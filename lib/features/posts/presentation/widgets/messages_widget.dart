import 'package:flutter/material.dart';

class MessagesWidget extends StatelessWidget {
  final String message;
  const MessagesWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}
