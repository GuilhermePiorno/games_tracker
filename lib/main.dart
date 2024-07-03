import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(GamesTrackerApp());
}

class GamesTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Games Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
