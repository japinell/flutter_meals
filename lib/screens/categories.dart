import "package:flutter/material.dart";
import "package:flutter_meals/data/dummy_data.dart";
import "package:flutter_meals/widgets/categories_grid_item.dart";

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Categories")),
      body: GridView(
        padding: EdgeInsets.all(24),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columns
          childAspectRatio: 3 / 2, // 3 : 2 ratio
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            CategoriesGridItem(category: category),
        ],
      ),
    );
  }
}
