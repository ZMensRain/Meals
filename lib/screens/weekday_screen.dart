import 'package:flutter/material.dart';
import 'package:meal_planner/model/meal.dart';
import 'package:meal_planner/widgets/recipe_card.dart';
import 'package:meal_planner/widgets/sheets/pick_recipe_sheet.dart';

class WeekdayScreen extends StatelessWidget {
  const WeekdayScreen({super.key, required this.recipes});
  final List<Recipe> recipes;

  void addRecipeToDay(BuildContext context) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => const PickRecipeSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => addRecipeToDay(context),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => addRecipeToDay(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) => MealCard(
          recipes[index],
          onTaped: () {},
        ),
      ),
    );
  }
}
