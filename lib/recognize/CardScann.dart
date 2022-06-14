import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:async';
// import 'package:card_scanner/card_scanner.dart';
// import 'package:negotiation/recognize/scan_option_configure_widget.dart';

class CardScann extends StatefulWidget {
  @override
  _CardScannState createState() => _CardScannState();
}

class _CardScannState extends State<CardScann> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  // late CardDetails _cardDetails;
  // CardScanOptions scanOptions = const CardScanOptions(
  //   scanCardHolderName: true,
  //   // enableDebugLogs: true,
  //   validCardsToScanBeforeFinishingScan: 5,
  //   possibleCardHolderNamePositions: [
  //     CardHolderNameScanPosition.aboveCardNumber,
  //   ],
  // );

  // Future<void> scanCard() async {
  //   var cardDetails = await CardScanner.scanCard(scanOptions: scanOptions);
  //   if (!mounted) return;
  //   setState(() {
  //     _cardDetails = cardDetails;
  //   });
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home: Scaffold(
  //       appBar: AppBar(
  //         title: const Text('card_scanner app'),
  //       ),
  //       body: Center(
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: [
  //             RaisedButton(
  //               onPressed: () async {
  //                 scanCard();
  //               },
  //               child: Text('scan card'),
  //             ),
  //             Text('$_cardDetails'),
  //             Expanded(
  //               child: OptionConfigureWidget(
  //                 initialOptions: scanOptions,
  //                 onScanOptionChanged: (newOptions) => scanOptions = newOptions,
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}