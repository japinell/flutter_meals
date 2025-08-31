import "package:flutter/material.dart";
import "package:flutter_meals/models/meal.dart";
import "package:flutter_meals/screens/categories.dart";
import "package:flutter_meals/screens/filters.dart";
import "package:flutter_meals/screens/meals.dart";
import "package:flutter_meals/widgets/meal_drawer.dart";

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleFavoriteMeal(Meal meal) {
    final toggleFavorite = _favoriteMeals.contains(meal);

    if (toggleFavorite) {
      setState(() {
        _favoriteMeals.remove(meal);
        _showInfoMessage("${meal.title} removed from favorites.");
      });
    } else {
      setState(() {
        _favoriteMeals.add(meal);
        _showInfoMessage("${meal.title} added to favorites.");
      });
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _selectScreen(String id) async {
    Navigator.of(context).pop();
    if (id == "filter") {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(builder: (context) => FiltersScreen()),
      );

      print(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(onToggleFavorite: _toggleFavoriteMeal);
    var activePageTitle = "Categories";

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleFavoriteMeal,
      );
      activePageTitle = "Favorites";
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      drawer: MealDrawer(onSelectScreen: _selectScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: "Categories",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
        ],
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
      ),
    );
  }
}
