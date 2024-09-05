import 'package:children_app/Routes/route_constant.dart';
import 'package:children_app/pages/explore/drawingboard.dart';
import 'package:children_app/utils/App_custom.dart';
import 'package:children_app/utils/text_custam.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              gradient1,

              gradient2

              // Color(0xffa1c4fd),

              //  Color(0xff56a5b5)
            ], // Start and end colors
            begin: Alignment.topLeft, // Gradient direction start
            end: Alignment.bottomRight, // Gradient direction end
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                color: appCustomColour,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      const CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage("assets/images/dp.png"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Textcustam(
                        text: "kids Learning App  ",
                        col: whiteCustom,
                        size: 20,
                        weight: FontWeight.w700,
                      ),
                      Textcustam(
                        text: "Made by  AbdulRehman",
                        size: 12,
                        weight: FontWeight.w700,
                        col: Colors.white,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              _buildListTile(
                icon: Icons.cloud,
                title: "Seasons",
                onTap: () {
                  Navigator.pushNamed(context, AllRoutesConstant.seasonRoute);
                },
                context: context,
              ),

              _buildListTile(
                icon: Icons.draw_rounded,
                title: "Drawing Board",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DrawingBoardPage()));
                },
                context: context,
              ),
              _buildListTile(
                icon: Icons.work,
                title: "Occupations",
                onTap: () {
                  Navigator.pushNamed(
                      context, AllRoutesConstant.occupationRoute);
                },
                context: context,
              ),
              _buildListTile(
                icon: Icons.sunny,
                title: "Solar System",
                onTap: () {
                  Navigator.pushNamed(context, AllRoutesConstant.solarRoute);
                },
                context: context,
              ),
              _buildListTile(
                icon: Icons.palette,
                title: "Colours",
                onTap: () {
                  Navigator.pushNamed(context, AllRoutesConstant.colourRoute);
                },
                context: context,
              ),
              _buildListTile(
                icon: Icons.local_florist,
                title: "Flowers",
                onTap: () {
                  Navigator.pushNamed(context, AllRoutesConstant.flowerRoute);
                },
                context: context,
              ),

              Image.asset('assets/images/gifrun.gif') //hello.gif
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 45,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: appCustomColour)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: whiteCustom,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(title, style: TextStyle(color: whiteCustom)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildListTileSVG({
  //   required BuildContext context,
  //   required String icon,
  //   required String title,
  //   required VoidCallback onTap,
  // }) {
  //   return ListTile(
  //     leading: SvgPicture.asset(
  //       icon,
  //       width: 24,
  //       height: 24,
  //     ),
  //     title: Text(
  //       title,
  //       style: Theme.of(context).textTheme.bodyLarge,
  //     ),
  //     onTap: onTap,
  //   );
  // }
}
