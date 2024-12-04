import 'package:flutter/material.dart';

class CategoryGrid extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const CategoryGrid({super.key, 
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.0,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return GestureDetector(
          onTap: () {
            onCategorySelected(category);
          },
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: selectedCategory == category
                    ? Colors.red
                    : Colors.orange[200],
                radius: 20,
                child: const Icon(Icons.category, color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                category,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color:
                      selectedCategory == category ? Colors.red : Colors.black,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
