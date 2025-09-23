import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favouriteMeals = [];

  void _toggleMealFavouriteStatus(Meal meal) {
    final isExisting = _favouriteMeals.contains(meal);

    setState(() {
      if (isExisting) {
        _favouriteMeals.remove(meal);
        _showMessage('Meal removed from favourites.');
      } else {
        _favouriteMeals.add(meal);
        _showMessage('Meal added to favourites.');
      }
    });
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) {
    // Close drawer manually
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      onToggleFavourite: _toggleMealFavouriteStatus,
    );
    String activePageTitle = 'Categories';
    switch (_selectedPageIndex) {
      case 0:
        activePage = CategoriesScreen(
          onToggleFavourite: _toggleMealFavouriteStatus,
        );
        activePageTitle = 'Categories';
        break;
      case 1:
        activePage = MealsScreen(
          meals: _favouriteMeals,
          onToggleFavourite: _toggleMealFavouriteStatus,
        );
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
