import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FormResNoty extends StatelessWidget {
  const FormResNoty({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              "assets/images/icons8-done.svg",
              height: 320,
            ),
            Text(
              "Successfyly",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
