import 'package:isar/isar.dart';
import 'package:meal_planner/helper/isar.dart';
import 'package:meal_planner/model/ingredient.dart';
import 'package:meal_planner/model/recipe.dart';

part 'week.g.dart';

enum Weekday {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

@collection
class Week {
  Week({
    this.monday = const [],
    this.tuesday = const [],
    this.wednesday = const [],
    this.thursday = const [],
    this.friday = const [],
    this.saturday = const [],
    this.sunday = const [],
  });
  final Id id = 1;

  final List<Id> monday;
  final List<Id> tuesday;
  final List<Id> wednesday;
  final List<Id> thursday;
  final List<Id> friday;
  final List<Id> saturday;
  final List<Id> sunday;

  List<Id> getRecipeIds(Weekday weekday) {
    switch (weekday) {
      case Weekday.monday:
        return monday;
      case Weekday.tuesday:
        return tuesday;
      case Weekday.wednesday:
        return wednesday;
      case Weekday.thursday:
        return thursday;
      case Weekday.friday:
        return friday;
      case Weekday.saturday:
        return saturday;
      case Weekday.sunday:
        return sunday;
      default:
        return [];
    }
  }

  Future<List<Ingredient>> getIngredients() async {
    var f = Weekday.values.map((e) => getRecipeIds(e)).toList();
    List<Id> ids =
        f.fold([], (previousValue, element) => previousValue + element);

    List<Recipe?> recipes = (await getIsar()).recipes.getAllSync(ids);

    List<Ingredient> ingredients = recipes
        .map(
      (e) => e?.ingredients,
    )
        .fold(
      [],
      (previousValue, element) {
        if (element == null) {
          return previousValue;
        }
        return previousValue + element;
      },
    );

    ingredients.sort(
      (a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()),
    );

    List<Ingredient> finalIngredients = [];

    for (var ingredient in ingredients) {
      bool exists = false;

      // checks if the ingredient is all ready in the finalIngredients list.
      // If it is adds the ingredient to the the saved one.
      for (var i = 0; i < finalIngredients.length; i++) {
        if (ingredient.isSameAs(finalIngredients[i])) {
          finalIngredients[i] = ingredient.add(finalIngredients[i]);
          exists = true;
          break;
        }
      }

      if (!exists) {
        finalIngredients.add(ingredient);
      }
    }

    return finalIngredients;
  }

  Week copyWith({
    List<Id>? monday,
    List<Id>? tuesday,
    List<Id>? wednesday,
    List<Id>? thursday,
    List<Id>? friday,
    List<Id>? saturday,
    List<Id>? sunday,
  }) {
    return Week(
      monday: monday ?? this.monday,
      tuesday: tuesday ?? this.tuesday,
      wednesday: wednesday ?? this.wednesday,
      thursday: thursday ?? this.thursday,
      friday: friday ?? this.friday,
      saturday: saturday ?? this.saturday,
      sunday: sunday ?? this.sunday,
    );
  }
}
