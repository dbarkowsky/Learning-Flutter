import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/favourites_provider.dart';

// ConsumerWidget because Riverpod
class MealDetailsScreen extends ConsumerWidget {
  final Meal meal;


  const MealDetailsScreen({super.key, required this.meal});

   void _showMessage(bool wasAdded, BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(wasAdded ? 'Meal added to favourites.' : 'Meal removed from favourites.')));
  }

  @override
  // Had to add WidgetRef ref for Riverpod
  Widget build(BuildContext context, WidgetRef ref) {
    bool isFavourite = ref.watch(favouritesProvider).contains(meal);
    return Scaffold(
      appBar: AppBar(title: Text(meal.title), actions: [
        IconButton(
          icon: isFavourite ? Icon(Icons.star, color: Colors.orange ) : Icon(Icons.star_border),
          onPressed: () {
            // How to access the provider's notifier and call methods on it
            bool wasAdded = ref.read(favouritesProvider.notifier).toggleMealFavourite(meal);
            _showMessage(wasAdded, context);
          })
      ],),
      body: ListView(
        children: [Column(
          children: [
            Image.network(
              meal.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 14),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            for (final ingredient in meal.ingredients)
              Text(
                ingredient,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            SizedBox(height: 24),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            for (final step in meal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  step,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
          ],
        )],
      ),
    );
  }
}
