import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

import 'meals_screen.dart';

class CategoriesScreen extends StatefulWidget {
  final List<Meal> availableMeals;

  const CategoriesScreen({super.key, required this.availableMeals});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  // Must initialize in initState
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      // These bounds are default, but we set them explicitly for clarity
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    // Always dispose animation controllers to free resources
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, String categoryId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: availableCategories
              .firstWhere((cat) => cat.id == categoryId)
              .title,
          // FIXME: This has O(n) complexity, which is not efficient.
          meals: widget.availableMeals
              .where((meal) => meal.categories.contains(categoryId))
              .toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      // Child is the part of the widget tree that doesn't change
      child: GridView(
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
      ),
      // The builder is called every time the animation changes
      // So this is where the animation is applied
      // builder: (context, child) => Padding(
      //   // This causes the padding widget to slide up from bottom
      //   padding: EdgeInsets.only(top: 100 - _animationController.value * 100),
      //   child: child,
      // ),
      // This is a more complex animation that combines fade and slide
      builder: (context, child) => SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.5),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        ),
        child: FadeTransition(
          opacity: _animationController,
          child: child,
        ),
      ),
    );
  }
}
