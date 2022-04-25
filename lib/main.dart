import 'dart:async';
import 'package:flutter/material.dart';

import 'menu/menuscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bitcoin Currency Converter',
      theme: ThemeData(primarySwatch: Colors.red),
      home: const MenuScreen(title: "Crypto"),
    );
  }
}

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key, required String title}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late double screenHeight, screenWidth;
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 10),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (content) => MainScreen())));
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
          Padding(
            padding: const EdgeInsets.all(64.0),
            child: Image.asset('assets/images/bitcoin.png'),
          ),
          const Text(
            "Crypto Converter",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const CircularProgressIndicator(),
          const Text("Version 0.1",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )),
        ])));
  }
}
