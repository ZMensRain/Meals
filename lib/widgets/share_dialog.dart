import 'package:flutter/material.dart';
import 'package:meal_planner/model/meal.dart';

import 'package:share_plus/share_plus.dart';

class ShareDialog extends StatelessWidget {
  const ShareDialog(this.meal, {super.key});

  final Recipe meal;

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: const Text("Share in"),
      content: const Text("How should the units be formated for this share?"),
      actions: [
        ElevatedButton(
          onPressed: () async {
            final data = await meal.makePdf(MeasurementSystem.imperial);
            final file = XFile.fromData(
              data,
              name: "${meal.title} recipe",
              mimeType: "pdf",
            );

            var r = await Share.shareXFiles([file]);

            if (r.status != ShareResultStatus.unavailable) {
              if (context.mounted) {
                Navigator.pop(context);
                Navigator.pop(context);
              }
            }
          },
          child: const Text("Imperial"),
        ),
        ElevatedButton(
          onPressed: () async {
            final data = await meal.makePdf(MeasurementSystem.metric);
            final file = XFile.fromData(
              data,
              name: "${meal.title} recipe",
              mimeType: "pdf",
            );
            Share.shareXFiles([file]);
          },
          child: const Text("Metric"),
        ),
      ],
    );
  }
}
