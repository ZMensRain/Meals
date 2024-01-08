import 'package:flutter/material.dart';
import 'package:meal_planner/model/meal.dart';
import 'package:meal_planner/widgets/recipe_card.dart';

class WeekdayScreen extends StatelessWidget {
  const WeekdayScreen({super.key, required this.recipes});
  final List<Recipe> recipes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) =>
            MealCard(recipes[index], onTaped: () {}),
      ),
    );
  }
}
