import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:meal_planner/helper/isar.dart';
import 'package:meal_planner/model/ingredient.dart';

import 'package:pdf/widgets.dart' as pdf;

part 'meal.g.dart';

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

@Collection()
class Recipe {
  Recipe({
    required this.servingSize,
    required this.title,
    required this.ingredients,
    required this.instructions,
    required this.prepTimeInMinutes,
    required this.cookTimeInMinutes,
    required this.caloriesPerServing,
    this.imageUrl,
    this.tags = const [],
  });
  final Id id = Isar.autoIncrement;
  final String title;
  final int servingSize;
  final double caloriesPerServing;
  final List<Ingredient> ingredients;
  final List<String> instructions;
  final int prepTimeInMinutes;
  final int cookTimeInMinutes;
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
    final pdfDocument = pdf.Document(
      title: title,
      creator: "Meal planner",
    );

    pdfDocument.addPage(
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
            " Prep time: ${formatDuration(Duration(minutes: prepTimeInMinutes))}",
            style: const pdf.TextStyle().copyWith(fontSize: 13),
          ),
          pdf.Text(
            " Cook time: ${formatDuration(Duration(minutes: cookTimeInMinutes))}",
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

    return pdfDocument.save();
  }
}

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

void createShoppingList(List<Recipe> meals) {
  throw UnimplementedError();
  // final List<Ingredient> allIngredients = [];

  // for (var meal in meals) {
  //   allIngredients.addAll(meal.ingredients);
  // }

  // allIngredients.sort(
  //   (a, b) => a.name.toLowerCase().trim().replaceAll("  ", " ").compareTo(
  //         b.name.toLowerCase().trim().replaceAll("  ", " "),
  //       ),
  // );
}
