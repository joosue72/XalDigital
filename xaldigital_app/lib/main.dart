// @dart=2.9

import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'UI/Menu_Principal.dart';

Future<void> main() async {
  
   WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) =>  menuPrincipal())));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedTextKit(
              animatedTexts: [
                WavyAnimatedText('NationApps',
                    textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 45,
                        fontWeight: FontWeight.w800)),
              ],
              isRepeatingAnimation: false,
              totalRepeatCount: 10,
              pause: const Duration(milliseconds: 1000),
            ),
            Container(
                height: 150,
                width: 150,
                alignment: Alignment.center,
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * .8,
                    height: MediaQuery.of(context).size.height * .8,
                    child: Image.network(
                      'https://media.baamboozle.com/uploads/images/58841/1620346981_625817_gif-url.gif',
                    )))
          ]),
    ));
  }
}
