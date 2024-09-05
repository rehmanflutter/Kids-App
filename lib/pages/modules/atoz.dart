import 'package:children_app/models/itemdata_model.dart';
import 'package:children_app/utils/App_custom.dart';
import 'package:children_app/utils/const_dimensions.dart';
import 'package:children_app/utils/constants.dart';
import 'package:children_app/utils/functions.dart';
import 'package:children_app/utils/text_custam.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'package:flutter_tts/flutter_tts.dart';
// ignore: unused_import

class ItemTile extends StatelessWidget {
  final int index;
  final List<ItemData> items;
  final bool isTimerEnabled;

  const ItemTile({
    Key? key,
    required this.index,
    required this.items,
    required this.isTimerEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final item = items[index];
    return Card(
      color: item.backgroundColor,
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return _PopupDialog(
                items: items,
                currentIndex: index,
                isAutoNextEnabled: isTimerEnabled,
              );
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Textcustam(
                  text: item.title,
                  align: TextAlign.center,
                  weight: FontWeight.bold,
                  size: 25,
                  col: Colors.white),
              LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                if (MediaQuery.of(context).orientation ==
                    Orientation.portrait) {
                  return SvgPicture.asset(
                    item.iconAsset,
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.1,
                    alignment: Alignment.center,
                  );
                } else {
                  return SvgPicture.asset(
                    item.iconAsset,
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.2,
                    alignment: Alignment.center,
                  );
                }
              }),
              const SizedBox(height: ConstantDimensions.heightExtraSmall / 2),
              Textcustam(
                text: item.description,
                align: TextAlign.center,
                col: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PopupDialog extends StatefulWidget {
  final List<ItemData> items;
  final int currentIndex;
  final bool isAutoNextEnabled;

  const _PopupDialog({
    Key? key,
    required this.items,
    required this.currentIndex,
    required this.isAutoNextEnabled,
  }) : super(key: key);

  @override
  _PopupDialogState createState() => _PopupDialogState();
}

class _PopupDialogState extends State<_PopupDialog> {
  late FlutterTts flutterTts;
  late int currentIndex;
  late Timer? timer;
  late bool isAutoNextEnabled;

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    currentIndex = widget.currentIndex;
    isAutoNextEnabled = widget.isAutoNextEnabled;

    _speakDescription();
    if (isAutoNextEnabled) {
      timer = Timer.periodic(const Duration(seconds: 3), (Timer t) {
        _nextItem();
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> _speakDescription() async {
    final currentItem = widget.items[currentIndex];
    await flutterTts.setLanguage("EN-IN");
    await flutterTts.speak(currentItem.title);
    await flutterTts.speak(currentItem.description);
  }

  void _previousItem() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
        _speakDescription();
      }
    });
  }

  void _nextItem() {
    setState(() {
      if (currentIndex < widget.items.length - 1) {
        currentIndex++;
        _speakDescription();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentItem = widget.items[currentIndex];
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      content: Container(
        padding: EdgeInsets.zero,
        width: MediaQuery.of(context).size.width * 0.75,
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
            color: currentItem.backgroundColor,
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    currentItem.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: ConstantDimensions.heightMedium),
                  GestureDetector(
                    onTap: () {
                      AppFunctions().readName(currentItem.description);
                    },
                    child: SvgPicture.asset(
                      currentItem.iconAsset,
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.3,
                      alignment: Alignment.center,
                    ),
                  ),
                  const SizedBox(height: ConstantDimensions.heightMedium),
                  Text(
                    currentItem.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 28,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FloatingActionButton(
                        backgroundColor: appCustomColour,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        onPressed: _previousItem,
                        child: const Icon(
                          Icons.arrow_circle_left_outlined,
                          color: whiteCustom,
                          size: 40,
                        ),
                      ),
                      SizedBox(
                        width: ConstantDimensions.exceptions[0],
                      ),
                      FloatingActionButton(
                        backgroundColor: appCustomColour,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        onPressed: _nextItem,
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
      ),
    );
  }
}

class AtoZ extends StatefulWidget {
  const AtoZ({Key? key}) : super(key: key);

  @override
  State<AtoZ> createState() => _AtoZState();
}

class _AtoZState extends State<AtoZ> {
  bool isTimerEnabled = false;

  List<ItemData> items = AppConstants.alphabetItems;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appCustomColour,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: appCustomColour,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              '   A-Z',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Schyles',
                  fontSize: 30,
                  color: Colors.white),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ButtonStyle(
                    // ignore: deprecated_member_use
                    backgroundColor: MaterialStateProperty.all(
                      isTimerEnabled ? Colors.green : Colors.red,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      isTimerEnabled = !isTimerEnabled;
                    });
                  },
                  child: const Text(
                    'Auto',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
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
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: GridView.count(
            crossAxisCount: MediaQuery.of(context).size.width ~/ 200,
            childAspectRatio: 0.8,
            children: List.generate(
              items.length,
              (index) => ItemTile(
                index: index,
                items: items,
                isTimerEnabled: isTimerEnabled,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
