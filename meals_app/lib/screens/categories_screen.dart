import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

import 'meals_screen.dart';

class CategoriesScreen extends StatelessWidget {
    final void Function(Meal meal) onToggleFavourite;

  const CategoriesScreen({super.key, required this.onToggleFavourite});

  void _selectCategory(BuildContext context, String categoryId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: 'Meals',
          // FIXME: This has O(n) complexity, which is not efficient.
          meals: dummyMeals
              .where((meal) => meal.categories.contains(categoryId))
              .toList(),
          onToggleFavourite: onToggleFavourite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            // The wrapping function is needed to pass arguments
            onSelectCategory: () => _selectCategory(context, category.id),
          ),
      ],
    );
  }
}
