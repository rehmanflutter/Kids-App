import 'package:children_app/utils/text_custam.dart';
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback fun;
  final Color? col;
  final Color? textcolor;
  final Color? backcol;
  final bool? loading;
  final double? width;
  RoundButton(
      {required this.title,
      required this.fun,
      this.col,
      this.textcolor = Colors.white,
      this.loading = false,
      this.backcol = const Color(0xff8434FC),
      this.width});
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Container(
      height: 48, //media.height * 0.07,
      width: width,
      child: ElevatedButton(
        onPressed: fun,
        child: Center(
          child: loading == true
              ? CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  color: Colors.white,
                )
              : Textcustam(
                  text: title,
                  col: textcolor,
                  size: 16,
                  weight: FontWeight.w500,
                ),
        ),
        style: ElevatedButton.styleFrom(
            // elevation: 5,
            // shadowColor: Colors.blue.shade300,
            backgroundColor: backcol,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
