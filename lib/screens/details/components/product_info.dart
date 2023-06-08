import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proj1/constants.dart';
import 'package:proj1/models/Product.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({
    super.key,
    required this.product,
  });
  final Product product;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double orientation = MediaQuery.of(context).size.aspectRatio;
    double defaultSize =
        checkOrientation(orientation) ? height * 0.024 : width * 0.024;
    TextStyle lightTextStyle = TextStyle(color: kTextColor.withOpacity(0.6));
    return Container(
      padding: EdgeInsets.symmetric(horizontal: defaultSize * 2),
      height: defaultSize * 37.5,
      width: defaultSize * 15,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(product.category.toUpperCase(), style: lightTextStyle),
          SizedBox(height: defaultSize),
          Text(
            product.title,
            style: TextStyle(
              fontSize: defaultSize * 2.4, //24
              fontWeight: FontWeight.bold,
              letterSpacing: -0.8,
              height: 1.4,
            ),
          ),
          SizedBox(height: defaultSize * 2),
          Text("Form", style: lightTextStyle),
          Text(
            "\$${product.price}",
            style: TextStyle(
              fontSize: defaultSize * 1.6, //16
              fontWeight: FontWeight.bold,
              height: 1.6,
            ),
          ),
          SizedBox(height: defaultSize * 2), //20
          Text("Available Colors", style: lightTextStyle),
          Row(
            children: <Widget>[
              buildColorBox(
                defaultSize,
                color: const Color(0xFF7BA275),
                isActive: true,
              ),
              buildColorBox(
                defaultSize,
                color: const Color(0xFFD7D7D7),
              ),
              buildColorBox(
                defaultSize,
                color: kTextColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Container buildColorBox(double defaultSize,
    {required Color color, bool isActive = false}) {
  return Container(
    margin: EdgeInsets.only(top: defaultSize, right: defaultSize),
    // For  fixed value we can use cont for better performance
    padding: const EdgeInsets.all(5),
    height: defaultSize * 2.4,
    width: defaultSize * 2.4,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(6),
    ),
    child: isActive ? SvgPicture.asset("assets/icons/check.svg") : const SizedBox(),
  );
}

bool checkOrientation(orientation) {
  if (orientation > 1) {
    return true;
  } else {
    return false;
  }
}
