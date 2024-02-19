import 'package:flutter/material.dart';

import 'package:meal_planner/screens/tab_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color.fromARGB(255, 109, 40, 215),
          onPrimary: Colors.white,
          secondary: Color.fromARGB(255, 215, 109, 40),
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          background: Color.fromARGB(255, 22, 22, 22),
          onBackground: Colors.white,
          surface: Color.fromARGB(255, 20, 20, 20),
          onSurface: Colors.white,
          surfaceTint: Color.fromARGB(255, 255, 255, 255),
          tertiary: Color.fromARGB(255, 40, 215, 109),
        ),
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: const Color.fromARGB(255, 22, 22, 22),
        ),
      ),
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color.fromARGB(255, 109, 40, 215),
          onPrimary: Color.fromARGB(255, 255, 255, 255),
          secondary: Color.fromARGB(255, 215, 109, 40),
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          background: Colors.white,
          onBackground: Color.fromARGB(255, 0, 0, 0),
          surface: Color.fromARGB(255, 241, 241, 241),
          onSurface: Color.fromARGB(255, 0, 0, 0),
          surfaceTint: Color.fromARGB(255, 27, 27, 27),
          tertiary: Color.fromARGB(255, 40, 215, 109),
        ),
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: Colors.white,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          unselectedItemColor: Color.fromARGB(255, 68, 68, 68),
        ),
      ),
      home: const TabScreen(),
    );
  }
}
