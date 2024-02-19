import 'dart:typed_data';

import 'package:isar/isar.dart';
import 'package:meal_planner/helper/isar.dart';
import 'package:meal_planner/model/ingredient.dart';
import 'package:meal_planner/model/recipe.dart';

import 'package:pdf/widgets.dart' as pdf;

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

  /// Returns the list with the same name as the weekday passed.
  ///
  /// If null is passed it returns all recipe ids for that week.
  List<Id> getRecipeIds(Weekday? weekday) {
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
        return monday +
            tuesday +
            wednesday +
            thursday +
            friday +
            saturday +
            sunday;
    }
  }

  /// Returns all unique [Ingredient]s adding all the [Ingredient]s
  /// that are the same
  Future<List<Ingredient>> getIngredients() async {
    List<int> ids = getRecipeIds(null);

    List<Recipe?> recipes = (await getIsar()).recipes.getAllSync(ids);

    List<Ingredient> nonUniqueIngredients = [];

    for (var recipe in recipes) {
      if (recipe != null) {
        nonUniqueIngredients.addAll(recipe.ingredients);
      }
    }

    List<Ingredient> ingredients = [];

    for (var ingredient in nonUniqueIngredients) {
      bool exists = false;

      // checks if the ingredient is all ready in the finalIngredients list.
      // If it is adds the ingredient to the the saved one.
      for (var i = 0; i < ingredients.length; i++) {
        if (ingredient.isSameAs(ingredients[i])) {
          ingredients[i] = ingredient.add(ingredients[i]);
          exists = true;
          break;
        }
      }

      if (!exists) {
        ingredients.add(ingredient);
      }
    }

    return ingredients;
  }

  /// Returns the shopping list for this week as a pdf file
  Future<Uint8List> getShoppingListAsPDF(MeasurementSystem system) async {
    final pdfDocument = pdf.Document(
      title: "Shopping list",
      creator: "Meal planner",
    );

    var ingredients = await getIngredients();

    pdfDocument.addPage(
      pdf.MultiPage(
        build: (context) => [
          pdf.Text(
            "Shopping list",
            style: pdf.TextStyle.defaultStyle().copyWith(
              fontSize: 30,
              fontWeight: pdf.FontWeight.bold,
              fontBold: pdf.Font.timesBold(),
            ),
          ),
          ...ingredients.map((e) => pdf.Bullet(text: e.format(system))),
        ],
      ),
    );

    return pdfDocument.save();
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
