// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:children_app/utils/App_custom.dart';
import 'package:children_app/utils/constants.dart';
import 'package:children_app/utils/custom_Button.dart';
import 'package:children_app/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:just_audio/just_audio.dart';

import '../utils/const_dimensions.dart';

class Fruit {
  final String name;
  final String svgAsset;
  final bool isfruit;
  final Color backgroundColor;

  Fruit({
    required this.name,
    required this.isfruit,
    required this.svgAsset,
    required this.backgroundColor,
  });
}

class FruitsPage extends StatefulWidget {
  FruitsPage({Key? key}) : super(key: key);

  @override
  State<FruitsPage> createState() => _FruitsPageState();
}

class _FruitsPageState extends State<FruitsPage> {
  final FlutterTts flutterTts = FlutterTts();
  int _currentIndex = 0;

  final AudioPlayer audioPlayer = AudioPlayer();
  Color? bgColor;
  @override
  void initState() {
    bgColorInit();
    super.initState();
  }

  void bgColorInit() {
    Future.delayed(Duration.zero).then((value) {
      bgColor = appCustomColour;
    }).then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
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
            const Text(
              '   ${AppConstants.fruit}',
              style: TextStyle(fontWeight: FontWeight.bold, color: whiteCustom),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: _navigateToNextBird,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
                gradient: LinearGradient(
                  colors: [gradient1, gradient2], // Start and end colors
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Container(
                      // color: Colors.amber,
                      width: ConstantDimensions.widthExtraLarge * 6,
                      height: ConstantDimensions.heightExtraLarge * 6,
                      child: SvgPicture.asset(
                          AppConstants.Fruits[_currentIndex].svgAsset),
                    ),
                  ),
                  IconButton.outlined(
                    onPressed: () {
                      AppFunctions().readName(
                        AppConstants.Fruits[_currentIndex].name,
                      );
                    },
                    icon: const Icon(Icons.volume_up_outlined),
                  ),
                  Text(
                    AppConstants.Fruits[_currentIndex].name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                      fontFamily: 'Comic',
                    ),
                  ),
                  const SizedBox(height: ConstantDimensions.heightMedium),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        backgroundColor: appCustomColour,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        onPressed: () {
                          _navigateToPrevBird();
                        },
                        child: const Icon(
                          Icons.arrow_circle_left_outlined,
                          color: whiteCustom,
                          size: 40,
                        ),
                      ),
                      // IconButton(
                      //   onPressed: _navigateToPrevBird,
                      //   icon: const Icon(Icons.arrow_back),
                      // ),

                      FloatingActionButton(
                        backgroundColor: appCustomColour,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        onPressed: () {
                          _navigateToNextBird();
                        },
                        child: const Icon(
                          Icons.arrow_circle_right_outlined,
                          color: whiteCustom,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: ConstantDimensions.heightMedium),
                ],
              ),
            ),
          ),
          const SizedBox(height: ConstantDimensions.heightMedium),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RoundButton(
                width: 160,
                title: 'Fruit',
                fun: () {
                  if (AppConstants.Fruits[_currentIndex].isfruit == true) {
                    bgColor = const Color.fromARGB(255, 160, 245, 163);
                    setState(() {});
                  } else {
                    bgColor = const Color.fromARGB(255, 242, 155, 148);
                    setState(() {});
                  }
                },
              ),
              RoundButton(
                width: 160,
                title: 'Vegetable',
                fun: () {
                  if (AppConstants.Fruits[_currentIndex].isfruit == false) {
                    bgColor = const Color.fromARGB(255, 160, 245, 163);
                    setState(() {});
                  } else {
                    bgColor = const Color.fromARGB(255, 242, 155, 148);
                    setState(() {});
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _navigateToNextBird() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % AppConstants.Fruits.length;
    });
    bgColorInit();
  }

  void _navigateToPrevBird() {
    setState(() {
      _currentIndex = (_currentIndex - 1) % AppConstants.Fruits.length;
    });
    bgColorInit();
  }
}

class WidgetStateProperty {
  static all(Size size) {}
}
