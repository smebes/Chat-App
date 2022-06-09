import 'package:flutter/material.dart';
import 'package:negotiation/echarts.dart';
import 'package:negotiation/recognize/recognize.dart';
import 'package:negotiation/screens/chats/chats_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(
              flex: 2,
            ),
            Image.asset('assets/images/welcome_image.png'),
            const Spacer(
              flex: 3,
            ),
            Text(
              'Welcome to Negotiation',
              textAlign: TextAlign.center,
              style: Theme
                  .of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Text(
              'You still have a chance to make a deal.',
              textAlign: TextAlign.center,
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyText1,
            ),
            const Spacer(
              flex: 3,
            ),
            skipButton(context, 'Cars', const ChatsScreen()),
            skipButton(context, 'eCharts', const MyHomePage()),
            skipButton(context, 'Recognize', const RecognizePage()),
          ],
        ),
      ),
    );
  }

  FittedBox skipButton(BuildContext context, String skipName, Widget page) {
    return FittedBox(
      child: TextButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => page,
          ),
        ),
        child: Row(
          children: [
            Text(
              skipName,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: Theme.of(context).textTheme.bodyText1?.color),
            ),
            const SizedBox(
              width: 5.0,
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.color
                  ?.withOpacity(0.8),
            ),
          ],
        ),
      ),
    );
  }
}
