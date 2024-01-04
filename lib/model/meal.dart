import 'package:converter/converter.dart';

enum MeasurementSystem { metric, imperial }

String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = duration.inMinutes.remainder(60).abs().toString();
  if (twoDigits(duration.inHours) == "0") {
    return "$twoDigitMinutes min";
  }
  if (twoDigitMinutes == "0") {
    return "${duration.inHours} ${duration.inHours > 1 ? "hours" : "hour"}";
  }
  return "${duration.inHours}h ${twoDigitMinutes}min";
}

class Ingredient {
  Ingredient(this.name, this.quantity, {this.amount = 1});
  final String name;
  final Quantity? quantity;
  final int amount;
}

class Meal {
  Meal({
    required this.servingSize,
    required this.title,
    required this.ingredients,
    required this.instructions,
    required this.prepTime,
    required this.cookTime,
    required this.caloriesPerServing,
    this.imageUrl,
    this.tags = const [],
  });
  final String title;
  final int servingSize;
  final double caloriesPerServing;
  final List<Ingredient> ingredients;
  final List instructions;
  final Duration prepTime;
  final Duration cookTime;
  final List<String> tags;
  final String? imageUrl;

  List<String> formatIngredients(MeasurementSystem system) {
    final List<String> output = [];
    for (var i in ingredients) {
      if (i.quantity == null) {
        output.add("${i.amount} ${i.name}");
      }
      switch (i.quantity.runtimeType) {
        case Volume:
          if (system == MeasurementSystem.metric) {
            final v = i.quantity!.valueIn("l");
            if (v < 1) {
              output.add(
                  "${i.quantity!.valueIn("ml").floorToDouble()}ml ${i.name}");
            } else {
              output.add("${v.floorToDouble()}L ${i.name}");
            }
          } else {
            var tbsp = i.quantity!.valueIn("tbsp");
            if (tbsp < 3) {
              output.add("${tbsp * 3.round()}tsp ${i.name}");
            }
            if (tbsp >= 4) {
              var cups = (tbsp * 0.0625).round();
              output.add("$cups${cups > 1 ? "cups" : "cup"} ${i.name} ");
            }
          }
          break;
        case Mass:
          if (system == MeasurementSystem.metric) {
            var grams = i.quantity!.valueIn("g");
            if (grams >= 1000) {
              output.add("${grams / 1000}kg ${i.name}");
            } else {
              output.add("${grams}g ${i.name}");
            }
          } else {
            var ounces = i.quantity!.valueIn("oz");
            if (ounces >= 16) {
              output.add("${(ounces / 16).round()}lb ${i.name}");
            } else {
              output.add("${ounces.round()}oz ${i.name}");
            }
          }
          break;
        default:
      }
    }
    return output;
  }
}

void createShoppingList(List<Meal> meals) {
  final List<Ingredient> allIngredients = [];

  for (var meal in meals) {
    allIngredients.addAll(meal.ingredients);
  }

  allIngredients.sort(
    (a, b) => a.name.toLowerCase().trim().replaceAll("  ", " ").compareTo(
          b.name.toLowerCase().trim().replaceAll("  ", " "),
        ),
  );
}
