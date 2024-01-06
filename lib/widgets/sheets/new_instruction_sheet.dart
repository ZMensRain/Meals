import 'package:flutter/material.dart';

class NewInstructionSheet extends StatefulWidget {
  const NewInstructionSheet(this.instruction, {super.key, required this.onAdd});
  final String? instruction;
  final void Function(String instruction) onAdd;
  @override
  State<NewInstructionSheet> createState() => _NewInstructionSheetState();
}

class _NewInstructionSheetState extends State<NewInstructionSheet> {
  final TextEditingController _instructionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late bool isEditMode;

  void save() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    widget.onAdd(_instructionController.text);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
    _instructionController.dispose();
  }

  @override
  void initState() {
    super.initState();
    isEditMode = widget.instruction != null;
    _instructionController.text = widget.instruction ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding:
          EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16 + bottom),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              isEditMode ? "Edit instruction" : "New instruction",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Expanded(
              child: TextFormField(
                maxLines: 10,
                controller: _instructionController,
                decoration: const InputDecoration(
                  hintMaxLines: 10,
                  labelText: "Instruction Text",
                ),
                validator: (value) {
                  if (value == null || value.trim().length <= 5) {
                    return "Instruction must be at least 5 characters long";
                  }
                  return null;
                },
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.error),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton.icon(
                  onPressed: save,
                  label: Text(isEditMode ? "Save" : "Add"),
                  icon: Icon(isEditMode ? Icons.check : Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
