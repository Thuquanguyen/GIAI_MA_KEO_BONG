import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gmsh/main_screen.dart';

import 'constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var timer;

  @override
  void initState() {
    saveData(false);
    timer = Timer(
        const Duration(seconds: 2),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MainScreen())));
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          color: const Color.fromRGBO(8, 91, 52, 1),
          child: Column(
            children: [
              Image.asset(
                'assets/images/img_logo.png',
                width: 250,
                height: 250,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'diễn đàn giải mã kèo bóng'.toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white,fontSize: 20),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          )),
    );
  }
}
