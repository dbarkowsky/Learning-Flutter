import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/Expenses.dart';

ColorScheme colourScheme = ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 59, 1, 1),
          brightness: Brightness.dark,
        );

ThemeData lightTheme = ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 59, 1, 1),
          brightness: Brightness.light,
        ),
      );

ThemeData darkTheme = ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color.fromARGB(255, 43, 38, 71), // This overrides colour scheme
        // Better to do the entire scheme instead of individual colours
        colorScheme: colourScheme,
        // Or do this to make a specific theme for a widget
        appBarTheme: AppBarTheme().copyWith(
          centerTitle: false,
          backgroundColor: colourScheme.onPrimary
        ),
        // Stylise the cards
        cardTheme: CardThemeData().copyWith(
          color: colourScheme.primaryContainer,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        // Can also target text types
        textTheme: ThemeData.dark().textTheme.copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
            color: colourScheme.onPrimaryContainer,
          ),
        ),
      );

void main() {
  runApp(
    MaterialApp(
      home: Expenses(),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark, // Can be light, dark or system
    ),
  );
}
