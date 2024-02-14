import 'package:flutter/material.dart';
import 'package:meal_planner/model/recipe.dart';
import 'package:meal_planner/screens/week_screen.dart';

class WeekdayCard extends StatelessWidget {
  const WeekdayCard(this.day, this.recipes,
      {super.key, required this.onTap, required this.onLongPress});
  final String day;
  final void Function() onTap;
  final void Function(LongPressEndDetails details, BuildContext context)
      onLongPress;
  final List<Recipe?> recipes;

  List<String> _getTags() {
    List<String> tags = [];

    for (var recipe in recipes) {
      if (recipe == null) {
        continue;
      }
      tags.addAll(recipe.tags.map((e) => e.toLowerCase().trim()));
    }

    return tags.toSet().toList();
  }

  List<String> _getRecipeNames() {
    List<String> recipeNames = [];
    for (var recipe in recipes) {
      if (recipe == null) {
        continue;
      }
      recipeNames.add(recipe.title);
    }
    return recipeNames;
  }

  @override
  Widget build(BuildContext context) {
    final tags = _getTags();

    return Card(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: GestureDetector(
        onLongPressEnd: (details) {
          onLongPress(details, context);
        },
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(8),
            constraints: const BoxConstraints(minHeight: 150),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(day, style: Theme.of(context).textTheme.headlineMedium),
                SizedBox(
                  height: 20,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Text("\u2022"),
                    itemCount: tags.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(tags[index]),
                    ),
                  ),
                ),
                const Divider(),
                ..._getRecipeNames()
                    .map((e) => Text("\u2022 ${e.capitalize()}")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
