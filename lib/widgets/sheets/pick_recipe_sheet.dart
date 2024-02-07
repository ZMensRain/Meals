import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:meal_planner/model/meal.dart';
import 'package:meal_planner/widgets/filter_widget.dart';
import 'package:meal_planner/widgets/recipe_card.dart';

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
          FutureBuilder(
            future: getRecipes(
              title: title,
              includedTags: includedTags,
              notIncludedTags: excludedTags,
              minCalories: minCalories,
              maxCalories: maxCalories,
              minMinutes: minMinutes,
              maxMinutes: maxMinutes,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text("Something went wrong\n ${snapshot.error}"),
                );
              }
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sorry we couldn't find anything...",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => RecipeCard(
                      snapshot.data![index],
                      onTaped: () {
                        Navigator.pop(context);
                        widget.onPickRecipe(snapshot.data![index].id);
                      },
                    ),
                  ),
                );
              }
              return const Center(
                child: Text("Something went wrong"),
              );
            },
          ),
        ],
      ),
    );
  }
}
