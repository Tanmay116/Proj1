import 'package:flutter/material.dart';
import 'package:proj1/screens/home/components/category_card.dart';

class Categories extends StatelessWidget {
  const Categories({
    super.key,
    required this.categories,
  });
  final List<dynamic> categories;
  @override
  Widget build(BuildContext context) {
    // print(((categories[1] as List<dynamic>)as Category).runtimeType);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: List.generate(categories.length,
              (index) => CategoryCard(category: categories[index]))),
    );
  }
}

bool checkOrientation(orientation) {
  if (orientation > 1) {
    return true;
  } else {
    return false;
  }
}