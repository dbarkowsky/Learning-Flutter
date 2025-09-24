import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/dummy_data.dart';

// Super simple Provider that works for static data.
// See favourites_provider.dart for a more complex example
final mealsProvider = Provider((ref) => dummyMeals);
