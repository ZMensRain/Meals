import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:meal_planner/helper/isar.dart';
import 'package:meal_planner/model/meal.dart';
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
  @override
  void initState() {
    super.initState();
    getIsar().then((value) {
      isar = value;
      setState(() {
        week = isar.weeks.getSync(1)!;
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

  Week week = Week();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            var ing = await week.getIngredients();
            print(ing);
          },
          child: const Text(""),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: Weekday.values.length,
            itemBuilder: (context, index) => WeekdayCard(
              Weekday.values[index].name.capitalize(),
              getRecipesFromId(week.getRecipeIds(Weekday.values[index])),
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
}
