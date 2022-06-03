import 'package:flutter/material.dart';
import 'package:negotiation/components/filled_outline_button.dart';
import 'package:negotiation/constants.dart';
import 'package:negotiation/models/Chat.dart';
import 'package:negotiation/screens/chats/components/chat_card.dart';
import 'package:negotiation/screens/messages/message_screen.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          color: kPrimaryColor,
          child: Row(
            children: [
              const Spacer(
                flex: 2,
              ),
              FillOutlineButton(press: () {}, text: "Recent Auction"),
              const Spacer(
                flex: 3,
              ),
              FillOutlineButton(
                press: () {},
                text: "Negotiation",
                isFilled: false,
              ),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: chatsData.length,
            itemBuilder: (context, index) => ChatCard(
              chat: chatsData[index],
              press: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MessagesScreen(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


