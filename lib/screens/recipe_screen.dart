import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meal_planner/model/ingredient.dart';
import 'package:meal_planner/model/recipe.dart';
import 'package:meal_planner/widgets/share_dialog.dart';
import 'package:share_plus/share_plus.dart';

class MealScreen extends StatefulWidget {
  const MealScreen(this.recipe, {super.key});
  final Recipe recipe;

  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  MeasurementSystem measurementSystem = MeasurementSystem.metric;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.title),
        actions: [
          IconButton(
            onPressed: () async {
              var system = await showDialog<MeasurementSystem>(
                context: context,
                builder: (context) => const ShareDialog(),
              );
              if (system == null) {
                return;
              }
              final data = await widget.recipe.makePdf(system);
              final file = XFile.fromData(
                data,
                name: "${widget.recipe.title} recipe",
                mimeType: "pdf",
              );
              await Share.shareXFiles([file]);
            },
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Hero(
                tag: widget.recipe.id,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image(
                    image: FileImage(File(widget.recipe.imagePath)),
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.recipe.tags.length + 1,
                  itemBuilder: (context, index) {
                    if (index == widget.recipe.tags.length) {
                      return IconButton(
                          onPressed: () {}, icon: const Icon(Icons.add));
                    }
                    return Container(
                      padding: const EdgeInsets.all(4.0),
                      child: Center(
                        child: Text(
                          widget.recipe.tags[index],
                          textAlign: TextAlign.center,
                          style: const TextStyle().copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(0.6)),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // measurement selector
              Row(
                children: [
                  TextButton(
                    onPressed: measurementSystem == MeasurementSystem.metric
                        ? null
                        : () {
                            setState(() {
                              measurementSystem = MeasurementSystem.metric;
                            });
                          },
                    child: const Text("Metric"),
                  ),
                  TextButton(
                    onPressed: measurementSystem == MeasurementSystem.imperial
                        ? null
                        : () {
                            setState(() {
                              measurementSystem = MeasurementSystem.imperial;
                            });
                          },
                    child: const Text("Imperial"),
                  ),
                ],
              ),
              Text(
                " Calories per serving: ${widget.recipe.caloriesPerServing} cal"
                    .replaceAll(".0 ", " "),
              ),
              Text(
                  " Prep time: ${formatDuration(Duration(minutes: widget.recipe.prepTimeInMinutes))}"),
              Text(
                  " Cook time: ${formatDuration(Duration(minutes: widget.recipe.cookTimeInMinutes))}"),

              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  "Ingredients",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              const Divider(),
              ...widget.recipe.formatIngredients(measurementSystem).map(
                    (e) => Text(
                      "\u2022 $e",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text("Instructions",
                    style: Theme.of(context).textTheme.headlineLarge),
              ),
              const Divider(),
              for (var i = 0; i < widget.recipe.instructions.length; i++)
                Text("${i + 1}. ${widget.recipe.instructions[i]}"),
            ],
          ),
        ),
      ),
    );
  }
}
