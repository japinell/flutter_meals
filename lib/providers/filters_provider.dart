import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_meals/providers/meals_provider.dart";

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
    : super({
        Filter.glutenFree: false,
        Filter.lactoseFree: false,
        Filter.vegetarian: false,
        Filter.vegan: false,
      });

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }

  void setFilters(Map<Filter, bool> filters) {
    state = filters;
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
      (ref) => FiltersNotifier(),
    );

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final mealPreferences = ref.watch(filtersProvider);

  return meals.where((meal) {
    if (mealPreferences[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (mealPreferences[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (mealPreferences[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (mealPreferences[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
