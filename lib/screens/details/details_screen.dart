import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proj1/constants.dart';
import 'package:proj1/models/Product.dart';
import 'package:proj1/screens/details/components/body.dart';
import 'package:proj1/screens/details/components/cart.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double orientation = MediaQuery.of(context).size.aspectRatio;
    double defaultSize =
        checkOrientation(orientation) ? height * 0.024 : width * 0.024;
    List cartItems = [];
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: buildAppBar(context, defaultSize, cartItems),
      body: Body(product: product),
    );
  }

  AppBar buildAppBar(BuildContext context, double defaultSize, List cartItems) {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset('assets/icons/arrow-long-left.svg')),
      actions: <Widget>[
        IconButton(
            onPressed: 
            () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => CartPage(),
                )
                ),
            icon: SvgPicture.asset('assets/icons/bag.svg')),
        SizedBox(
          width: defaultSize,
        )
      ],
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
