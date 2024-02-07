import 'package:isar/isar.dart';
import 'package:meal_planner/model/recipe.dart';
import 'package:meal_planner/model/recipe_stats.dart';
import 'package:meal_planner/model/week.dart';
import 'package:path_provider/path_provider.dart';

Future<Isar> getIsar() async {
  var p = await getApplicationDocumentsDirectory();

  return Isar.getInstance() ??
      await Isar.open([RecipeSchema, RecipeStatsSchema, WeekSchema],
          directory: p.path);
}

void addRecipe(Recipe recipe) async {
  var isar = await getIsar();
  var stats = await getRecipeStats();

  if (stats.maxCalories < recipe.caloriesPerServing) {
    stats = stats.copyWith(maxCalories: recipe.caloriesPerServing);
  }
  if (stats.minCalories > recipe.caloriesPerServing) {
    stats = stats.copyWith(minCalories: recipe.caloriesPerServing);
  }
  if (stats.maxMinutes < recipe.cookTimeInMinutes) {
    stats = stats.copyWith(maxMinutes: recipe.cookTimeInMinutes);
  }
  if (stats.minMinutes > recipe.cookTimeInMinutes) {
    stats = stats.copyWith(minMinutes: recipe.cookTimeInMinutes);
  }

  for (var tag in recipe.tags) {
    if (!stats.tags.contains(tag)) {
      stats = stats.copyWith(tags: stats.tags + [tag]);
    }
  }

  await isar.writeTxn(() => isar.recipes.put(recipe));
  await isar.writeTxn(() => isar.recipeStats.put(stats));
}

//TODO
void addTag(Id recipeId) {
  throw UnimplementedError();
}

void addRecipeToWeekday(Id recipeId, Weekday day) async {
  var isar = await getIsar();

  if ((await isar.weeks.get(1)) == null) {
    isar.writeTxn(() => isar.weeks.put(Week()));
  }

  Week week = (await isar.weeks.get(1))!;

  switch (day) {
    case Weekday.monday:
      week = week.copyWith(monday: (week.monday + [recipeId]).toSet().toList());

      break;
    case Weekday.tuesday:
      week =
          week.copyWith(tuesday: (week.tuesday + [recipeId]).toSet().toList());
      break;
    case Weekday.wednesday:
      week = week.copyWith(
          wednesday: (week.wednesday + [recipeId]).toSet().toList());
      break;
    case Weekday.thursday:
      week = week.copyWith(
          thursday: (week.thursday + [recipeId]).toSet().toList());
      break;
    case Weekday.friday:
      week = week.copyWith(friday: (week.friday + [recipeId]).toSet().toList());
      break;
    case Weekday.saturday:
      week = week.copyWith(
          saturday: (week.saturday + [recipeId]).toSet().toList());
      break;
    case Weekday.sunday:
      week = week.copyWith(sunday: (week.sunday + [recipeId]).toSet().toList());
      break;
    default:
  }
  isar.writeTxn(() => isar.weeks.put(week));
}

Future<List<Recipe>> getRecipesForWeekday(Weekday day) async {
  var isar = await getIsar();
  var week = isar.weeks.getSync(1);

  var ids = week!.getRecipeIds(day);

  List<Recipe> r = [];
  isar.recipes.getAllSync(ids).forEach((e) {
    if (e != null) {
      r.add(e);
    }
  });

  return r;
}

Future<RecipeStats> getRecipeStats() async {
  var isar = await getIsar();

  if (isar.recipeStats.countSync() != 0) {
    return isar.recipeStats.getSync(1)!;
  }

  var caloriesQuery =
      isar.recipes.where().idGreaterThan(0).sortByCaloriesPerServing();
  var minCalories = await caloriesQuery.caloriesPerServingProperty().min();
  var maxCalories = await caloriesQuery.caloriesPerServingProperty().max();

  var minMinutes = await caloriesQuery.cookTimeInMinutesProperty().min();
  var maxMinutes = await caloriesQuery.cookTimeInMinutesProperty().max();

  var listTags = await caloriesQuery.tagsProperty().findAll();

  var tags = listTags.fold<List<String>>(
    [],
    (previousValue, element) => previousValue + (element),
  );

  if (minCalories == null || maxCalories == null) {
    minCalories = 0;
    maxCalories = 100;
  }

  if (minMinutes == null || maxMinutes == null) {
    minMinutes = 0;
    maxMinutes = 100;
  }

  var newRecipeStats = RecipeStats(
    maxCalories: maxCalories,
    minCalories: minCalories,
    maxMinutes: maxMinutes,
    minMinutes: minMinutes,
    tags: tags.toSet().toList(),
  );

  isar.writeTxn(
    () async {
      return isar.recipeStats.put(newRecipeStats);
    },
  );

  return newRecipeStats;
}
