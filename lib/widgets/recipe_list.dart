import 'package:flutter/material.dart';
import 'package:meal_planner/model/recipe.dart';
import 'package:meal_planner/widgets/recipe_card.dart';

class RecipeList extends StatelessWidget {
  const RecipeList({
    super.key,
    required this.recipeFuture,
    required this.onTap,
    required this.onLongPress,
  });
  final Future<List<Recipe>> recipeFuture;
  final void Function(Recipe recipe) onTap;
  final void Function(Recipe recipe) onLongPress;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: recipeFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }

        if (!snapshot.hasData) {
          return const Center(
            child: Text("Something went wrong"),
          );
        }
        if (snapshot.data!.isEmpty) {
          return const Center(
            child: Text("Sorry we couldn't find anything..."),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) => RecipeCard(
            snapshot.data![index],
            onTaped: () => onTap(snapshot.data![index]),
            onLongPress: () => onLongPress(snapshot.data![index]),
          ),
        );
      },
    );
  }
}
