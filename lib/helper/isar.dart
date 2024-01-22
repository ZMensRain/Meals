import 'package:isar/isar.dart';
import 'package:meal_planner/model/meal.dart';
import 'package:meal_planner/model/recipe_stats.dart';
import 'package:path_provider/path_provider.dart';

Future<Isar> getIsar() async {
  var p = await getApplicationDocumentsDirectory();

  return Isar.getInstance() ??
      await Isar.open([RecipeSchema, RecipeStatsSchema], directory: p.path);
}

void addRecipe(Recipe recipe) async {
  var isar = await getIsar();
  await isar.writeTxn(() => isar.recipes.put(recipe));
}

Future<RecipeStats> getRecipeStats() async {
  var isar = await getIsar();

  if (isar.recipeStats.countSync() == 0) {
    var caloriesQuery =
        isar.recipes.where().idGreaterThan(0).sortByCaloriesPerServing();
    var minCalories = await caloriesQuery.caloriesPerServingProperty().min();
    var maxCalories = await caloriesQuery.caloriesPerServingProperty().max();

    var minMinutes = await caloriesQuery.cookTimeInMinutesProperty().min();
    var maxMinutes = await caloriesQuery.cookTimeInMinutesProperty().max();

    if (minCalories == null || maxCalories == null) {
      minCalories = 0;
      maxCalories = 100;
    }

    if (minMinutes == null || maxMinutes == null) {
      minMinutes = 0;
      maxMinutes = 100;
    }
    return RecipeStats(
        maxCalories: maxCalories,
        minCalories: minCalories,
        maxMinutes: maxMinutes,
        minMinutes: minMinutes);
  }

  return isar.recipeStats.getSync(1)!;
}
