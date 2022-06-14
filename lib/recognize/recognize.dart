import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:negotiation/recognize/credit/utils.dart';

class RecognizePage extends StatefulWidget {
  const RecognizePage({Key? key}) : super(key: key);

  @override
  State<RecognizePage> createState() => _RecognizePageState();
}

class _RecognizePageState extends State<RecognizePage> {
  final ImagePicker _picker = ImagePicker();
  bool textScanning = false;
  XFile? imageFile;
  String scannedText = "null";

  // Farklı String değerler var. Hepsini diziye atayıp en alttakini alıyorum.
  List<dynamic> holderName = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Text Recognition example"),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (textScanning) const CircularProgressIndicator(),
                if (!textScanning && imageFile == null)
                  Container(
                    width: 300,
                    height: 300,
                    color: Colors.grey[300]!,
                  ),
                if (imageFile != null) Image.file(File(imageFile!.path)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.grey,
                            shadowColor: Colors.grey[400],
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                          onPressed: () {
                            getImage(ImageSource.gallery);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.image,
                                  size: 30,
                                ),
                                Text(
                                  "Gallery",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[600]),
                                )
                              ],
                            ),
                          ),
                        )),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.grey,
                            shadowColor: Colors.grey[400],
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                          onPressed: () {
                            getImage(ImageSource.camera);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.camera_alt,
                                  size: 30,
                                ),
                                Text(
                                  "Camera",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[600]),
                                )
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    scannedText,
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            )),
      )),
    );
  }

  void getImage(ImageSource source) async {
    holderName = [];
    scannedText = '';
    final pickedImage = await _picker.pickImage(source: source);
    print('Resim----${pickedImage!.path}');

    try {
      if (pickedImage != null) {
        textScanning = false;
        imageFile = pickedImage;
        setState(() {});
        getRecognisedText(pickedImage);
      }
    } catch (e) {
      textScanning = false;
      imageFile = null;
      scannedText = "Error occured while scanning";
      setState(() {});
    }
  }

  void getRecognisedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = GoogleMlKit.vision.textRecognizer();
    // final textDetector = GoogleMlKit.vision.textDetector();
    RecognizedText recognisedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText = "";

    // Burada satır satır okutuorum. Sonra da ilgili satırlarda işlem yaparak bana lazım olan bilgileri çekiyorum
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        String _cardIssuer = CardUtils().getCardIssuer(line.text).toString();

        // Expiry Date'i / işaretinin sağındaki ve solundaki 2 rakamı alarak yaptım
        if (line.text.contains('/')) {
          var str = line.text;
          var parts = str.split('/');
          var prefix = parts[0].trim();
          var suffix = parts.last.trim().substring(0, 2);
          var preDate = prefix.substring(prefix.length - 2);
          var dateT = preDate + '/' + suffix;
          var dateS = dateT.replaceAll('l', '1');
          if (suffix.contains(RegExp(r'[0-9]')) &&
              preDate.contains(RegExp(r'[0-9]'))) {
            scannedText = scannedText + "\n" + 'Expiry Date: ' + dateS + "\n";
          }
        }
        // Burada da holderName'i biz dizi şeklinde belirliyorum
        // Bir çok string değer var. Ben onların en altındakini alıyorum
        if (line.text.contains(RegExp(r'[A-Z]'))) {
          if (!line.text.contains(RegExp(r'[0-9]'))) {
            if (line.text.toLowerCase().contains('master') ||
                line.text.toLowerCase().contains('valio') ||
                line.text.toLowerCase().contains('card') ||
                line.text.toLowerCase().contains('visa') ||
                line.text.toLowerCase().contains('gold') ||
                line.text.toLowerCase().contains('paywave') ||
                line.text.toLowerCase().contains('classic')) {
              print('Wrong Name: ----- ${line.text}');
            } else {
              holderName.add(line.text.toString());
            }
          }
        }

        // Card bilgileri için mevcut olan CardUtils() sınıfından getCardIssuer() metodunu kullandım.
        if (line.text.contains(RegExp(r'[0-9]')) && line.text.length >= 10) {
          if (!line.text.contains('/')) {
            if (_cardIssuer == 'CardIssuer.visa' ||
                _cardIssuer == 'CardIssuer.mastercard' ||
                _cardIssuer == 'CardIssuer.dinersClub' ||
                _cardIssuer == 'CardIssuer.amex' ||
                _cardIssuer == 'CardIssuer.jcb' ||
                _cardIssuer == 'CardIssuer.discover' ||
                _cardIssuer == 'CardIssuer.bCGlobal' ||
                _cardIssuer == 'CardIssuer.carteBlanche' ||
                _cardIssuer == 'CardIssuer.instaPayment' ||
                _cardIssuer == 'CardIssuer.maestro' ||
                _cardIssuer == 'CardIssuer.solo' ||
                _cardIssuer == 'CardIssuer.unionPay' ||
                _cardIssuer == 'CardIssuer.koreanLocal') {
              scanText(line, 'Card Number: ');
            }
          } else {
            print('Sayı yazılamadı-----  ${line.text}');
          }
        }
      }
    }
    textScanning = false;
    setState(() {
      if (holderName.isNotEmpty) {
        String st = holderName.last.toString();
        scannedText = scannedText + "\n" + 'Holder Name: ' + st + "\n";
      }
    });
  }

  String scanText(TextLine line, String st) {
    return scannedText = scannedText + "\n" + st + line.text.toString() + "\n";
  }
}
