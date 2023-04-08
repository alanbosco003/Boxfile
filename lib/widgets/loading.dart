import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors.dart';

class MyAppCiricleProgress extends StatelessWidget {
  String text;
  MyAppCiricleProgress(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      height: 12.2.h,
      width: 12.2.h,
      decoration: const BoxDecoration(
          color: Color(Colorz.lightblue),
          borderRadius: BorderRadius.all(Radius.circular(14))),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(
                color: Color(Colorz.blue),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              text,
              style: GoogleFonts.nunito(
                  textStyle: GoogleFonts.leagueSpartan(
                color: const Color(Colorz.blue),
                // textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              )),
            )
          ],
        ),
      ),
    ));
  }
}
