import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:meal_planner/helper/isar.dart';
import 'package:meal_planner/model/meal.dart';
import 'package:meal_planner/widgets/filter_widget.dart';
import 'package:meal_planner/widgets/recipe_card.dart';

class PickRecipeSheet extends StatefulWidget {
  const PickRecipeSheet({super.key});

  @override
  State<PickRecipeSheet> createState() => _PickRecipeSheetState();
}

class _PickRecipeSheetState extends State<PickRecipeSheet> {
  bool isSearching = false;
  bool isFiltering = false;

  final searchController = TextEditingController();

  void recipePicked(Id recipeId) {}

  late Isar isar;

  @override
  void initState() {
    super.initState();
    getIsar().then((value) => isar = value);
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  List<Recipe> recipes = [];

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Pick a recipe",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () => setState(
                        () => isSearching = !isSearching,
                      ),
                  icon: const Icon(Icons.search)),
              const Spacer(),
              IconButton(
                onPressed: () => setState(() {
                  FocusManager.instance.primaryFocus?.unfocus();
                  isSearching = false;
                  isFiltering = !isFiltering;
                }),
                icon: const Icon(Icons.sort),
              ),
            ],
          ),
          if (isSearching)
            TextField(
              decoration: const InputDecoration(hintText: "Recipe name"),
              autofocus: true,
              controller: searchController,
              onSubmitted: (value) {
                setState(() {
                  isSearching = false;
                });
              },
            ),
          if (isFiltering) const FilterWidget(),
          if (!isSearching) const Divider(),
          FutureBuilder(
            future: getRecipes(searchController.text, [], []),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text("Something went wrong\n ${snapshot.error}"),
                );
              }
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Sorry we couldn't find anything \n try different tags or a different search",
                          textAlign: TextAlign.center,
                        ),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                searchController.text = "";
                              });
                            },
                            child: const Text("clear search"))
                      ],
                    ),
                  );
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => MealCard(
                      snapshot.data![index],
                      onTaped: () => recipePicked(snapshot.data![index].id),
                    ),
                  ),
                );
              }
              return const Center(
                child: Text("Something went wrong"),
              );
            },
          ),
        ],
      ),
    );
  }
}
