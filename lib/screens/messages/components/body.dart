import 'package:flutter/material.dart';
import 'package:negotiation/constants.dart';
import 'package:negotiation/models/chat_message.dart';
import 'package:negotiation/screens/messages/components/chat_input_field.dart';
import 'package:negotiation/screens/messages/components/message.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPadding),
            child: 
            ListView.builder(
              itemCount: demeChatMessages.length,
              itemBuilder: (context, index) =>
                  Message(message: demeChatMessages[index]),
            ),
          ),
        ),
        const ChatInputField(),
      ],
    );
  }
}


