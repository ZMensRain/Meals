import 'package:flutter/material.dart';
import 'package:meal_planner/model/ingredient.dart';
import 'package:meal_planner/model/recipe.dart';
import 'package:meal_planner/widgets/share_dialog.dart';

class MealScreen extends StatefulWidget {
  const MealScreen(this.meal, {super.key});
  final Recipe meal;

  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  MeasurementSystem measurementSystem = MeasurementSystem.metric;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meal.title),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => ShareDialog(widget.meal),
              );
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
              if (widget.meal.imageUrl != null)
                Hero(
                  tag: widget.meal.imageUrl!,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Image(
                      image: NetworkImage(widget.meal.imageUrl!),
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.meal.tags.length + 1,
                  itemBuilder: (context, index) {
                    if (index == widget.meal.tags.length) {
                      return IconButton(
                          onPressed: () {}, icon: const Icon(Icons.add));
                    }
                    return Container(
                      padding: const EdgeInsets.all(4.0),
                      child: Center(
                        child: Text(
                          widget.meal.tags[index],
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
                " Calories per serving: ${widget.meal.caloriesPerServing} cal"
                    .replaceAll(".0 ", " "),
              ),
              Text(
                  " Prep time: ${formatDuration(Duration(minutes: widget.meal.prepTimeInMinutes))}"),
              Text(
                  " Cook time: ${formatDuration(Duration(minutes: widget.meal.cookTimeInMinutes))}"),

              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  "Ingredients",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              const Divider(),
              ...widget.meal.formatIngredients(measurementSystem).map(
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
              for (var i = 0; i < widget.meal.instructions.length; i++)
                Text("${i + 1}. ${widget.meal.instructions[i]}"),
            ],
          ),
        ),
      ),
    );
  }
}
