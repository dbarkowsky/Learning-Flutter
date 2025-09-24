import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_details_screen.dart';
import 'package:meals_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  final String? title;
  final List<Meal> meals;

  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
  });

  @override
  Widget build(BuildContext context) {
    void selectMeal(Meal meal) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => MealDetailsScreen(
            meal: meal,
          ),
        ),
      );
    }

    if (meals.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(title ?? 'Meals')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "No meals found.",
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary.withAlpha(200),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Try selecting a different category or adjusting filters.",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary.withAlpha(200),
                ),
                softWrap: true,
              ),
            ],
          ),
        ),
      );
    }

    Widget content = ListView.builder(
      itemBuilder: (ctx, index) =>
          MealItem(meal: meals[index], onSelectMeal: selectMeal),
      itemCount: meals.length,
    );

    if (title == null) {
      return content;
    }
    // Use the scaffold for screens
    return Scaffold(
      appBar: AppBar(title: Text(title!)),
      body: content,
    );
  }
}
