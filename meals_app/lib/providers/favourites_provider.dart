import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

// Both of these are required to work together
class FavouritesNotifier extends Notifier<List<Meal>> {
  @override
  List<Meal> build() {
    // Initial state
    return [];
  }

  // Return value indicates if the meal was added (true) or removed (false)
  bool toggleMealFavourite(Meal meal) {
    final isExisting = state.contains(meal);

    // Why not .add and .remove?
    // Because state needs to be replaced with a new list when using StateNotifier
    if (isExisting) {
      // state is globally available in the StateNotifier
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

// Provider just returns an instance of the StateNotifier
// This is what you can listen to in your widgets
final favouritesProvider = NotifierProvider<FavouritesNotifier, List<Meal>>(
  FavouritesNotifier.new,
);
