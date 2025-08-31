import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_meals/providers/filters_provider.dart";

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealPreferences = ref.watch(filtersProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Meal Preferences")),
      body: Column(
        children: [
          SwitchListTile(
            value: mealPreferences[Filter.glutenFree]!,
            onChanged: (isGlutenFree) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.glutenFree, isGlutenFree);
            },
            title: Text(
              "Gluten-free",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            subtitle: Text(
              "Only include gluten-free meals.",
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: mealPreferences[Filter.lactoseFree]!,
            onChanged: (isLactoseFree) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.lactoseFree, isLactoseFree);
            },
            title: Text(
              "Lactose-free",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            subtitle: Text(
              "Only include lactose-free meals.",
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: mealPreferences[Filter.vegetarian]!,
            onChanged: (isVegetarian) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegetarian, isVegetarian);
            },
            title: Text(
              "Vegetarian",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            subtitle: Text(
              "Only include vegetarian meals.",
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: mealPreferences[Filter.vegan]!,
            onChanged: (isVegan) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegan, isVegan);
            },
            title: Text(
              "Vegan",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            subtitle: Text(
              "Only include vegan meals.",
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: EdgeInsets.only(left: 34, right: 22),
          ),
        ],
      ),
    );
  }
}
