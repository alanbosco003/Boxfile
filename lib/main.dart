import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:boxfile/views/homepage.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'model/database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseDB mydatabase = DatabaseDB();
  await mydatabase.bookdb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: AnimatedSplashScreen(
            splash: 'assets/icons/logobig.jpg',
            nextScreen: const HomePage(),
            splashTransition: SplashTransition.rotationTransition,
            // pageTransitionType: PageTransitionType.scale,
          ));
    });
  }
}
