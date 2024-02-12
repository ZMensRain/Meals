import 'package:flutter/material.dart';
import 'package:meal_planner/helper/isar.dart';

import 'package:meal_planner/screens/recipes_screen.dart';
import 'package:meal_planner/screens/shopping_list_screen.dart';
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
      appBar: AppBar(
        title: Text(tab == 0 ? "Recipes" : "Week"),
        actions: [
          if (tab == 1)
            IconButton(
              onPressed: () async {
                var week = await getWeek();

                if (context.mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShoppingListScreen(week),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.shopping_cart),
            ),
        ],
      ),
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
