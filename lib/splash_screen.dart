import 'dart:async';
import 'package:flutter/material.dart';
import 'package:splash_screen/home_page.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName='/splash_screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      const Duration(seconds: 5),
          () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: Center(
        child: Image.asset(
          'assets/bg.png',
          height: 200,
        ),
      ),
    );
  }
}
