import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:meal_planner/helper/isar.dart';
import 'package:meal_planner/model/recipe.dart';
import 'package:meal_planner/model/week.dart';
import 'package:meal_planner/screens/weekday_screen.dart';
import 'package:meal_planner/widgets/weekday_card.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class WeekScreen extends StatefulWidget {
  const WeekScreen({super.key});

  @override
  State<WeekScreen> createState() => _WeekScreenState();
}

class _WeekScreenState extends State<WeekScreen> {
  Stream<void> weekStream = const Stream.empty();

  @override
  void initState() {
    super.initState();
    getIsar().then((value) {
      isar = value;
      setState(() {
        weekStream = value.weeks.watchLazy(fireImmediately: true);
      });
    });
  }

  List<Recipe?> getRecipesFromId(List<Id> ids) {
    return ids
        .map(
          (id) => isar.recipes.filter().idEqualTo(id).findFirstSync(),
        )
        .toList();
  }

  late Isar isar;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: weekStream,
      builder: (context, snapshot) => FutureBuilder(
        future: getWeek(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }

          if (snapshot.hasData) {
            return Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    var ing = await snapshot.data!.getIngredients();
                    print(ing);
                  },
                  child: const Text(""),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: Weekday.values.length,
                    itemBuilder: (context, index) => WeekdayCard(
                      Weekday.values[index].name.capitalize(),
                      getRecipesFromId(
                          snapshot.data!.getRecipeIds(Weekday.values[index])),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WeekdayScreen(
                              weekday: Weekday.values[index],
                            ),
                          ),
                        );
                      },
                      onLongPress: (details, context) {},
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: Text("Something really went wrong"),
          );
        },
      ),
    );
  }
}
