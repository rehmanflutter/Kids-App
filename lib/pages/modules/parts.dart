import 'package:children_app/utils/App_custom.dart';
import 'package:children_app/utils/assets_path.dart';
import 'package:children_app/utils/constants.dart';
import 'package:children_app/utils/functions.dart';
import 'package:children_app/utils/responsive_screen_provider.dart';
import 'package:children_app/utils/text_custam.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../utils/const_dimensions.dart';
import 'parts_test.dart';

class PartsPage extends StatefulWidget {
  const PartsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<PartsPage> createState() => _PartsPagePageState();
}

class _PartsPagePageState extends State<PartsPage> {
  final CardSwiperController controller = CardSwiperController();
  late FlutterTts flutterTts;

  late List<PartsPageCard> cards;
  List<int> previousIndices = [];
  int topCardIndex = 0;

  @override
  void initState() {
    flutterTts = FlutterTts();

    super.initState();
    cards = generateCards();
    AppFunctions().readName(cards[topCardIndex].name);
  }

  List<PartsPageCard> generateCards() {
    return AppConstants.candidates.asMap().entries.map((entry) {
      final index = entry.key;
      final name = entry.value;
      var color = AppFunctions().getCardColor(index);
      return PartsPageCard(name: name, color: color);
    }).toList();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _navigateToPartsTestPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PartsTestPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff56a5b5),
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
              '   ${AppConstants.parts}',
              style: TextStyle(fontWeight: FontWeight.bold, color: whiteCustom),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.assignment),
            onPressed: () {
              _navigateToPartsTestPage(context);
            },
          ),
        ],
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
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ResponsiveScreenProvider.isMobileScreen(context)
                    ? CardSwiper(
                        controller: controller,
                        cardsCount: cards.length,
                        onSwipe: (prevIndex, currentIndex, direction) {
                          setState(() {
                            previousIndices.add(topCardIndex);
                            topCardIndex = currentIndex ?? 0;
                            AppFunctions().readName(cards[topCardIndex].name);
                          });
                          return true;
                        },
                        onUndo: _onUndo,
                        numberOfCardsDisplayed: 3,
                        backCardOffset: const Offset(40, 40),
                        padding: const EdgeInsets.all(24.0),
                        cardBuilder: (
                          context,
                          index,
                          horizontalThresholdPercentage,
                          verticalThresholdPercentage,
                        ) =>
                            cards[index],
                      )
                    : Center(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: MediaQuery.of(context).size.height * 0.6,
                          child: CardSwiper(
                            controller: controller,
                            cardsCount: cards.length,
                            onSwipe: (prevIndex, currentIndex, direction) {
                              setState(() {
                                previousIndices.add(topCardIndex);
                                topCardIndex = currentIndex ?? 0;
                              });
                              return true;
                            },
                            onUndo: _onUndo,
                            numberOfCardsDisplayed: 3,
                            backCardOffset: const Offset(40, 40),
                            padding: const EdgeInsets.all(24.0),
                            cardBuilder: (
                              context,
                              index,
                              horizontalThresholdPercentage,
                              verticalThresholdPercentage,
                            ) =>
                                cards[index],
                          ),
                        ),
                      ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Textcustam(
                          text: cards[topCardIndex].name,
                          size: 45,
                          weight: FontWeight.bold),
                      const SizedBox(
                        width: ConstantDimensions.widthExtraLarge * 3,
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.volume_up,
                              // color: Colors.black,
                              size: 40,
                            ),
                            onPressed: () {
                              AppFunctions().readName(cards[topCardIndex].name);
                            },
                          ),
                          const SizedBox(
                            width: ConstantDimensions.widthExtraLarge / 2,
                          ),
                          IconButton(
                            onPressed: controller.undo,
                            icon: const Icon(
                              Icons.rotate_left,
                              // color: Colors.black,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: ConstantDimensions.heightSmall),
                      SizedBox(height: ConstantDimensions.exceptions[2]),
                      Text(
                        AppFunctions().getDescription(cards[topCardIndex].name),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff717575),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _onUndo(
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  ) {
    if (previousIndices.isNotEmpty) {
      setState(() {
        topCardIndex = previousIndices.removeLast();
      });
    }

    return true;
  }
}

class PartsPageCard extends StatelessWidget {
  final String name;
  final Color color;

  const PartsPageCard({
    Key? key,
    required this.name,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 158, 155, 155),
          width: 2.0,
        ),
      ),
      child: Card(
        color: color,
        child: SizedBox(
          width: ConstantDimensions.widthExtraLarge * 6,
          height: ConstantDimensions.heightExtraLarge * 6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SvgPicture.asset(
                  AssetsPath.getBodyImage("$name.svg"),
                  width: ConstantDimensions.widthExtraLarge * 5,
                  height: ConstantDimensions.heightExtraLarge * 5,
                ),
              ),
              const SizedBox(height: ConstantDimensions.heightSmall),
            ],
          ),
        ),
      ),
    );
  }
}
