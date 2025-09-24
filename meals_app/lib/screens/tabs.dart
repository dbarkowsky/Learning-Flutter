import 'package:flutter/material.dart';
import 'package:meals_app/providers/favourites_provider.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/meals_provider.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  Map<Filter, bool> _selectedFilters = {
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false,
  };

  // Replaced by Riverpod state management
  // final List<Meal> _favouriteMeals = [];

  // void _toggleMealFavouriteStatus(Meal meal) {
  //   final isExisting = _favouriteMeals.contains(meal);

  //   setState(() {
  //     if (isExisting) {
  //       _favouriteMeals.remove(meal);
  //       _showMessage('Meal removed from favourites.');
  //     } else {
  //       _favouriteMeals.add(meal);
  //       _showMessage('Meal added to favourites.');
  //     }
  //   });
  // }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    // Close drawer manually
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      // Result gets the data popped from the FiltersScreen
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(currentFilters: _selectedFilters),
        ),
      );
      setState(() {
        // If the result is null, do not update filters
        if (result == null) {
          return;
        }
        _selectedFilters = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dummyMeals = ref.watch(mealsProvider);
    final availableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(availableMeals: availableMeals);
    String activePageTitle = 'Categories';
    switch (_selectedPageIndex) {
      case 0:
        activePage = CategoriesScreen(availableMeals: availableMeals);
        activePageTitle = 'Categories';
        break;
      case 1:
        activePage = MealsScreen(meals: ref.watch(favouritesProvider));
        activePageTitle = 'Favourites';
        break;
      default:
        break;
    }
    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favourites'),
        ],
        onTap: (index) {
          _selectPage(index);
        },
        currentIndex: _selectedPageIndex,
      ),
    );
  }
}
