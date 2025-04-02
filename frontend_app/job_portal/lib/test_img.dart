import 'package:flutter/material.dart';

class TestImg extends StatelessWidget {
  const TestImg({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 90,
            height: 90,
            child: Image.network(
              'https://i.pinimg.com/736x/f8/45/68/f8456800ac55a50acda33ea6b9267e54.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
