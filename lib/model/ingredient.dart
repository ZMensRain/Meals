import 'package:converter/converter.dart';
import 'package:isar/isar.dart';
import 'package:pluralize/pluralize.dart';

part 'ingredient.g.dart';

enum Units { amount, ml, l, g, kg, tsp, tbsp, cup, oz, lb, none }

enum MeasurementSystem { metric, imperial }

@embedded
class Ingredient {
  Ingredient({this.name, this.unit = Units.none, this.amount});
  final String? name;
  @enumerated
  final Units unit;
  final double? amount;

  bool get isNull => name == null || unit == Units.none || amount == null;

  String format(MeasurementSystem system) {
    if (isNull) {
      return "null";
    }

    if (unit == Units.amount) {
      return "$amount $name";
    }

    late Quantity quantity;

    if (unit == Units.cup) {
      quantity = Volume(amount! * 16, "tbsp");
    }

    if (unit == Units.g ||
        unit == Units.kg ||
        unit == Units.oz ||
        unit == Units.lb) {
      quantity = Mass(amount!, unit.name);
    } else if (unit != Units.cup) {
      quantity = Volume(amount!, unit.name);
    }

    switch (quantity.runtimeType) {
      case Volume:
        if (system == MeasurementSystem.metric) {
          final v = quantity.valueIn("l");
          if (v < 1) {
            return "${quantity.valueIn("ml").floorToDouble()}ml $name";
          } else {
            return ("${v.floorToDouble()}L $name");
          }
        } else {
          var tbsp = quantity.valueIn("tbsp");
          if (tbsp < 3) {
            return ("${tbsp * 3.round()}tsp $name");
          }
          if (tbsp >= 4) {
            var cups = (tbsp * 0.0625).round();
            return ("$cups${cups > 1 ? "cups" : "cup"} $name ");
          }
        }
        break;
      case Mass:
        if (system == MeasurementSystem.metric) {
          var grams = quantity.valueIn("g");
          if (grams >= 1000) {
            return ("${grams / 1000}kg $name");
          } else {
            return ("${grams}g $name");
          }
        } else {
          var ounces = quantity.valueIn("oz");
          if (ounces >= 16) {
            return ("${(ounces / 16).round()}lb $name");
          } else {
            return ("${ounces.round()}oz $name");
          }
        }
    }
    return "$amount$unit $name";
  }

  bool isSameAs(Ingredient ingredient) {
    final pluralize = Pluralize();

    if (pluralize.singular(
          ingredient.name!
              .toLowerCase()
              .replaceAll(" ", "")
              .replaceAll("\n", ""),
        ) ==
        pluralize.singular(
          name!.toLowerCase().replaceAll(" ", "").replaceAll("\n", ""),
        )) {
      return true;
    }
    return false;
  }

  Ingredient add(Ingredient ingredient) {
    if (!isSameAs(ingredient)) {
      throw "Two different ingredients";
    }

    late Quantity quantity;

    if (("ml l tsp tbsp cup".contains(ingredient.unit.name) &&
            !"ml l tsp tbsp cup".contains(unit.name)) ||
        ingredient.unit != unit) {
      throw "Units are not of the same type";
    }

    if (ingredient.unit == Units.amount) {
      return Ingredient(
        name: name,
        amount: amount! + ingredient.amount!,
        unit: Units.amount,
      );
    }

    if ("ml l tsp tbsp cup".contains(ingredient.unit.name)) {
      quantity = Volume(ingredient.amount!, ingredient.unit.name) +
          Volume(amount!, unit.name);
    } else {
      quantity = Mass(
            ingredient.amount!,
            ingredient.unit.name,
          ) +
          Mass(
            amount!,
            unit.name,
          );
    }

    return Ingredient(
      amount: quantity.valueIn(unit.name) as double,
      name: name,
      unit: unit,
    );
  }
}
