import 'package:flutter/material.dart';
import 'package:meal_planner/screens/meals_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int tab = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(title: Text(tab == 0 ? "Recipes" : "Week")),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {},
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
        body: const MealsScreen(),
      ),
    );
  }
}
