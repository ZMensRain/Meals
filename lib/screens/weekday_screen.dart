import 'package:flutter/material.dart';
import 'package:meal_planner/helper/isar.dart';
import 'package:meal_planner/model/week.dart';
import 'package:meal_planner/screens/recipe_screen.dart';
import 'package:meal_planner/screens/week_screen.dart';
import 'package:meal_planner/widgets/recipe_list.dart';
import 'package:meal_planner/widgets/sheets/pick_recipe_sheet.dart';

class WeekdayScreen extends StatelessWidget {
  const WeekdayScreen({super.key, required this.weekday});
  final Weekday weekday;
  void addRecipeToDay(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.background,
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => PickRecipeSheet(
        onPickRecipe: (int id) {
          addRecipeToWeekday(id, weekday);
        },
      ),
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
        title: Text(weekday.name.capitalize()),
        actions: [
          IconButton(
            onPressed: () => addRecipeToDay(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: RecipeList(
        recipeFuture: getRecipesForWeekday(weekday),
        onTap: (recipe) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MealScreen(recipe),
            ),
          );
        },
        onLongPress: (recipe) {},
      ),
    );
  }
}
