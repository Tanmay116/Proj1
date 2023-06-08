import 'package:flutter/material.dart';
import 'package:proj1/models/Product.dart';
import 'package:proj1/screens/details/details_screen.dart';
import 'package:proj1/screens/home/components/product_card.dart';


class RecommendedProducts extends StatelessWidget {
  const RecommendedProducts({
    super.key,
    required this.products,
  });
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double orientation = MediaQuery.of(context).size.aspectRatio;
    double defaultSize =
        checkOrientation(orientation) ? height * 0.024 : width * 0.024;
    return Padding(
      padding: EdgeInsets.all(defaultSize * 2),
      // Turn off GridView Scrolling
      child: GridView.builder(
          shrinkWrap: true,
          itemCount: products.length,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: checkOrientation(orientation) ? 4 : 2,
              childAspectRatio: 0.693,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20),
          itemBuilder: (context, index) =>
              ProductCard(product: products[index], press: () { Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(product: products[index]),));})),
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