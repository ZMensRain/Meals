import 'package:flutter/material.dart';
import 'package:meal_planner/widgets/sheets/new_instruction_sheet.dart';

class InstructionSection extends StatelessWidget {
  const InstructionSection(this.instructions,
      {super.key, required this.onAdd, required this.onEdit});
  final List<String> instructions;
  final void Function(String instruction) onAdd;
  final void Function(String instruction, int index) onEdit;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text("Instructions",
                style: Theme.of(context).textTheme.headlineMedium),
            const Spacer(),
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  useSafeArea: true,
                  context: context,
                  builder: (context) => NewInstructionSheet(
                    null,
                    onAdd: onAdd,
                  ),
                );
              },
              icon: const Icon(Icons.add),
            )
          ],
        ),
        const Divider(),
        SizedBox(
          height: 250,
          child: ListView.builder(
            itemCount: instructions.length,
            itemBuilder: (context, index) => InkWell(
              onLongPress: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  useSafeArea: true,
                  context: context,
                  builder: (context) => NewInstructionSheet(
                    instructions[index],
                    onAdd: (instruction) => onEdit(instruction, index),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${index + 1}. ${instructions[index]}",
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
