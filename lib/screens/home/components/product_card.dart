import 'package:flutter/material.dart';
import 'package:proj1/constants.dart';
import 'package:proj1/models/Product.dart';
import 'package:proj1/screens/home/components/title_text.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.press,
  });
  final Product product;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double orientation = MediaQuery.of(context).size.aspectRatio;
    double defaultSize =
        checkOrientation(orientation) ? height * 0.024 : width * 0.024;
    return GestureDetector(
      onTap: press,
      child: Container(
        width: defaultSize * 14.5,
        decoration: BoxDecoration(
            color: kSecondaryColor, borderRadius: BorderRadius.circular(30)),
        child: AspectRatio(
            aspectRatio: 0.693,
            child: Column(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1,
                  child: Hero(
                    tag: product.id,
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/spinner.gif',
                      image: product.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: defaultSize),
                  child:
                      TitleText(defaultSize: defaultSize, title: product.title),
                ),
                SizedBox(
                  height: defaultSize / 2,
                ),
                Text("\$${product.price}")
              ],
            )),
      ),
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
