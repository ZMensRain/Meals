import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meal_planner/model/recipe.dart';
import 'package:meal_planner/screens/week_screen.dart';
import 'package:transparent_image/transparent_image.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard(
    this.recipe, {
    super.key,
    required this.onTaped,
    required this.onLongPress,
  });
  final Recipe recipe;
  final void Function() onTaped;
  final void Function() onLongPress;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onLongPress: onLongPress,
        onTap: onTaped,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: recipe.id,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                clipBehavior: Clip.hardEdge,
                child: FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: FileImage(File(recipe.imagePath)),
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8),
              child: Text(
                recipe.title.capitalize(),
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const Divider(endIndent: 8, indent: 8),
            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 6),
              child: Text(
                "Servings: ${recipe.servingSize}",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
                bottom: 6,
              ),
              child: Text(
                "Prep time: ${formatDuration(Duration(minutes: recipe.prepTimeInMinutes))}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
                bottom: 8,
              ),
              child: Text(
                "Total time: ${formatDuration(Duration(minutes: recipe.prepTimeInMinutes + recipe.cookTimeInMinutes))}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
