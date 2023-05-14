import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    asyncMethod();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body:  Center(
          child: AnimatedTextKit(
            animatedTexts: [
              ColorizeAnimatedText(
                "Task",
                textAlign: TextAlign.center,
                textStyle: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                ),
                colors:  [
                  Colors.blueGrey,
                  Colors.blue,
                  Colors.lightBlue
                ],
              ),
            ],
            isRepeatingAnimation: true,
          ),
        )
    );
  }
  asyncMethod() async{
    Timer(const Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => const TodoPage()
        )
        )
    );
  }
}


