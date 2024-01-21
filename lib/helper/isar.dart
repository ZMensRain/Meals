import 'package:isar/isar.dart';
import 'package:meal_planner/model/meal.dart';
import 'package:path_provider/path_provider.dart';

Future<Isar> getIsar() async {
  var p = await getApplicationDocumentsDirectory();

  return Isar.getInstance() ??
      await Isar.open([RecipeSchema], directory: p.path);
}

void addRecipe(Recipe recipe) async {
  var isar = await getIsar();
  await isar.writeTxn(() => isar.recipes.put(recipe));
}
