import 'package:boxfile/views/servicepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors.dart';
import '../widgets/homepagedrawer.dart';
import 'filespage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  TabController? _tabController;
  @override
  initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: const HomepageDrawer(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 0.4.h),
              child: Stack(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 2.w),
                      child: IconButton(
                        icon: const Icon(Icons.menu,
                            size: 28, color: Color(Colorz.oranch)),
                        onPressed: () {
                          return _key.currentState!.openDrawer();
                        },
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0.7.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Box",
                        style: GoogleFonts.nunito(
                            textStyle: GoogleFonts.leagueSpartan(
                          color: const Color(Colorz.blue),
                          // textStyle: Theme.of(context).textTheme.headline4,
                          fontSize: 23.sp,
                          fontWeight: FontWeight.w600,
                        )),
                      ),
                      Text(
                        "File",
                        style: GoogleFonts.nunito(
                            textStyle: GoogleFonts.leagueSpartan(
                          color: const Color(Colorz.oranch),
                          // textStyle: Theme.of(context).textTheme.headline4,
                          fontSize: 23.sp,
                          fontWeight: FontWeight.w600,
                        )),
                      )
                    ],
                  ),
                ),
              ]),
            ),
            Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: Padding(
                padding: EdgeInsets.only(
                    top: 1.5.h, left: 4.w, right: 4.w, bottom: 1.5.h),
                child: Container(
                  height: 4.4.h,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          // blurStyle: BlurStyle.inner,
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1.0,
                          blurRadius: 8.0,
                          offset: const Offset(0.0, 3.0))
                    ],
                    border: Border.all(color: Colors.white),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      25.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TabBar(
                      controller: _tabController,
                      // give the indicator a decoration (color and border radius)

                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          25.0,
                        ),
                        color: const Color(Colorz.blue),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      labelStyle: GoogleFonts.lato(
                          textStyle: GoogleFonts.leagueSpartan(
                        color: Colors.white,
                        // textStyle: Theme.of(context).textTheme.headline4,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      )),

                      tabs: const [
                        // first tab [you can add an icon using the icon property]
                        Tab(
                          text: 'Scan',
                        ),

                        // second tab [you can add an icon using the icon property]
                        Tab(
                          text: 'Files',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    // first tab bar view widget
                    ServicesPage(),

                    // second tab bar view widget
                    FilePage()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
