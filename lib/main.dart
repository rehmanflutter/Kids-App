import 'package:children_app/favorite_page_provider.dart';
import 'package:children_app/pages/home.dart';
import 'package:children_app/Routes/routes.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

//  Version   3.22.0

DateTime? currentBackPressTime;
bool visitedGettingStartedPageOnceBool = false; //to store the value of

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  visitedGettingStartedPageOnceBool =
      prefs.getBool('visitedGettingStartedPageOnce') ??
          false; //if its is null i.e first time then set to false

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => FavouriteScreenProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learn APPs',
      theme: ThemeData.light(),
      home: MyHomePage(),
      //  visitedGettingStartedPageOnceBool
      //     ? const MainHome()
      //     : const LandingPage(), //if page opened for first time , show landing page (getting started page), else show home page
      onGenerateRoute: Routers.generateRoute,
    );
  }
}
