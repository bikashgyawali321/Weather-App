// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _verticalPosition;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
          seconds: 4), //increasing duration will make the animation slow
    );
    _verticalPosition = Tween<double>(
      begin: -10,
      end: 100,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _animationController.repeat(reverse: true);
    Timer(Duration(seconds: 50), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'images/weather_image.jpg',
              fit: BoxFit.cover,
            ),
          ),
          AnimatedBuilder(
            animation: _verticalPosition,
            builder: (context, child) {
              return Positioned(
                top: 270 + _verticalPosition.value,
                left: 16,
                right: 16,
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.pink.withOpacity(0.9),
                        Colors.blue.withOpacity(0.6),
                        Colors.white.withOpacity(0.6),
                        Colors.yellow.withOpacity(0.6)
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'We Show Weather For You',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'We provide you with up-to-date weather information so you can plan your day accordingly.',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: Container(
        width: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22.0),
            gradient: LinearGradient(colors: [
              Colors.brown.withOpacity(0.6),
              Colors.yellow.withOpacity(0.5),
            ])),
        child: TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/home');
          },
          child: Text('SKIP',
              style: GoogleFonts.abhayaLibre(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
