import 'package:flutter/material.dart';
import 'package:meal_planner/model/ingredient.dart';

class NewIngredientSheet extends StatefulWidget {
  const NewIngredientSheet(
    this.ingredient, {
    super.key,
    required this.onIngredientAdded,
  });
  final Ingredient? ingredient;
  final void Function(Ingredient ingredient) onIngredientAdded;
  @override
  State<NewIngredientSheet> createState() => _NewIngredientSheetState();
}

class _NewIngredientSheetState extends State<NewIngredientSheet> {
  final _formKey = GlobalKey<FormState>();

  late bool isEditMode;

  Units _selectedUnit = Units.amount;
  double _enteredAmount = 1;
  String _enteredName = "";

  void _addIngredient() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    Navigator.pop(context);
    widget.onIngredientAdded(
        Ingredient(_enteredName, _selectedUnit, amount: _enteredAmount));
  }

  @override
  void initState() {
    super.initState();
    if (widget.ingredient == null) {
      isEditMode = false;
      return;
    }
    isEditMode = true;
    _enteredName = widget.ingredient!.name;
    _enteredAmount = widget.ingredient!.amount;
    _selectedUnit = widget.ingredient!.unit;
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
              isEditMode ? "Edit Ingredient" : "Add Ingredient",
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.left,
            ),
            Expanded(
              child: TextFormField(
                initialValue: _enteredName,
                decoration: const InputDecoration(
                  labelText: "Name",
                ),
                onSaved: (newValue) => _enteredName = newValue!,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "enter a valid ingredient";
                  }
                  return null;
                },
              ),
            ),
            Expanded(
              child: DropdownButtonFormField<Units>(
                decoration: const InputDecoration(
                  labelText: "Unit",
                ),
                value: _selectedUnit,
                items: Units.values
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.name),
                      ),
                    )
                    .toList(),
                validator: (value) =>
                    value == null ? "Please select a unit" : null,
                onSaved: (newValue) => _selectedUnit = newValue!,
                onChanged: (value) {
                  setState(() => _selectedUnit = value!);
                },
              ),
            ),
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(labelText: "Value"),
                initialValue: _enteredAmount.toString(),
                onSaved: (newValue) => _enteredAmount = double.parse(newValue!),
                validator: (value) {
                  if (value == null || double.tryParse(value) == null) {
                    return "Please enter a valid number";
                  }
                  if (double.parse(value) <= 0) {
                    return "Value must be greater than 0";
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
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                    onPressed: _addIngredient,
                    label: Text(isEditMode ? "save" : "Add"),
                    icon: Icon(isEditMode ? Icons.check : Icons.add)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
