import 'package:flutter/material.dart';
import 'package:progress_tracker/progress_tracker.dart';
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
          child: StepTracker(
        dotSize: 0,
        circleIconSize: 20,
        showIcon: false,
        selectedColor: Colors.green,
        unSelectedColor: Colors.red,
        stepTrackerType: StepTrackerType.indexedHorizontal,
        pipeSize: 60,
        steps: [
          Steps(
            title: "Applied",
            titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            state: TrackerState.complete,
          ),
          // Steps(title: "Progress", state: TrackerState.complete),
          Steps(
            title: "Result",
            state: TrackerState.none,
            titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      )),
    );
  }
}
