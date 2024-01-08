import 'dart:typed_data';

import 'package:converter/converter.dart';

import 'package:flutter/services.dart';

import 'package:pdf/widgets.dart' as pdf;

enum MeasurementSystem { metric, imperial }

enum Units { amount, ml, l, g, kg, tsp, tbsp, cup, oz, lb }

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
  Ingredient(this.name, this.unit, {required this.amount});
  final String name;
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

class Recipe {
  Recipe({
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
  final String title; //
  final int servingSize; //
  final double caloriesPerServing; //
  final List<Ingredient> ingredients;
  final List instructions;
  final Duration prepTime;
  final Duration cookTime;
  final List<String> tags;
  final String? imageUrl;

  List<String> formatIngredients(MeasurementSystem system) {
    final List<String> output = [];
    for (var i in ingredients) {
      output.add(i.format(system));
    }
    return output;
  }

  Future<Uint8List> makePdf(MeasurementSystem measurementSystem) async {
    final pdfd = pdf.Document(
      title: title,
      creator: "Meal planner",
    );

    pdfd.addPage(
      pdf.MultiPage(
        build: (context) => [
          pdf.Text(
            title,
            style: const pdf.TextStyle().copyWith(
              fontSize: 35,
              fontWeight: pdf.FontWeight.bold,
            ),
            textAlign: pdf.TextAlign.left,
          ),
          pdf.Row(
            children: [
              ...tags.map(
                (e) => pdf.Padding(
                  padding: const pdf.EdgeInsets.all(4),
                  child: pdf.Text(
                    e,
                    style: const pdf.TextStyle().copyWith(
                      fontStyle: pdf.FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ],
          ),
          pdf.Text(
            " Calories per serving: $caloriesPerServing cal"
                .replaceAll(".0 ", " "),
            style: const pdf.TextStyle().copyWith(fontSize: 13),
          ),
          pdf.Text(
            " Prep time: ${formatDuration(prepTime)}",
            style: const pdf.TextStyle().copyWith(fontSize: 13),
          ),
          pdf.Text(
            " Cook time: ${formatDuration(cookTime)}",
            style: const pdf.TextStyle().copyWith(fontSize: 13),
          ),
          pdf.SizedBox(height: 8),
          pdf.Text(
            "Ingredients",
            style: const pdf.TextStyle().copyWith(
              fontWeight: pdf.FontWeight.bold,
              fontSize: 25,
              lineSpacing: 2,
            ),
          ),
          pdf.Divider(endIndent: 8),
          ...formatIngredients(measurementSystem).map(
            (e) => pdf.Text(e,
                style: const pdf.TextStyle().copyWith(fontSize: 15)),
          ),
          pdf.SizedBox(height: 8),
          pdf.Text(
            "Instructions",
            style: const pdf.TextStyle().copyWith(
              fontWeight: pdf.FontWeight.bold,
              fontSize: 25,
              lineSpacing: 2,
            ),
          ),
          pdf.Divider(endIndent: 8),
          for (var i = 0; i < instructions.length; i++)
            pdf.Text("${i + 1}. ${instructions[i]}",
                style: const pdf.TextStyle().copyWith(fontSize: 13)),
        ],
      ),
    );

    return pdfd.save();
  }
}

void createShoppingList(List<Recipe> meals) {
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
