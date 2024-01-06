import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:meal_planner/model/meal.dart';

import 'package:meal_planner/widgets/sections/ingredient_section.dart';
import 'package:meal_planner/widgets/sections/instruction_section.dart';

class NewRecipeScreen extends StatefulWidget {
  const NewRecipeScreen({super.key});

  @override
  State<NewRecipeScreen> createState() => _NewRecipeScreenState();
}

class _NewRecipeScreenState extends State<NewRecipeScreen> {
  bool _isRecipeVaild() {
    throw UnimplementedError();
  }

  void _createRecipe() {
    _isRecipeVaild();

    Meal(
        servingSize: _enteredServingNumber,
        title: _enteredTitle,
        ingredients: ingredients,
        instructions: instructions,
        prepTime: _prepTime!,
        cookTime: _cookTime!,
        caloriesPerServing: _enteredCaloriesPerServing);
  }

  String _enteredTitle = "";
  int _enteredServingNumber = 0;
  double _enteredCaloriesPerServing = 0;
  Duration? _cookTime = Duration.zero;
  Duration? _prepTime = Duration.zero;
  List<String> instructions = [
    "test",
    "ingafjhafhlsdhfjlhlshdjhfj slghflsjhgflsh sghgjflhslfh hsgljshgjhslg hsghshrqgtjsdgifh jsfghsghikfousgh sgjshg jsjfgishgsjgoushgj",
  ];
  List<Ingredient> ingredients = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New recipe"),
        actions: [
          IconButton(
            onPressed: _createRecipe,
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.camera_alt),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Recipe name",
                        ),
                        onSaved: (newValue) => _enteredTitle = newValue!,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 80,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Servings",
                          ),
                          onSaved: (newValue) =>
                              _enteredServingNumber = int.parse(newValue!),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Calories per Serving",
                          ),
                          onSaved: (newValue) => _enteredCaloriesPerServing =
                              double.parse(newValue!),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                Row(
                  children: [
                    TextButton.icon(
                      onPressed: () async {
                        _prepTime = await showDurationPicker(
                          context: context,
                          initialTime: const Duration(minutes: 15),
                        );
                      },
                      icon: const Icon(Icons.alarm_sharp),
                      label: const Text("Prep Time"),
                    ),
                    TextButton.icon(
                      onPressed: () async {
                        _cookTime = await showDurationPicker(
                          context: context,
                          initialTime: const Duration(minutes: 15),
                        );
                      },
                      icon: const Icon(Icons.alarm_sharp),
                      label: const Text("Cook Time"),
                    ),
                  ],
                ),
                IngredientSection(
                  ingredients,
                  onAdd: (ingredient) => setState(
                    () => ingredients.add(ingredient),
                  ),
                  onEdit: (ingredient, index) {
                    setState(() {
                      ingredients[index] = ingredient;
                    });
                  },
                ),
                const SizedBox(height: 12),
                InstructionSection(
                  instructions,
                  onAdd: (instruction) {
                    setState(
                      () => instructions.add(instruction),
                    );
                  },
                  onEdit: (instruction, index) {
                    setState(
                      () => instructions[index] = instruction,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
