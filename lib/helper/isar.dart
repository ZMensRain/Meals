import 'dart:io';

import 'package:isar/isar.dart';
import 'package:meal_planner/model/recipe.dart';
import 'package:meal_planner/model/recipe_stats.dart';
import 'package:meal_planner/model/week.dart';
import 'package:path_provider/path_provider.dart';

/// Returns an isar instance first check if one is open already before
/// opening a new one.
Future<Isar> getIsar() async {
  var p = await getApplicationDocumentsDirectory();

  return Isar.getInstance() ??
      await Isar.open([RecipeSchema, RecipeStatsSchema, WeekSchema],
          directory: p.path);
}

/// Adds [recipe] to the recipe collection and calls [updateRecipeStats].
void addRecipe(Recipe recipe) async {
  var isar = await getIsar();

  await isar.writeTxn(() => isar.recipes.put(recipe));
  updateRecipeStats(recipe: recipe);
}

/// Deletes [recipe] from the recipe collection and calls [updateRecipeStats]
void deleteRecipe(Recipe recipe) async {
  var isar = await getIsar();
  isar.writeTxn(() => isar.recipes.delete(recipe.id));
  await File(recipe.imagePath).delete();
}

/// Adds [tag] to the recipe with [recipeId].
void addTag(Id recipeId, String tag) async {
  var isar = await getIsar();
  var recipe = (await isar.recipes.get(recipeId))!;

  recipe = recipe.copyWith(
    tags: [...recipe.tags, tag],
  );

  isar.writeTxn(
    () => isar.recipes.put(recipe),
  );
  updateRecipeStats(recipe: recipe);
}

/// Updates recipeStats.
///
/// ### NOTE:
/// If a recipe is passed it checks if the recipe's values are higher or lower
/// than the maxes and mins it has stored and updates accordingly.
///
/// If a recipe is not passed it goes through the entire database to find
/// the maxes and mins.
void updateRecipeStats({Recipe? recipe}) async {
  var isar = await getIsar();
  if (recipe != null) {
    var stats = await getRecipeStats();

    if (recipe.caloriesPerServing > stats.maxCalories) {
      stats = stats.copyWith(maxCalories: recipe.caloriesPerServing);
    } else if (recipe.caloriesPerServing < stats.minCalories) {
      stats = stats.copyWith(minCalories: recipe.caloriesPerServing);
    }
    if (recipe.cookTimeInMinutes > stats.maxMinutes) {
      stats = stats.copyWith(maxMinutes: recipe.cookTimeInMinutes);
    } else if (recipe.cookTimeInMinutes < stats.minMinutes) {
      stats = stats.copyWith(minMinutes: recipe.cookTimeInMinutes);
    }

    List<String> tagsToAdd = [];

    for (var tag in recipe.tags) {
      if (stats.tags.contains(tag) == false) {
        tagsToAdd.add(tag);
      }
    }
    stats = stats.copyWith(tags: [...stats.tags, ...tagsToAdd]);
    await isar.writeTxn(() => isar.recipeStats.put(stats));
    return;
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

  minCalories ??= 0;
  maxCalories ??= 300;

  minMinutes ??= 0;
  maxMinutes ??= 300;

  var stats = RecipeStats(
    maxCalories: maxCalories,
    minCalories: minCalories,
    maxMinutes: maxMinutes,
    minMinutes: minMinutes,
    tags: tags.toSet().toList(),
  );

  isar.writeTxn(
    () async {
      return isar.recipeStats.put(stats);
    },
  );

  throw UnimplementedError();
}

/// Adds the recipe id to the weekday passed.
void addRecipeToWeekday(int recipeId, Weekday day) async {
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

/// Removes the recipe id from the weekday passed.
void removeRecipeFromWeekday(int recipeId, Weekday day) async {
  var isar = await getIsar();

  var week = await getWeek();
  var newList =
      week.getRecipeIds(day).where((element) => element != recipeId).toList();

  switch (day) {
    case Weekday.monday:
      week = week.copyWith(monday: newList);
      break;
    case Weekday.tuesday:
      week = week.copyWith(tuesday: newList);
      break;
    case Weekday.wednesday:
      week = week.copyWith(wednesday: newList);
      break;
    case Weekday.thursday:
      week = week.copyWith(thursday: newList);
      break;
    case Weekday.friday:
      week = week.copyWith(friday: newList);
      break;
    case Weekday.saturday:
      week = week.copyWith(saturday: newList);
      break;
    case Weekday.sunday:
      week = week.copyWith(sunday: newList);
      break;
  }
  isar.writeTxn(() => isar.weeks.put(week));
}

/// Returns the recipes for the [Weekday].
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

/// Returns recipeStats if it does not exist,
/// it makes a new one and returns that.
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

  minCalories ??= 0;
  maxCalories ??= 300;

  minMinutes ??= 0;
  maxMinutes ??= 300;

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

Future<Week> getWeek() async {
  var isar = await getIsar();
  if (isar.weeks.countSync() != 0) {
    return isar.weeks.where().findFirstSync()!;
  }
  isar.writeTxn(
    () => isar.weeks.put(
      Week(),
    ),
  );
  return Week();
}

/// Returns all [Recipe]s.
Future<List<Recipe>> getRecipes({
  required String title,
  required List<String> includedTags,
  required List<String> notIncludedTags,
  required double minCalories,
  required double maxCalories,
  required int minMinutes,
  required int maxMinutes,
}) async {
  var isar = await getIsar();

  return isar.recipes
      .filter()
      .titleContains(title, caseSensitive: false)
      .caloriesPerServingBetween(minCalories, maxCalories)
      .cookTimeInMinutesBetween(minMinutes, maxMinutes)
      .anyOf(
        includedTags,
        (q, element) => q.tagsElementContains(element),
      )
      .not()
      .anyOf(notIncludedTags, (q, element) => q.tagsElementContains(element))
      .findAll();
}
