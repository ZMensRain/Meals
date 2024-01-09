import 'package:converter/converter.dart';
import 'package:isar/isar.dart';

enum Units { amount, ml, l, g, kg, tsp, tbsp, cup, oz, lb }

enum MeasurementSystem { metric, imperial }

@collection
class Ingredient {
  Ingredient(this.name, this.unit, {required this.amount});
  final String name;
  @enumerated
  final Units unit;
  final double amount;
  String format(MeasurementSystem system) {
    if (unit == Units.amount) {
      return "$amount $name";
    }

    late Quantity quantity;

    if (unit == Units.cup) {
      quantity = Volume(amount * 16, "tbsp");
    }

    if (unit == Units.g ||
        unit == Units.kg ||
        unit == Units.oz ||
        unit == Units.lb) {
      quantity = Mass(amount, unit.name);
    } else if (unit != Units.cup) {
      quantity = Volume(amount, unit.name);
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
}
