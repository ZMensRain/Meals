import 'dart:typed_data';

import 'package:converter/converter.dart';

import 'package:flutter/services.dart';

import 'package:pdf/widgets.dart' as pdf;

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
