import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

class EditpageDrawer extends StatefulWidget {
  const EditpageDrawer({Key? key}) : super(key: key);

  @override
  State<EditpageDrawer> createState() => _EditpageDrawerState();
}

class _EditpageDrawerState extends State<EditpageDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
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
                        borderRadius: BorderRadius.all(Radius.circular(40))),
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
                        "New File 1",
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
                    Text("Share Text",
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
                    Text("Download as PDF",
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
                onPressed: () {
                  Navigator.pop(context);
                  showbottomsheet();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // const Icon(Icons.volume_up),
                    const SizedBox(
                      width: 4,
                    ),
                    Text("Merge with other file",
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
                    Text("Read text",
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
                    Text("Change folder name",
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
                    Text("Delete file",
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
    );
  }

  void showbottomsheet() {
    showModalBottomSheet<void>(
      isScrollControlled: true,

      backgroundColor: Colors.white,
      // const Color(Colorz.blue),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 15),
                child: RichText(
                  text: TextSpan(
                    text: 'Select the file you wish to ',
                    style: GoogleFonts.nunito(
                      color: const Color(Colorz.blue),
                      // textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: ' merge',
                          style: GoogleFonts.nunito(
                            color: const Color(Colorz.oranch),
                            // textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          )),
                      const TextSpan(text: ' with'),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        showdialog(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 1, left: 20, right: 20),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6)),
                              border: Border.all(
                                  color: const Color(Colorz.oranch))),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Row(
                              children: [
                                Stack(children: [
                                  Container(
                                    height: 55,
                                    width: 55,
                                    decoration: const BoxDecoration(
                                        color: Color(Colorz.lightblue),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                          "assets/icons/Folder_icon.png"),
                                    ),
                                  ),
                                ]),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Folders",
                                        style: GoogleFonts.nunito(
                                            textStyle:
                                                GoogleFonts.leagueSpartan(
                                          color: Colors.black,
                                          // textStyle: Theme.of(context).textTheme.headline4,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        )),
                                      ),
                                      Text(
                                        "Created on Monday, 03, 2021",
                                        style: GoogleFonts.nunito(
                                            textStyle:
                                                GoogleFonts.leagueSpartan(
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
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  showdialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          "Merge file",
          style: GoogleFonts.nunito(
              textStyle: GoogleFonts.leagueSpartan(
            color: Colors.black,
            // textStyle: Theme.of(context).textTheme.headline4,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          )),
        ),
        content: Text(
          "Are you sure to merge with file name?",
          style: GoogleFonts.nunito(
              textStyle: GoogleFonts.leagueSpartan(
            color: Colors.black,
            // textStyle: Theme.of(context).textTheme.headline4,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          )),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: Text(
              "Cancel",
              style: GoogleFonts.nunito(
                  textStyle: GoogleFonts.leagueSpartan(
                color: const Color(Colorz.blue),
                // textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              )),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: Text(
              "OK",
              style: GoogleFonts.nunito(
                  textStyle: GoogleFonts.leagueSpartan(
                color: const Color(Colorz.oranch),
                // textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              )),
            ),
          ),
        ],
      ),
    );
  }
}
