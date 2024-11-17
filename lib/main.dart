import 'package:flutter/material.dart';
import 'food_screen.dart';

void main() {
  runApp(FoodApp());
}

class FoodApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FoodScreen(),
    );
  }
}
