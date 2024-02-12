import 'package:converter/converter.dart';
import 'package:isar/isar.dart';
import 'package:pluralize/pluralize.dart';

part 'ingredient.g.dart';

enum Units { amount, ml, l, g, kg, tsp, tbsp, cup, oz, lb, none }

extension UnitsExtension on Units {
  /// Returns true if the unit is a unit of mass (g, kg, ... ).
  bool get isMass {
    if ("g kg oz lb".contains(name)) {
      return true;
    }
    return false;
  }

  /// Returns true if the unit is a unit of volume (ml, l, ... ).
  bool get isVolume {
    if ("ml l tsp tbsp cup".contains(name)) {
      return true;
    }
    return false;
  }

  /// Returns true if the two units are compatible.
  ///
  /// Units are considered compatible if both return true [isMass] or [isVolume]
  /// or both are of type [amount].
  ///
  /// NOTE: returns false if either of the units are none
  bool addable(Units other) {
    if (this == Units.none || other == Units.none) {
      return false;
    }
    if (isMass && other.isMass) {
      return true;
    }
    if (isVolume && other.isVolume) {
      return true;
    }
    if (this == other) {
      return true;
    }
    return false;
  }
}

enum MeasurementSystem { metric, imperial }

@embedded
class Ingredient {
  Ingredient({this.name, this.unit = Units.none, this.amount});
  final String? name;
  @enumerated
  final Units unit;
  final double? amount;

  bool get isNull => name == null || unit == Units.none || amount == null;

  /// Returns a formatted string in the form 2kgs salt.
  String format(MeasurementSystem system) {
    if (isNull) {
      return "null";
    }

    if (unit == Units.amount) {
      final Pluralize pluralize = Pluralize();
      return "$amount ${amount != 1 ? pluralize.plural(name!) : pluralize.singular(name!)}";
    }

    late Quantity quantity;

    if (unit == Units.cup) {
      quantity = Volume(amount! * 16, "tbsp");
    }

    if (unit.isMass) {
      quantity = Mass(amount!, unit.name);
    } else if (unit != Units.cup) {
      quantity = Volume(amount!, unit.name);
    }

    switch (quantity.runtimeType) {
      case Volume:
        if (system == MeasurementSystem.metric) {
          final liters = quantity.valueIn("l");
          if (liters < 1) {
            return "${quantity.valueIn("ml").floorToDouble()}ml $name";
          }
          return ("${liters.floorToDouble()}l $name");
        } else {
          var tbsp = quantity.valueIn("tbsp");
          if (tbsp < 3) {
            return ("${tbsp * 3.round()}tsp $name");
          }
          if (tbsp >= 4) {
            var cups = (tbsp * 0.0625).round();
            return ("$cups${cups > 1 ? "cups" : "cup"} $name ");
          }
          return "${tbsp}tbsp $name";
        }
      case Mass:
        if (system == MeasurementSystem.metric) {
          var grams = quantity.valueIn("g");
          if (grams >= 1000) {
            var kgs = double.parse((grams / 1000).toStringAsFixed(1));
            return ("$kgs${kgs != 1 ? "kgs" : "kg"} $name");
          }
          return ("${grams}g $name");
        } else {
          var ounces = quantity.valueIn("oz");
          if (ounces >= 16) {
            return ("${(ounces / 16).toStringAsFixed(1)}lb $name");
          }
          return ("${ounces.toStringAsFixed(1)}oz $name");
        }
    }

    return "$amount$unit $name";
  }

  /// Returns true if the name of the passed [Ingredient] matches that
  /// of the [Ingredient] calling.
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

  /// Returns an [Ingredient] with the measurements of the [Ingredient]s added
  ///
  /// NOTE: Can throw if the [Ingredient]s are not compatible
  Ingredient add(Ingredient ingredient) {
    if (!isSameAs(ingredient)) {
      throw "Two different ingredients";
    }

    // prevents trying to add non-addable units.
    if (!unit.addable(ingredient.unit)) {
      throw "Units are not of the same type";
    }

    if (unit == Units.amount) {
      return Ingredient(
        name: name,
        amount: amount! + ingredient.amount!,
        unit: Units.amount,
      );
    }

    late Quantity quantity;

    if (unit.isVolume) {
      quantity = Volume(
            ingredient.amount!,
            ingredient.unit.name,
          ) +
          Volume(
            amount!,
            unit.name,
          );
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
      amount: quantity.valueIn(unit.name).toDouble(),
      name: name,
      unit: unit,
    );
  }
}
