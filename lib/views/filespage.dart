import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors.dart';
import '../model/bookmodel.dart';
import '../model/database.dart';
import 'editfilepage.dart';

class FilePage extends StatefulWidget {
  const FilePage({Key? key}) : super(key: key);

  @override
  State<FilePage> createState() => _FilePageState();
}

class _FilePageState extends State<FilePage> {
  late var getfolders;
  DatabaseDB mydatabase = DatabaseDB();
  @override
  void initState() {
    getfolders = mydatabase.showbook();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 2.h,
        left: 4.w,
        right: 4.w,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  "Folders",
                  style: GoogleFonts.nunito(
                      textStyle: GoogleFonts.leagueSpartan(
                    color: Colors.black,
                    // textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 0),
                child: IconButton(
                  icon: const Icon(Icons.refresh,
                      size: 28, color: Color(Colorz.oranch)),
                  onPressed: () {
                    setState(() {
                      getfolders = mydatabase.showbook();
                    });
                    Fluttertoast.showToast(
                        msg: "Folder Refreshed",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: const Color(Colorz.lightblue),
                        textColor: Colors.black,
                        fontSize: 12.sp);
                    // return _key.currentState!.openDrawer();
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder<List<Book>>(
              future: getfolders,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
  }

  Widget showfiles(AsyncSnapshot snapshot) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditfilePage(
                        snapshot.data[index].gettitle(),
                        snapshot.data[index].getcontent(),
                        false,
                        snapshot.data[index].getid(),
                        snapshot.data[index].getdate())),
              );
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

  Widget showconnectionloading() {
    return const SizedBox(
      child: CircularProgressIndicator(),
    );
  }
}
