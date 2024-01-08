import 'package:flutter/material.dart';
import 'package:meal_planner/screens/recipes_screen.dart';
import 'package:meal_planner/screens/week_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int tab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tab == 0 ? "Recipes" : "Week")),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tab,
        onTap: (value) {
          setState(() {
            tab = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: "Meals",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_document),
            label: "Plan",
          ),
        ],
      ),
      body: tab == 0 ? const MealsScreen() : const WeekScreen(),
    );
  }
}
