import 'package:children_app/landing_page.dart';
import 'package:children_app/pages/about.dart';
import 'package:children_app/pages/explore/drawingboard.dart';
import 'package:children_app/pages/explore/explore.dart';
import 'package:children_app/pages/explore/quiz.dart';
import 'package:children_app/pages/favorite.dart';
import 'package:children_app/pages/fruits.dart';
import 'package:children_app/pages/home.dart';
import 'package:children_app/pages/modules/animals.dart';
import 'package:children_app/pages/modules/atoz.dart';
import 'package:children_app/pages/modules/birds.dart';
import 'package:children_app/pages/modules/colours.dart';
import 'package:children_app/pages/modules/flowers.dart';
import 'package:children_app/pages/modules/numbers.dart';
import 'package:children_app/pages/modules/occupation.dart';
import 'package:children_app/pages/modules/parts.dart';
import 'package:children_app/pages/modules/planets.dart';
import 'package:children_app/pages/modules/seasons.dart';
import 'package:children_app/Routes/page_transtion.dart';
import 'package:children_app/Routes/route_constant.dart';
import 'package:flutter/material.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AllRoutesConstant.homeRoute:
        return slidePageRoute(const MyHomePage());

      case AllRoutesConstant.atozRoute:
        return slidePageRoute(const AtoZ());

      case AllRoutesConstant.animalRoute:
        return slidePageRoute(AnimalsPage());

      case AllRoutesConstant.numberRoute:
        return slidePageRoute(const NumbersPage());

      /// Body Part
      case AllRoutesConstant.partsRoute:
        return slidePageRoute(const PartsPage());

      case AllRoutesConstant.birdsRoute:
        return slidePageRoute(BirdsPage());

      case AllRoutesConstant.colourRoute:
        return slidePageRoute(const ColoursPage());

      case AllRoutesConstant.flowerRoute:
        return slidePageRoute(const FlowerPage());

      case AllRoutesConstant.fruitRoute:
        return slidePageRoute(FruitsPage());

      case AllRoutesConstant.seasonRoute:
        return slidePageRoute(const SeasonsPage());

      case AllRoutesConstant.solarRoute:
        return slidePageRoute(PlanetsPage());

      case AllRoutesConstant.aboutRoute:
        return slidePageRoute(const AboutPage());

      case AllRoutesConstant.occupationRoute:
        return slidePageRoute(OccupationPage());

//
//
      case '/drawingBoardPage':
        return slidePageRoute(const DrawingBoardPage());
//
//

      case AllRoutesConstant.favoriteRoute:
        return slidePageRoute(const FavoritePage());
      case AllRoutesConstant.quizRoute:
        return slidePageRoute(const Quiz());

      case AllRoutesConstant.landingRoute:
        return slidePageRoute(const LandingPage());
      case AllRoutesConstant.exploreRoute:
        return slidePageRoute(const ExplorePage());

// Bottom App BAr

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('No route found'),
            ),
          ),
        );
    }
  }
}
//  MyDrawer
