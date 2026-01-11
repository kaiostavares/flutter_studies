import 'package:flutter/material.dart';
import 'views/home_page.dart';

void main() {
  runApp(const RockInRio());
}

class RockInRio extends StatelessWidget {
  const RockInRio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rock in Rio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const HomePage(),
    );
  }
}
