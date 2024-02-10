import 'package:flutter/material.dart';
import 'package:meal_planner/helper/isar.dart';
import 'package:meal_planner/model/recipe.dart';
import 'package:meal_planner/model/recipe_stats.dart';
import 'package:meal_planner/screens/recipe_screen.dart';
import 'package:meal_planner/screens/new_recipe_screen.dart';
import 'package:meal_planner/widgets/filter_widget.dart';
import 'package:meal_planner/widgets/recipe_card.dart';

class MealsScreen extends StatefulWidget {
  const MealsScreen({super.key});

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  RecipeStats recipeStats = RecipeStats(
    maxCalories: 300,
    minCalories: 0,
    maxMinutes: 100,
    minMinutes: 0,
    tags: [],
  );

  Stream<void> recipeStream = const Stream.empty();
  @override
  void initState() {
    super.initState();
    getIsar().then(
      (value) => recipeStream = value.recipes.watchLazy(fireImmediately: true),
    );
    getRecipeStats().then(
      (value) {
        recipeStats = value;
        setState(() {
          minCalories = value.minCalories;
          maxCalories = value.maxCalories;
          minMinutes = value.minMinutes;
          maxMinutes = value.maxMinutes;
        });
      },
    );
  }

  String title = "";
  List<String> includedTags = [];
  List<String> excludedTags = [];
  double minCalories = 0.0;
  double maxCalories = 200.0;
  int minMinutes = 0;
  int maxMinutes = 100;

  @override
  Widget build(BuildContext context) {
    getRecipeStats().then(
      (value) {
        recipeStats = value;
        minMinutes = value.minMinutes;
        maxMinutes = value.maxMinutes;
        minCalories = value.minCalories;
        maxCalories = value.maxCalories;
      },
    );
    return StreamBuilder(
      stream: recipeStream,
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              FilterWidget(
                recipeStats,
                onFilterChanged: (
                  maxCalories,
                  minCalories,
                  maxMinutes,
                  minMinutes,
                  includedTags,
                  excludedTags,
                  searchBarText,
                ) {
                  setState(() {
                    title = searchBarText;
                    this.includedTags = includedTags;
                    this.excludedTags = excludedTags;
                    this.minCalories = minCalories;
                    this.maxCalories = maxCalories;
                    this.minMinutes = minMinutes;
                    this.maxMinutes = maxMinutes;
                  });
                },
                showPlusButton: true,
                onPlusButton: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewRecipeScreen(),
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder(
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
                      return const Center(
                          child: CircularProgressIndicator.adaptive());
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }

                    if (!snapshot.hasData) {
                      return const Center(
                        child: Text("Something went wrong"),
                      );
                    }
                    if (snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text("Sorry we couldn't find anything..."),
                      );
                    }

                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) => RecipeCard(
                        snapshot.data![index],
                        onTaped: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MealScreen(snapshot.data![index]),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
