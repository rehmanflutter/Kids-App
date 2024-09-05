// ignore: unused_import
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:children_app/Routes/route_constant.dart';
import 'package:children_app/utils/assets_path.dart';
import 'package:children_app/utils/text_custam.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// ignore: depend_on_referenced_packages
import '../widgets/drawer.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff478890),
      body: Container(
        height: double.infinity, //Backgroundg.png    bg.png
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/Backgroundg.png'),
                fit: BoxFit.cover)),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Builder(builder: (context) {
                        return GestureDetector(
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: Color(0xff478890),
                                // border: Border.all(
                                //   color: Color(0xff478890),
                                // ),
                                borderRadius: BorderRadius.circular(6)),
                            child: const Icon(Icons.menu_sharp,
                                // size: 30,
                                color: Colors.white),
                          ),
                        );
                      }),
                      const Text(
                        'Kids  Learning',
                        style: TextStyle(
                          fontSize: 26,
                          fontFamily: 'Schyles',
                          fontWeight: FontWeight.w700,
                          color: Color(0xff478890),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AllRoutesConstant.aboutRoute);
                        },
                        child: SvgPicture.asset(
                          'assets/images/iButton.svg',
                          height: 45,
                        ),
                      )
                      //  Icon(Icons.info_outlined)
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset('assets/images/Vecto.png'),
                  const SizedBox(
                    height: 20,
                  ),
                  categoryCard(
                    context: context,
                    title: "ALPHABETS",
                    image: AssetsPath.getAlphabetImage(Alphabets.alphabets),
                    shortDescription:
                        "Learn A to Z with pronunciation and an example",
                    route: AllRoutesConstant.atozRoute,
                    index: 0,
                  ),
                  categoryCard(
                    context: context,
                    title: "NUMBERS", // Added this block for "NUMBERS"
                    image: 'assets/images/numbers/numbers.jpg',
                    shortDescription: "Learn numbers and their pronunciations.",
                    route: AllRoutesConstant.numberRoute,
                    index: 7,
                  ),
                  categoryCard(
                    context: context,
                    title: "ANIMALS",
                    image: AssetsPath.getAnimalImage(Animals.animals),
                    shortDescription: "Learn about animals and their voices",
                    route: AllRoutesConstant.animalRoute,
                    index: 1,
                  ),
                  categoryCard(
                    context: context,
                    title: "BODY PARTS",
                    image: AssetsPath.getBodyImage(Body.body),
                    shortDescription:
                        "Know about body parts and their pronunciation.",
                    route: AllRoutesConstant.partsRoute,
                    index: 2,
                  ),
                  categoryCard(
                    context: context,
                    title: "BIRDS",
                    image: AssetsPath.getBirdImage(Birds.birds),
                    shortDescription: "Look out for Birds with their sounds.",
                    route: AllRoutesConstant.birdsRoute,
                    index: 3,
                  ),
                  categoryCard(
                    context: context,
                    title: "COLOURS",
                    image: AssetsPath.getColoursImage(ColorImages.colorsCover),
                    shortDescription: "Explore and learn about the colours!",
                    route: AllRoutesConstant.colourRoute,
                    index: 4,
                  ),
                  categoryCard(
                    context: context,
                    title: "FLOWERS",
                    image: AssetsPath.getFlowerImage(Flowers.flowerBanner),
                    shortDescription: "Explore beauty of nature flowers.",
                    route: AllRoutesConstant.flowerRoute,
                    index: 5,
                  ),
                  categoryCard(
                    context: context,
                    title: "FRUITS & VEGETABLES",
                    image: 'assets/fruitsVeges/cover.jpg',
                    shortDescription:
                        "Explore and learn about Fruits and Vegetables!",
                    route: AllRoutesConstant.fruitRoute,
                    index: 6,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      drawer: const MyDrawer(),
    );
  }

//  Fun to show
  Widget categoryCard({
    required BuildContext context,
    required String title,
    required String image,
    required String shortDescription,
    required String route,
    required int index,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage('assets/images/board.gif'), fit: BoxFit.fill),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, route);
              // Future.delayed(const Duration(milliseconds: 300), () {

              // });
            },
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  height: 150,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 150,
                      child: Text(
                        title,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff478890),
                          // fontFamily: 'Schyles',
                        ),
                      ),
                    ),
                    SizedBox(
                        width: 150,
                        child: Textcustam(
                          text: shortDescription,
                          size: 12,
                          col: Color(0xff717575),
                        )),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
