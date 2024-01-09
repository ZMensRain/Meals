import 'package:flutter/material.dart';
import 'package:meal_planner/model/ingredient.dart';

class IngredientTile extends StatelessWidget {
  const IngredientTile(this.ingredient, this.onLongPress, {super.key});
  final Ingredient ingredient;
  final void Function() onLongPress;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: onLongPress,
      title: Text(
        "\u2022 ${ingredient.amount} ${ingredient.unit != Units.amount ? ingredient.unit.name : ""} ${ingredient.name}",
      ),
    );
  }
}
