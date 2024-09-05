import 'package:children_app/models/colours_model.dart';
import 'package:children_app/utils/App_custom.dart';
import 'package:children_app/utils/assets_path.dart';
import 'package:children_app/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ColoursPage extends StatefulWidget {
  const ColoursPage({Key? key}) : super(key: key);

  @override
  _ColoursPageState createState() => _ColoursPageState();
}

class _ColoursPageState extends State<ColoursPage> {
  final List<Colours> colours = [
    Colours(
      name: 'Blue',
      jpgAsset: AssetsPath.getColoursImage(ColorImages.blue),
      bgColor: Colors.lightBlueAccent,
      fontColor: Colors.lightBlueAccent,
    ),
    Colours(
      name: 'Yellow',
      jpgAsset: AssetsPath.getColoursImage(ColorImages.yellow),
      bgColor: Colors.yellow.shade600,
      fontColor: Colors.yellow.shade600,
    ),
    Colours(
      name: 'Black',
      jpgAsset: AssetsPath.getColoursImage(ColorImages.black),
      bgColor: Colors.black,
      fontColor: Colors.black,
    ),
    Colours(
      name: 'Green',
      jpgAsset: AssetsPath.getColoursImage(ColorImages.green),
      bgColor: Colors.green,
      fontColor: Colors.green,
    ),
    Colours(
      name: 'Pink',
      jpgAsset: AssetsPath.getColoursImage(ColorImages.pink),
      bgColor: Colors.pink.shade300,
      fontColor: Colors.pink.shade300,
    ),
    Colours(
      name: 'White',
      jpgAsset: AssetsPath.getColoursImage(ColorImages.white),
      bgColor: Colors.grey.shade400,
      fontColor: Colors.grey.shade400,
    ),
    Colours(
      name: 'Red',
      jpgAsset: AssetsPath.getColoursImage(ColorImages.red),
      bgColor: Colors.red,
      fontColor: Colors.red,
    ),
    Colours(
      name: 'Violet',
      jpgAsset: AssetsPath.getColoursImage(ColorImages.violet),
      bgColor: Colors.deepPurple,
      fontColor: Colors.deepPurple,
    ),
    Colours(
      name: 'Brown',
      jpgAsset: AssetsPath.getColoursImage(ColorImages.brown),
      bgColor: const Color(0xFF964B00),
      fontColor: const Color(0xFF964B00),
    ),
    Colours(
      name: 'Orange',
      jpgAsset: AssetsPath.getColoursImage(ColorImages.orange),
      bgColor: Colors.orange,
      fontColor: Colors.orange,
    ),
  ];

  final FlutterTts flutterTts = FlutterTts();
  int currentIndex = 0;

  void _navigateToNextColour() {
    setState(() {
      currentIndex = (currentIndex + 1) % colours.length;
    });
  }

  void _navigateToPreviousColour() {
    setState(() {
      currentIndex = (currentIndex - 1 + colours.length) % colours.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    Colours colour = colours[currentIndex];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: appCustomColour,
        title: Row(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                )),
            Text(
              '   Colours',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: colour.bgColor,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: colour.bgColor,
      body: Center(
        child: Container(
          //   padding: const EdgeInsets.all(20),
          //  constraints: const BoxConstraints(maxWidth: 400, maxHeight: 700),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(7.0),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.white.withOpacity(0.2),
            //     spreadRadius: 2,
            //     blurRadius: 5,
            //     offset: const Offset(0, 3),
            //   ),
            // ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _navigateToNextColour,
                  child: SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: SvgPicture.asset(
                      colour.jpgAsset,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  colour.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 60,
                    fontFamily: 'Comic',
                    color: colour.fontColor,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      backgroundColor: appCustomColour,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      onPressed: () {
                        _navigateToPreviousColour();
                      },
                      child: const Icon(
                        Icons.arrow_circle_left_outlined,
                        color: whiteCustom,
                        size: 40,
                      ),
                    ),
                    const SizedBox(width: 20),
                    IconButton.outlined(
                      highlightColor: appCustomColour,
                      onPressed: () {
                        AppFunctions().readName(colour.name);
                      },
                      icon: const Icon(
                        Icons.volume_up_outlined,
                        size: 40,
                      ),
                    ),
                    const SizedBox(width: 20),
                    FloatingActionButton(
                      backgroundColor: appCustomColour,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      onPressed: () {
                        _navigateToNextColour();
                      },
                      child: const Icon(
                        Icons.arrow_circle_right_outlined,
                        color: whiteCustom,
                        size: 40,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
