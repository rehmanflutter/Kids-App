import 'package:children_app/models/flower_model.dart';
import 'package:children_app/utils/App_custom.dart';
import 'package:children_app/utils/assets_path.dart';
import 'package:children_app/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'flowers_test.dart';

class FlowerPage extends StatefulWidget {
  const FlowerPage({super.key});

  @override
  State<FlowerPage> createState() => _FlowerPageState();
}

class _FlowerPageState extends State<FlowerPage> {
  final List<Flower> flowers = [
    Flower(
      name: "Rose",
      resource: AssetsPath.getFlowerImage(Flowers.rose),
      background: Colors.redAccent,
    ),
    Flower(
      name: "Sunflower",
      resource: AssetsPath.getFlowerImage(Flowers.sunflower),
      background: Colors.yellowAccent,
    ),
    Flower(
      name: "Lily",
      resource: AssetsPath.getFlowerImage(Flowers.lily),
      background: Colors.greenAccent,
    ),
    Flower(
      name: "Marigold",
      resource: AssetsPath.getFlowerImage(Flowers.marigold),
      background: Colors.yellow,
    ),
    Flower(
      name: "Carnation",
      resource: AssetsPath.getFlowerImage(Flowers.carnation),
      background: Colors.redAccent,
    ),
    Flower(
      name: "Daffodil",
      resource: AssetsPath.getFlowerImage(Flowers.daffodil),
      background: Colors.purpleAccent,
    ),
    Flower(
      name: "Daisy",
      resource: AssetsPath.getFlowerImage(Flowers.daisy),
      background: Colors.green,
    ),
    Flower(
      name: "Poppy",
      resource: AssetsPath.getFlowerImage(Flowers.poppy),
      background: Colors.redAccent,
    ),
    Flower(
      name: "Tulip",
      resource: AssetsPath.getFlowerImage(Flowers.tulip),
      background: Colors.pink,
    ),
    Flower(
      name: "Lavender",
      resource: AssetsPath.getFlowerImage(Flowers.lavender),
      background: Colors.purple,
    ),
    Flower(
      name: "Hibiscus",
      resource: AssetsPath.getFlowerImage(Flowers.hibiscus),
      background: Colors.red,
    ),
  ];

  final FlutterTts flutterTts = FlutterTts();
  int currentIndex = 0;

  void _navigateToNextFlower() {
    setState(() {
      currentIndex = (currentIndex + 1) % flowers.length;
    });
  }

  void _navigateToPreviousFlower() {
    setState(() {
      currentIndex = (currentIndex - 1 + flowers.length) % flowers.length;
    });
  }

  void _navigateToFlowersTestPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FlowersTestPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    Flower flower = flowers[currentIndex];
    String flowerImagePath = flower.resource;
    // ignore: avoid_print
    print('Flower image path: $flowerImagePath'); // Debug print

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appCustomColour,
        automaticallyImplyLeading: false,
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
              '   Flowers',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: whiteCustom),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.assignment,
              color: whiteCustom,
            ),
            onPressed: () {
              _navigateToFlowersTestPage(context);
            },
          ),
        ],
      ),
      backgroundColor: flower.background,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(0),
            constraints:
                const BoxConstraints(maxWidth: double.infinity, maxHeight: 700),
            decoration: BoxDecoration(
              //backgroundColor: flower.background,

              gradient: const LinearGradient(
                colors: [
                  gradient2,
                  gradient1,
                ],
                begin: Alignment.topLeft, // Gradient direction start
                end: Alignment.bottomRight, // Gradient direction end
              ),

              //  color: Colors.white.withOpacity(0.2),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _navigateToNextFlower,
                  child: SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: SvgPicture.asset(
                      flowerImagePath,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  flower.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 60,
                    fontFamily: 'Comic',
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
                        _navigateToPreviousFlower();
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
                        AppFunctions().readName(flower.name);
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
                        _navigateToNextFlower();
                      },
                      child: const Icon(
                        Icons.arrow_circle_right_outlined,
                        color: whiteCustom,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
