import 'package:flutter/material.dart';

import 'package:share_plus/share_plus.dart';

class ShareDialog extends StatelessWidget {
  const ShareDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: const Text("Share in"),
      content: const Text("How should the units be formated for this share?"),
      actions: [
        ElevatedButton(
          onPressed: () {},
          child: const Text("Imperial"),
        ),
        ElevatedButton(
          onPressed: () {
            Share.share("METRIC IS BEST");
          },
          child: const Text("Metric"),
        ),
      ],
    );
  }
}
