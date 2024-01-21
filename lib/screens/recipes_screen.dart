import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:meal_planner/helper/isar.dart';
import 'package:meal_planner/model/meal.dart';
import 'package:meal_planner/screens/recipe_screen.dart';
import 'package:meal_planner/screens/new_recipe_screen.dart';
import 'package:meal_planner/widgets/recipe_card.dart';

class MealsScreen extends StatefulWidget {
  const MealsScreen({super.key});

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  late Stream<void> recipeStream;
  late Isar isar;
  bool isUserSearching = false;

  bool isLoadingRecipes = true;

  @override
  void initState() {
    super.initState();
    getIsar().then(
      (value) => setState(
        () {
          isar = value;
          isLoadingRecipes = false;
          recipeStream = value.recipes.watchLazy(fireImmediately: true);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoadingRecipes) {
      return const Center(child: CircularProgressIndicator.adaptive());
    }

    return StreamBuilder(
      stream: recipeStream,
      builder: (context, snapshot) {
        List<Recipe> recipes = isar.recipes.where().findAllSync();
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        isUserSearching = !isUserSearching;
                      });
                    },
                    icon: const Icon(Icons.search)),
                const Spacer(),
                IconButton(onPressed: () {}, icon: const Icon(Icons.sort)),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NewRecipeScreen(),
                          ));
                    },
                    icon: const Icon(Icons.add))
              ],
            ),
            if (isUserSearching) const Placeholder(),
            Expanded(
              child: ListView.builder(
                itemCount: recipes.length,
                itemBuilder: (context, index) => MealCard(
                  recipes[index],
                  onTaped: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MealScreen(recipes[index]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
