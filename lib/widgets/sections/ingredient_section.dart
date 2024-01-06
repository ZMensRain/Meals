import 'package:flutter/material.dart';
import 'package:meal_planner/model/meal.dart';
import 'package:meal_planner/widgets/ingredient_tile.dart';
import 'package:meal_planner/widgets/sheets/new_ingredient_sheet.dart';

class IngredientSection extends StatelessWidget {
  const IngredientSection(
    this.ingredients, {
    super.key,
    required this.onEdit,
    required this.onAdd,
  });

  final List<Ingredient> ingredients;

  final void Function(Ingredient ingredient) onAdd;

  final void Function(Ingredient ingredient, int index) onEdit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text("Ingredients",
                style: Theme.of(context).textTheme.headlineMedium),
            const Spacer(),
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  useSafeArea: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => NewIngredientSheet(
                    null,
                    onIngredientAdded: (ingredient) {
                      onAdd(ingredient);
                    },
                  ),
                );
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        const Divider(),
        SizedBox(
          height: 250,
          child: ListView.separated(
            separatorBuilder: (context, index) => const Divider(thickness: 0.5),
            itemCount: ingredients.length,
            itemBuilder: (context, index) => IngredientTile(
              ingredients[index],
              () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  useSafeArea: true,
                  context: context,
                  builder: (context) => NewIngredientSheet(
                    ingredients[index],
                    onIngredientAdded: (ingredient) {
                      onEdit(ingredient, index);
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
