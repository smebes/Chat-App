import 'package:flutter/material.dart';
import 'package:negotiation/constants.dart';
import 'package:negotiation/screens/messages/components/body.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          const BackButton(),
          const CircleAvatar(
            backgroundImage: AssetImage("assets/images/user_2.png"),
          ),
          const SizedBox(width: kPadding * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Kristin Watson",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "Active 3m ago",
                style: TextStyle(fontSize: 12),
              )
            ],
          )
        ],
      ),
      // actions: [
      //   IconButton(
      //     icon: const Icon(Icons.local_phone),
      //     onPressed: () {},
      //   ),
      //   IconButton(
      //     icon: const Icon(Icons.videocam),
      //     onPressed: () {},
      //   ),
      //   const SizedBox(width: kPadding / 2),
      // ],
    );
  }

}