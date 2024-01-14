import 'package:flutter/material.dart';
import 'package:meal_planner/model/meal.dart';
import 'package:transparent_image/transparent_image.dart';

class MealCard extends StatelessWidget {
  const MealCard(this.meal, {super.key, required this.onTaped});
  final Recipe meal;
  final void Function() onTaped;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTaped,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (meal.imageUrl != null)
              Hero(
                tag: meal.imageUrl!,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: FadeInImage(
                    placeholder: MemoryImage(kTransparentImage),
                    image: NetworkImage(meal.imageUrl!),
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8),
              child: Text(
                meal.title,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const Divider(endIndent: 8, indent: 8),
            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 6),
              child: Text(
                "Servings: ${meal.servingSize}",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
                bottom: 6,
              ),
              child: Text(
                "Prep time: ${formatDuration(Duration(minutes: meal.prepTimeInMinutes))}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
                bottom: 8,
              ),
              child: Text(
                "Total time: ${formatDuration(Duration(minutes: meal.prepTimeInMinutes + meal.cookTimeInMinutes))}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
