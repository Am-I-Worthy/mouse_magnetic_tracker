import 'package:flutter/material.dart';

import 'dart:html' as html;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mouse Magnetic Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double dx = 0.0;
  double dy = 0.0;

  bool isOut = true;

  @override
  void initState() {
    html.document.documentElement!.addEventListener('mouseleave', (event) {
      setState(() {
        isOut = true;
      });
    });
    html.document.documentElement!.addEventListener('mouseenter', (event) {
      setState(() {
        isOut = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MouseRegion(
          onHover: (event) {
            setState(() {
              dx = event.localPosition.dx;
              dy = event.localPosition.dy;
            });
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 400),
          top: dy,
          left: dx,
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            height: isOut ? 0.0 : 9.0,
            width: isOut ? 0.0 : 9.0,
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
      ],
    );
  }
}
