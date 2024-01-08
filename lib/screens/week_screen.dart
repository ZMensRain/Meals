import 'package:flutter/material.dart';
import 'package:meal_planner/model/meal.dart';
import 'package:meal_planner/screens/weekday_screen.dart';
import 'package:meal_planner/widgets/weekday_card.dart';

const weekdays = [
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
  "Sunday"
];

class WeekScreen extends StatelessWidget {
  const WeekScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: weekdays.length,
      itemBuilder: (context, index) => WeekdayCard(
        weekdays[index],
        [
          Recipe(
            caloriesPerServing: 100,
            servingSize: 4,
            title: "Mac and Cheese",
            ingredients: [
              Ingredient("eggs", Units.amount, amount: 3),
              Ingredient("sugar", Units.g, amount: 100),
              Ingredient("water", Units.l, amount: 0.954),
            ],
            instructions: [
              "First",
              "Second",
              "Third",
              "First",
              "Second",
              "Third",
              "First",
              "Second",
              "Third",
              "First",
              "Second",
              "Third",
              "First",
              "Second",
              "Third",
              "First",
              "Second",
              "Third",
              "First",
              "Second",
              "Third",
              "First",
              "Second",
              "Third",
              "First",
              "Second",
              "Third",
              "First",
              "Second",
              "Third",
              "First",
              "Second",
              "Third",
              "First",
              "Second",
              "Third",
              "First",
              "Second",
              "Third",
              "First",
              "Second",
              "Third",
              "First",
              "Second",
              "Third",
              "First",
              "Second",
              "Third",
            ],
            prepTime: const Duration(minutes: 61),
            cookTime: const Duration(minutes: 60),
            tags: [
              "cheese",
              "easy",
              "cheese",
              "easy",
            ],
            imageUrl:
                "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.zupans.com%2Fapp%2Fuploads%2F2020%2F05%2FiStock-174990644-4096x2731.jpg&f=1&nofb=1&ipt=e3bee05db5e34ff3f50dd99a6346f6e096d69afe0f8169c94502b17fe3eb0655&ipo=images",
          ),
        ],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WeekdayScreen(
                recipes: [],
              ),
            ),
          );
        },
      ),
    );
  }
}
