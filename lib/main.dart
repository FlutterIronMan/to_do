import 'package:flutter/material.dart';
import 'package:to_do/pages/home.dart';
import 'package:to_do/pages/main_screen.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => MainScreen(),
          '/todo': (context) => Home(),
        },
      ),
    );
