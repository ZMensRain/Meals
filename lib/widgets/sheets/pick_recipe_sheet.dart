import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:meal_planner/helper/isar.dart';
import 'package:meal_planner/model/recipe.dart';
import 'package:meal_planner/model/recipe_stats.dart';
import 'package:meal_planner/widgets/filter_widget.dart';
import 'package:meal_planner/widgets/recipe_list.dart';

class PickRecipeSheet extends StatefulWidget {
  const PickRecipeSheet({super.key, required this.onPickRecipe});

  final void Function(Id id) onPickRecipe;

  @override
  State<PickRecipeSheet> createState() => _PickRecipeSheetState();
}

class _PickRecipeSheetState extends State<PickRecipeSheet> {
  List<Recipe> recipes = [];

  double minCalories = 0;

  double maxCalories = 300;

  int minMinutes = 0;

  int maxMinutes = 180;

  String title = '';
  List<String> includedTags = [];
  List<String> excludedTags = [];

  RecipeStats stats = RecipeStats(
      maxCalories: 300,
      minCalories: 0,
      maxMinutes: 100,
      minMinutes: 0,
      tags: []);

  @override
  void initState() {
    super.initState();

    getRecipeStats().then(
      (value) {
        setState(
          () {
            minCalories = value.minCalories;

            maxCalories = value.maxCalories;

            minMinutes = value.minMinutes;

            maxMinutes = value.maxMinutes;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Pick a recipe",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          FilterWidget(
            stats,
            onFilterChanged: (
              maxCalories,
              minCalories,
              maxMinutes,
              minMinutes,
              includedTags,
              excludedTags,
              searchBarText,
            ) {
              setState(
                () {
                  this.minCalories = minCalories;

                  this.maxCalories = maxCalories;

                  this.minMinutes = minMinutes;

                  this.maxMinutes = maxMinutes;

                  title = searchBarText;
                  this.includedTags = includedTags;
                  this.excludedTags = excludedTags;
                },
              );
            },
          ),
          Expanded(
            child: RecipeList(
              recipeFuture: getRecipes(
                title: title,
                includedTags: includedTags,
                notIncludedTags: excludedTags,
                minCalories: minCalories,
                maxCalories: maxCalories,
                minMinutes: minMinutes,
                maxMinutes: maxMinutes,
              ),
              onTap: (Recipe recipe) {
                Navigator.pop(context);
                widget.onPickRecipe(recipe.id);
              },
              onLongPress: (recipe) {},
            ),
          ),
        ],
      ),
    );
  }
}
