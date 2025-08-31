import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_meals/screens/categories.dart";
import "package:flutter_meals/screens/filters.dart";
import "package:flutter_meals/screens/meals.dart";
import "package:flutter_meals/widgets/meal_drawer.dart";
import "package:flutter_meals/providers/meals_provider.dart";
import "package:flutter_meals/providers/favorites_provider.dart";
import "package:flutter_meals/providers/filters_provider.dart";

const defaultPreferences = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  Map<Filter, bool> _mealPreferences = defaultPreferences;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _selectScreen(String id) async {
    Navigator.of(context).pop();
    if (id == "filter") {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (context) =>
              FiltersScreen(currentPreferences: _mealPreferences),
        ),
      );

      setState(() {
        _mealPreferences = result ?? defaultPreferences;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);

    final availableMeals = meals.where((meal) {
      if (_mealPreferences[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_mealPreferences[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_mealPreferences[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_mealPreferences[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(availableMeals: availableMeals);
    var activePageTitle = "Categories";

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);

      activePage = MealsScreen(meals: favoriteMeals);
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
