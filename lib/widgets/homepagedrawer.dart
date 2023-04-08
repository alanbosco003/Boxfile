import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

class HomepageDrawer extends StatefulWidget {
  const HomepageDrawer({Key? key}) : super(key: key);

  @override
  State<HomepageDrawer> createState() => _HomepageDrawerState();
}

class _HomepageDrawerState extends State<HomepageDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Stack(children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                              color: Color(Colorz.lightblue),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset("assets/icons/Folder_icon.png"),
                          ),
                        ),
                      ]),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Science",
                              style: GoogleFonts.nunito(
                                // textStyle: GoogleFonts.spartan(
                                color: Colors.black,
                                // textStyle: Theme.of(context).textTheme.headline4,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Created on Monday, 03, 2021",
                              style: GoogleFonts.nunito(
                                  textStyle: GoogleFonts.leagueSpartan(
                                color: Colors.black,
                                // textStyle: Theme.of(context).textTheme.headline4,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              )),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                ListTile(
                  title: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color(Colorz.lightblue),
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // const Icon(Icons.volume_up),
                          const SizedBox(
                            width: 4,
                          ),
                          Text("Upgrade to premium",
                              style: GoogleFonts.nunito(
                                color: Colors.black,
                                // textStyle: Theme.of(context).textTheme.headline4,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              )),
                        ],
                      )),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color(Colorz.lightblue),
                        // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // const Icon(Icons.volume_up),
                          const SizedBox(
                            width: 4,
                          ),
                          Text("Email Us",
                              style: GoogleFonts.nunito(
                                color: Colors.black,
                                // textStyle: Theme.of(context).textTheme.headline4,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              )),
                        ],
                      )),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: const Color(Colorz.lightblue),
                          // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                          textStyle: GoogleFonts.nunito(
                            color: Colors.black,
                            // textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          )),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // const Icon(Icons.volume_up),
                          const SizedBox(
                            width: 4,
                          ),
                          Text("Write a review",
                              style: GoogleFonts.nunito(
                                color: Colors.black,
                                // textStyle: Theme.of(context).textTheme.headline4,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              )),
                        ],
                      )),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
              ],
            ),
          ),
          // const Spacer(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("Version 1.0.0",
                style: GoogleFonts.nunito(
                  color: Colors.black,
                  // textStyle: Theme.of(context).textTheme.headline4,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                )),
          ),
        ],
      ),
    );
  }
}
