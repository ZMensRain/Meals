import 'package:flutter/material.dart';
import 'package:meal_planner/helper/isar.dart';
import 'package:meal_planner/model/week.dart';
import 'package:meal_planner/screens/week_screen.dart';
import 'package:meal_planner/widgets/recipe_card.dart';
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
      body: FutureBuilder(
        future: getRecipesForWeekday(weekday),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("Nothing here yet..."),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) => RecipeCard(
              snapshot.data![index],
              onTaped: () {},
            ),
          );
        },
      ),
    );
  }
}
