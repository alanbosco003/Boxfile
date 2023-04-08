import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors.dart';
import '../model/bookmodel.dart';
import '../model/database.dart';
import '../widgets/loading.dart';

class EditfilePage extends StatefulWidget {
  final String title;
  final String content;
  final bool? isScan;
  final String? id;
  final String? date;

  const EditfilePage(
    this.title,
    this.content,
    this.isScan,
    this.id,
    this.date,
  );

  @override
  State<EditfilePage> createState() => _EditfilePageState();
}

class _EditfilePageState extends State<EditfilePage> {
  late bool hasFileName;
  String? textx;
  DatabaseDB mydatabase = DatabaseDB();
  bool? isScan;
  String? foldertitle;
  int? folderID;
  bool loading = false;
  late var getfolders;
  FlutterTts flutterTts = FlutterTts();
  bool playingaudio = false;

  @override
  void initState() {
    DatabaseDB mydatabase = DatabaseDB();
    getfolders = mydatabase.showbook();
    isScan = widget.isScan;
    if (isScan == true) {
      hasFileName = false;
    } else {
      hasFileName = true;
    }
    folderID = int.parse(widget.id!);
    assert(folderID is int);
    _controller.text = widget.content;
    foldertitle = widget.title;
    date = widget.date;

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? date;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  // String data = widget.text;
  final TextEditingController _controller = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: Drawer(
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
                          foldertitle!,
                          style: GoogleFonts.nunito(
                            // textStyle: GoogleFonts.spartan(
                            color: Colors.black,
                            // textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Created on " + date.toString(),
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
                  onPressed: () {
                    Share.share(_controller.text);
                  },
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
                  onPressed: () async {
                    File file = File(await getfilepath()); // 1
                    var filepath = file.path;
                    file.writeAsString(_controller.text).then((value) {
                      Fluttertoast.showToast(
                          msg: "File Downloaded at $filepath",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: const Color(Colorz.lightblue),
                          textColor: Colors.black,
                          fontSize: 12.sp);
                    }); // 2

                    // var filepath = await getfilepath();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // const Icon(Icons.volume_up),
                      const SizedBox(
                        width: 4,
                      ),
                      Text("Download file",
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
                  onPressed: () {
                    changefoldername();
                  },
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
            isScan!
                ? Container()
                : ListTile(
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
                        onPressed: () async {
                          deletefiledialog();
                        },
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
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(children: [
            loading
                ? Padding(
                    padding: EdgeInsets.only(top: 50.h),
                    child: MyAppCiricleProgress("Saving"),
                  )
                : Container(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 1.h),
                  child: Stack(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Icon(Icons.arrow_back,
                                size: 28, color: Color(Colorz.oranch)),
                          ),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Box",
                                style: GoogleFonts.nunito(
                                  color: const Color(Colorz.blue),
                                  // textStyle: Theme.of(context).textTheme.headline4,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                )),
                            Text(
                              "File",
                              style: GoogleFonts.nunito(
                                  textStyle: GoogleFonts.leagueSpartan(
                                color: const Color(Colorz.oranch),
                                // textStyle: Theme.of(context).textTheme.headline4,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                              )),
                            )
                          ],
                        ),
                        const Spacer(),
                        Padding(
                          padding: EdgeInsets.only(right: 4.w),
                          child: IconButton(
                            icon: const Icon(Icons.settings,
                                size: 28, color: Color(Colorz.oranch)),
                            onPressed: () {
                              return _key.currentState!.openDrawer();
                            },
                          ),
                        )
                      ],
                    ),
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.5.h, left: 4.w),
                  child: Row(
                    children: [
                      Stack(children: [
                        Container(
                          height: 6.2.h,
                          width: 6.2.h,
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
                        padding: EdgeInsets.only(left: 1.8.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              foldertitle!,
                              style: GoogleFonts.nunito(
                                // textStyle: GoogleFonts.spartan(
                                color: Colors.black,
                                // textStyle: Theme.of(context).textTheme.headline4,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Created on " + date.toString(),
                              style: GoogleFonts.nunito(
                                  textStyle: GoogleFonts.leagueSpartan(
                                color: Colors.black,
                                // textStyle: Theme.of(context).textTheme.headline4,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w400,
                              )),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(2.h),
                  child: Container(
                    // height: 100,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: const Color(Colorz.oranch))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        controller: _controller,
                        maxLines: null,
                        decoration: const InputDecoration.collapsed(
                          hintText: "Nothing inside the folder",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ]),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(1.8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 5.7.h,
              width: 38.w,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(Colorz.blue),
                  ),
                  onPressed: () async {
                    if (isScan == true) {
                      if (hasFileName == false) {
                        await givefilename();
                      }
                      if (hasFileName == true) {
                        setState(() {
                          loading = true;
                        });
                        folderID = await mydatabase
                            .insertBook(Book(
                                created: date,
                                title: foldertitle,
                                content: _controller.text))
                            .then((value) {
                          Fluttertoast.showToast(
                              msg: "Folder saved",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: const Color(Colorz.lightblue),
                              textColor: Colors.black,
                              fontSize: 12.sp);
                        });
                        setState(() {
                          isScan = false;
                          loading = false;
                        });
                        Navigator.pop(context);
                      }
                    } else {
                      await mydatabase
                          .updateBook(Book(
                            id: folderID,
                            created: date,
                            title: foldertitle,
                            content: _controller.text,
                          ))
                          .then((value) => Fluttertoast.showToast(
                              msg: "Folder updated",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: const Color(Colorz.lightblue),
                              textColor: Colors.black,
                              fontSize: 12.sp));
                      // await
                    }
                    // var books = await mydatabase.showbook();
                    // var booklength = books.length;
                    // print(booklength);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      isScan!
                          ? const Icon(Icons.file_download)
                          : const Icon(Icons.update),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(isScan! ? "Save File" : "Update",
                          style: GoogleFonts.nunito(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  )),
            ),
            SizedBox(
              width: 1.8.w,
            ),
            SizedBox(
              height: 5.7.h,
              width: 38.w,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(Colorz.oranch),
                  ),
                  onPressed: () async {
                    if (!playingaudio) {
                      setState(() {
                        playingaudio = true;
                      });
                      await flutterTts.speak(_controller.text);
                    } else {
                      setState(() {
                        playingaudio = false;
                      });
                      await flutterTts.speak("");
                    }
                    // await flutterTts.setPitch(100.0);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.volume_up),
                      const SizedBox(
                        width: 4,
                      ),
                      !playingaudio
                          ? Text("Play Voice",
                              style: GoogleFonts.nunito(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ))
                          : Text("Stop voice",
                              style: GoogleFonts.nunito(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ))
                    ],
                  )),
            )
          ],
        ),
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
                child: FutureBuilder<List<Book>>(
                  future: getfolders,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      return showfiles(snapshot);
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return showconnectionloading();
                    }
                    if (snapshot.connectionState != ConnectionState.done) {
                      return showfiles(snapshot);
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  mergshowdialog(BuildContext context) {
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

  deletefiledialog() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          "Delete file",
          style: GoogleFonts.nunito(
              textStyle: GoogleFonts.leagueSpartan(
            color: Colors.black,
            // textStyle: Theme.of(context).textTheme.headline4,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          )),
        ),
        content: Text(
          "Are you sure to delete this $foldertitle?",
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
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            },
            // onPressed: () {Navigator.pop(context, 'Cancel')}
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
            onPressed: () async {
              await mydatabase.deleteBook(folderID);
              Navigator.pop(context, 'Cancel');
              Navigator.pop(context);
              Navigator.pop(context);
            },
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

  mergefile(String getid, getdate, gettitle, getcontent) {
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
          "Are you sure to merge with $gettitle?",
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
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            },
            // onPressed: () {Navigator.pop(context, 'Cancel')}
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
            onPressed: () async {
              var newfolderID = int.parse(getid);
              assert(newfolderID is int);
              await mydatabase
                  .updateBook(Book(
                    id: newfolderID,
                    created: getdate,
                    title: gettitle,
                    content: getcontent + "\n" + _controller.text,
                  ))
                  .then((value) => Fluttertoast.showToast(
                      msg: "Folder Merged",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: const Color(Colorz.lightblue),
                      textColor: Colors.black,
                      fontSize: 12.sp));
              Navigator.pop(context, 'Cancel');
            },
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

  Future givefilename() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          "Give the file a name",
          style: GoogleFonts.nunito(
              textStyle: GoogleFonts.leagueSpartan(
            color: Colors.black,
            // textStyle: Theme.of(context).textTheme.headline4,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          )),
        ),
        content: TextField(
          onChanged: (value) {
            foldertitle = value.trim();
          },
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
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
            // onPressed: () {Navigator.pop(context, 'Cancel')}
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
            onPressed: () async {
              if (foldertitle != "" || foldertitle != "New File") {
                hasFileName = true;
                setState(() {});
              }
              Navigator.pop(context);
            },
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

  Widget showconnectionloading() {
    return const SizedBox(
      child: CircularProgressIndicator(),
    );
  }

  Widget showfiles(AsyncSnapshot snapshot) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
      child: ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          // Book data = snapshot.data[index];
          // print(data.getdate() + "from snapshot");
          return GestureDetector(
            onTap: () {
              mergefile(
                snapshot.data[index].getid(),
                snapshot.data[index].getdate(),
                snapshot.data[index].gettitle(),
                snapshot.data[index].getcontent(),
              );
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => EditfilePage(
              //           snapshot.data[index].gettitle(),
              //           snapshot.data[index].getcontent(),
              //           false,
              //           snapshot.data[index].getid(),
              //           snapshot.data[index].getdate())),
              // );
            },
            child: Padding(
              padding: EdgeInsets.only(
                top: 1.2.h,
              ),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    border: Border.all(color: const Color(Colorz.oranch))),
                child: Padding(
                  padding: EdgeInsets.all(0.8.h),
                  child: Row(
                    children: [
                      Stack(children: [
                        Container(
                          height: 6.5.h,
                          width: 6.5.h,
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
                              snapshot.data[index].gettitle(),
                              style: GoogleFonts.nunito(
                                  textStyle: GoogleFonts.leagueSpartan(
                                color: Colors.black,
                                // textStyle: Theme.of(context).textTheme.headline4,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              )),
                            ),
                            Text(
                              "Created on " + snapshot.data[index].getdate(),
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
              ),
            ),
          );
        },
      ),
    );
  }

  Future changefoldername() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          "Give the file a name",
          style: GoogleFonts.nunito(
              textStyle: GoogleFonts.leagueSpartan(
            color: Colors.black,
            // textStyle: Theme.of(context).textTheme.headline4,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          )),
        ),
        content: TextField(
          onChanged: (value) {
            foldertitle = value.trim();
          },
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
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
            // onPressed: () {Navigator.pop(context, 'Cancel')}
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
            onPressed: () async {
              setState(() {
                foldertitle;
              });
              await mydatabase
                  .updateBook(Book(
                    id: folderID,
                    created: date,
                    title: foldertitle,
                    content: _controller.text,
                  ))
                  .then((value) => Fluttertoast.showToast(
                      msg: "File name changed",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: const Color(Colorz.lightblue),
                      textColor: Colors.black,
                      fontSize: 12.sp));
              Navigator.pop(context, 'Cancel');
              // if (foldertitle != "" || foldertitle != "New File") {
              //   hasFileName = true;
              //   setState(() {});
              // }
              // Navigator.pop(context);
            },
            child: Text(
              "Change name",
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

  Future<String> getfilepath() async {
    Directory appDocumentsDirectory =
        await getApplicationDocumentsDirectory(); // 1
    String appDocumentsPath = appDocumentsDirectory.path; // 2
    String filePath = '$appDocumentsPath/$foldertitle.txt'; // 3

    return filePath;
  }
}
