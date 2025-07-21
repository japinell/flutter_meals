import "package:flutter/material.dart";
import "package:flutter_meals/main.dart";

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Categories")),
      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columns
          childAspectRatio: 3 / 2, // 3 : 2 ratio
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          Text("1", style: TextStyle(color: Colors.white)),
          Text("2", style: TextStyle(color: Colors.white)),
          Text("3", style: TextStyle(color: Colors.white)),
          Text("4", style: TextStyle(color: Colors.white)),
          Text("5", style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
