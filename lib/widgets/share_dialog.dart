import 'package:flutter/material.dart';
import 'package:meal_planner/model/ingredient.dart';

class ShareDialog extends StatelessWidget {
  const ShareDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: const Text("Share in"),
      content: const Text("How should the units be formatted for this share?"),
      actions: [
        ElevatedButton(
          onPressed: () async {
            Navigator.pop(context, MeasurementSystem.imperial);
          },
          child: const Text("Imperial"),
        ),
        ElevatedButton(
          onPressed: () async {
            Navigator.pop(context, MeasurementSystem.metric);
          },
          child: const Text("Metric"),
        ),
      ],
    );
  }
}
