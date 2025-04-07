import 'package:flutter/material.dart';
import 'package:step_progress/step_progress.dart';
// import 'package:progress_tracker/progress_tracker.dart';
// import 'package:progress_tracker/progress_tracker.dart';
import 'package:step_tracker/step_tracker.dart';

// import 'package:step_progress/step_progress.dart';
class TestProgessTracker extends StatelessWidget {
  const TestProgessTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: StepProgress(
          onStepChanged: (currentIndex) {},
          key: key,
          width: 200,
          // height: 50,
          controller: StepProgressController(initialStep: 0, totalStep: 2),
          style: StepProgressStyle(
              valueColor: Colors.green,
              tickColor: Colors.white,
              strokeColor: Theme.of(context).primaryColor,
              defaultColor: Theme.of(context).primaryColor
              // backgroundColor: Theme.of(context).primaryColor,
              ),
        ),
      )),
    );
  }
}
