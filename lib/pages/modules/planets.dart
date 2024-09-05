// ignore_for_file: library_private_types_in_public_api

import 'package:children_app/models/planet_model.dart';
import 'package:children_app/utils/App_custom.dart';
import 'package:children_app/utils/constants.dart';
import 'package:children_app/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:just_audio/just_audio.dart';
import '../../utils/const_dimensions.dart';
import 'planets_test.dart';

class PlanetsPage extends StatelessWidget {
  final FlutterTts flutterTts = FlutterTts();
  final AudioPlayer audioPlayer = AudioPlayer();

  PlanetsPage({Key? key}) : super(key: key);
  void _navigateToPlanetsTestPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PlanetsTestPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            const Text(
              AppConstants.solar,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: 'Schyles'),
            ),
            const SizedBox(),
          ],
        ),

        // title: const Text(
        //   AppConstants.solar,
        //   style: TextStyle(fontWeight: FontWeight.bold),
        // ),
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.assignment),
        //     onPressed: () {
        //       _navigateToPlanetsTestPage(context);
        //     },
        //   ),
        // ],
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              gradient1,
              gradient2

              // Color(0xffa1c4fd),

              //  Color(0xff56a5b5)
            ], // Start and end colors
            // begin: Alignment.topLeft, // Gradient direction start
            // end: Alignment.bottomRight, // Gradient direction end
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: PlanetWidget(
              planets: AppConstants.planets,
              flutterTts: flutterTts,
              audioPlayer: audioPlayer,
            ),
          ),
        ),
      ),
    );
  }
}

class PlanetWidget extends StatefulWidget {
  final List<Planet> planets;
  final FlutterTts flutterTts;
  final AudioPlayer audioPlayer;

  const PlanetWidget({
    Key? key,
    required this.planets,
    required this.flutterTts,
    required this.audioPlayer,
  }) : super(key: key);

  @override
  _PlanetWidgetState createState() => _PlanetWidgetState();
}

class _PlanetWidgetState extends State<PlanetWidget> {
  int currentIndex = 0;

  final _animationDuration = const Duration(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    Planet planet = widget.planets[currentIndex];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: _navigateToNextPlanet,
          child: AnimatedContainer(
            duration: _animationDuration,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8.0),
              color: planet.backgroundColor,
            ),
            child: Center(
              child: AnimatedSize(
                duration: _animationDuration,
                child: SvgPicture.asset(
                  planet.svgAsset,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: ConstantDimensions.heightMedium),
        Text(
          planet.description,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: ConstantDimensions.heightMedium),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: _navigateToPreviousPlanet,
              icon: const Icon(Icons.arrow_back),
            ),
            const SizedBox(width: ConstantDimensions.widthMedium),
            ElevatedButton(
              onPressed: () {
                AppFunctions().readName(planet.name);
              },
              child: const Text('Play Sound'),
            ),
            const SizedBox(width: ConstantDimensions.widthMedium),
            IconButton(
              onPressed: _navigateToNextPlanet,
              icon: const Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ],
    );
  }

  void _navigateToNextPlanet() {
    setState(() {
      currentIndex = (currentIndex + 1) % widget.planets.length;
    });
  }

  void _navigateToPreviousPlanet() {
    setState(() {
      currentIndex =
          (currentIndex - 1 + widget.planets.length) % widget.planets.length;
    });
  }
}
