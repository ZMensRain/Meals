import 'package:flutter/material.dart';
import 'package:meal_planner/helper/isar.dart';
import 'package:meal_planner/model/week.dart';
import 'package:meal_planner/screens/recipe_screen.dart';
import 'package:meal_planner/screens/week_screen.dart';
import 'package:meal_planner/widgets/recipe_list.dart';
import 'package:meal_planner/widgets/sheets/pick_recipe_sheet.dart';

class WeekdayScreen extends StatefulWidget {
  const WeekdayScreen({super.key, required this.weekday});
  final Weekday weekday;

  @override
  State<WeekdayScreen> createState() => _WeekdayScreenState();
}

class _WeekdayScreenState extends State<WeekdayScreen> {
  void addRecipeToDay(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.background,
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => PickRecipeSheet(
        onPickRecipe: (int id) {
          addRecipeToWeekday(id, widget.weekday);
        },
      ),
    );
  }

  Stream<void> stream = const Stream.empty();

  @override
  void initState() {
    super.initState();
    getIsar().then(
      (value) => setState(
        () => stream = value.weeks.watchLazy(),
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
        title: Text(widget.weekday.name.capitalize()),
        actions: [
          IconButton(
            onPressed: () => addRecipeToDay(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder(
          stream: stream,
          builder: (context, snapshot) {
            return RecipeList(
              recipeFuture: getRecipesForWeekday(widget.weekday),
              onTap: (recipe) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MealScreen(recipe),
                  ),
                );
              },
              onLongPress: (recipe) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(recipe.title),
                    content: Text(
                      "Would you like to remove this recipe from ${widget.weekday.name.capitalize()}?",
                      textAlign: TextAlign.center,
                    ),
                    actions: [
                      TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor:
                                Theme.of(context).colorScheme.secondary),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          removeRecipeFromWeekday(recipe.id, widget.weekday);
                          Navigator.pop(context);
                        },
                        child: const Text("Yes"),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
    );
  }
}
