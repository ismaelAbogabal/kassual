import 'package:flutter/material.dart';

class StepWidget extends StatelessWidget {
  final int currentStep;
  final int step;
  final Widget text;

  const StepWidget({
    Key key,
    this.step,
    this.currentStep,
    this.text = const Text(""),
  }) : super(key: key);

  bool get done => currentStep > step;
  bool get semiDone => currentStep >= step;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: Divider(
              thickness: 3,
              color: semiDone ? Colors.greenAccent : Colors.black,
            ),
          ),
        ),
        CircleAvatar(
          backgroundColor: done
              ? Colors.greenAccent
              : semiDone
                  ? Colors.greenAccent[100]
                  : Colors.grey[200],
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: text,
            ),
          ),
          radius: 20,
        ),
      ],
    );
  }
}
