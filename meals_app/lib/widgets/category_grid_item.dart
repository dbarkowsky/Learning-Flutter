import 'package:flutter/material.dart';
import 'package:meals_app/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  final Category category;
  final void Function() onSelectCategory;
  const CategoryGridItem({super.key, required this.category, required this.onSelectCategory});

  @override
  Widget build(BuildContext context) {
    // Why InkWell?
    // InkWell provides a Material ripple effect when tapped.
    return InkWell(
      onTap: onSelectCategory,
      splashColor: Theme.of(context).colorScheme.primary, // tap effect color
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              category.color.withAlpha(255),
              category.color.withAlpha(200),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
    );
  }
}
