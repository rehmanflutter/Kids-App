// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, deprecated_member_use, must_be_immutable

import 'package:children_app/models/animal_model.dart';
import 'package:children_app/utils/App_custom.dart';
import 'package:children_app/utils/constants.dart';
import 'package:children_app/utils/custom_Button.dart';
import 'package:children_app/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:just_audio/just_audio.dart';
import '../../utils/const_dimensions.dart';
import 'animals_test.dart';

class AnimalsPage extends StatelessWidget {
  final FlutterTts flutterTts = FlutterTts();
  final AudioPlayer audioPlayer = AudioPlayer();

  AnimalsPage({Key? key}) : super(key: key);

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
                '   ${AppConstants.animal}',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: whiteCustom),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.quiz_rounded,
                color: whiteCustom,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AnimalsTestPage()),
                );
              },
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [gradient1, gradient2], // Start and end colors
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GridView.builder(
              itemCount: AppConstants.animals.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of items in a row
                  mainAxisSpacing: 5.0, // Spacing along the main axis
                  crossAxisSpacing: 5.0, // Spacing along the cross axis
                  mainAxisExtent: 170),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _showAnimalPopup(
                        context, AppConstants.animals[index], index);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      //  border: Border.all(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                      color: AppConstants.animals[index].backgroundColor,
                    ),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                            height: 90, AppConstants.animals[index].svgAsset),
                        const SizedBox(
                            width: ConstantDimensions.widthMedium_Large),
                        Text(
                          AppConstants.animals[index].name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: whiteCustom,
                            fontSize: 30.0,
                            fontFamily: 'Comic',
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        )
        // ListView.builder(
        //   itemCount: AppConstants.animals.length,
        //   itemBuilder: (context, index) {
        //     return GestureDetector(
        //       onTap: () {
        //         _showAnimalPopup(context, AppConstants.animals[index], index);
        //       },
        //       child: Container(
        //         margin: const EdgeInsets.all(5.0),
        //         padding: const EdgeInsets.all(8.0),
        //         decoration: BoxDecoration(
        //           border: Border.all(color: Colors.black, width: 1.0),
        //           borderRadius: BorderRadius.circular(8.0),
        //           color: AppConstants.animals[index].backgroundColor,
        //         ),
        //         child: Row(
        //           children: [
        //             SizedBox(
        //               width: ConstantDimensions.widthExtraLarge,
        //               height: ConstantDimensions.heightExtraLarge,
        //               child:
        //                   SvgPicture.asset(AppConstants.animals[index].svgAsset),
        //             ),
        //             const SizedBox(width: ConstantDimensions.widthMedium_Large),
        //             Text(
        //               AppConstants.animals[index].name,
        //               style: const TextStyle(
        //                 fontWeight: FontWeight.bold,
        //                 fontSize: 30.0,
        //                 fontFamily: 'Comic',
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     );
        //   },
        // ),

        );
  }

  Future<void> _showAnimalPopup(
      BuildContext context, Animal animal, int currentIndex) async {
    await flutterTts.setVolume(1.0);
    await flutterTts.setSpeechRate(.5);
    await flutterTts.setLanguage("EN-IN");
    await flutterTts.setPitch(1.0);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AnimalPopup(
          animal: animal,
          flutterTts: flutterTts,
          audioPlayer: audioPlayer,
          animals: AppConstants.animals,
          currentIndex: currentIndex,
        );
      },
    );
  }
}

class AnimalPopup extends StatefulWidget {
  Animal animal;
  final FlutterTts flutterTts;
  final AudioPlayer audioPlayer;
  final List<Animal> animals;
  //final Color col;

  int currentIndex;

  AnimalPopup({
    Key? key,
    required this.animal,
    required this.flutterTts,
    required this.audioPlayer,
    required this.animals,
    required this.currentIndex,
    //  required this.col,
  }) : super(key: key);

  @override
  _AnimalPopupState createState() => _AnimalPopupState();
}

class _AnimalPopupState extends State<AnimalPopup> {
  void initState() {
    // TODO: implement initState
    super.initState();
    AppFunctions().readName(widget.animal.name);
  }

  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: widget.animal.backgroundColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.animal.name,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: whiteCustom),
          ),
          IconButton(
            onPressed: () {
              AppFunctions().readName(widget.animal.name);
            },
            icon: const Icon(
              Icons.volume_up,
              color: whiteCustom,
            ),
          ),
        ],
      ),
      content: Container(
        //color: Colors.amber,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isTapped = !isTapped;
                });
              },
              child: SvgPicture.asset(
                widget.animal.svgAsset,
                color: isTapped ? const Color.fromARGB(81, 118, 96, 94) : null,
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.3,
              ),
            ),
            const SizedBox(height: ConstantDimensions.heightSmall_Medium),
            RoundButton(
              title: 'Spack Sound',
              fun: () {
                AppFunctions().playSound(widget.animal.soundAsset);
                AppFunctions().playSound(widget.animal.soundAsset);
              },
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                  backgroundColor: appCustomColour,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    _navigateToPreviousAnimal();
                    AppFunctions().readName(widget.animal.name);
                  },
                  child: const Icon(
                    Icons.arrow_circle_left_outlined,
                    color: whiteCustom,
                    size: 40,
                  ),
                ),
                // IconButton(
                //   onPressed: () {

                //     AppFunctions().readName(widget.animal.name);
                //   },
                //   icon: const Icon(Icons.arrow_back),
                //   iconSize: 30,
                // ),
                SizedBox(
                  width: ConstantDimensions.exceptions[0],
                ),
                FloatingActionButton(
                  backgroundColor: appCustomColour,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    _navigateToNextAnimal();
                    AppFunctions().readName(widget.animal.name);
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
    );
  }

  void _navigateToPreviousAnimal() {
    setState(() {
      widget.currentIndex = (widget.currentIndex - 1) % widget.animals.length;
      if (widget.currentIndex < 0) {
        widget.currentIndex = widget.animals.length - 1;
      }
      widget.animal = widget.animals[widget.currentIndex];
    });
  }

  void _navigateToNextAnimal() {
    setState(() {
      widget.currentIndex = (widget.currentIndex + 1) % widget.animals.length;
      widget.animal = widget.animals[widget.currentIndex];
    });
  }
}
