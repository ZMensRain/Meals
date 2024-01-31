import 'package:flutter/material.dart';

class NewTagDialog extends StatelessWidget {
  const NewTagDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var newTagValue = "no no code failed";

    return AlertDialog(
      content: TextField(
        decoration: const InputDecoration(hintText: "Tag"),
        onSubmitted: (value) {
          if (value.trim() == "") {
            Navigator.pop(context);
          }
          Navigator.pop(context, value.trim());
        },
        onChanged: (value) => newTagValue = value,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            if (newTagValue.trim() == "") {
              Navigator.pop(context);
            }

            Navigator.pop(context, newTagValue.trim());
          },
          child: const Text("Create"),
        ),
      ],
    );
  }
}
