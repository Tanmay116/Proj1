import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:proj1/models/Product.dart';
import 'package:proj1/models/cart_items.dart';

import '../../../constants.dart';

class ProductDescription extends StatelessWidget {
  ProductDescription({super.key, required this.product, required this.press});

  final Product product;
  final Function press;
  final database = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    // final prod = database.child('Products');
    List cartItems = [];
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double orientation = MediaQuery.of(context).size.aspectRatio;
    double defaultSize =
        checkOrientation(orientation) ? height * 0.024 : width * 0.024;
    return Container(
      constraints: BoxConstraints(minHeight: defaultSize * 44),
      padding: EdgeInsets.only(
        top: defaultSize * 9, //90
        left: defaultSize * 2, //20
        right: defaultSize * 2,
      ),
      // height: 500,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(defaultSize * 1.2),
          topRight: Radius.circular(defaultSize * 1.2),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              product.subTitle,
              style: TextStyle(
                fontSize: defaultSize * 1.8,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: defaultSize * 3),
            Text(
              product.description,
              style: TextStyle(
                color: kTextColor.withOpacity(0.7),
                height: 1.5,
              ),
            ),
            SizedBox(height: defaultSize * 3),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  // padding: EdgeInsets.all(defaultSize * 1.5),
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.all(defaultSize * 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      backgroundColor: kPrimaryColor),

                  onPressed: () {
                    cartItems.add(product);
                    itemsList(cartItems);
                    // prod.child(product.title).set({'title': product.title});
                    _addproducts(product);
                    // print(cartItems);
                  },
                  child: Text(
                    "Add to Cart",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: defaultSize * 1.6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  // padding: EdgeInsets.all(defaultSize * 1.5),
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.all(defaultSize * 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      backgroundColor: kPrimaryColor),

                  onPressed: () {
                    cartItems.remove(product);
                    itemsList(cartItems);
                    _removeproducts(product);
                    // print(cartItems);
                  },
                  child: Text(
                    "Add to Cart",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: defaultSize * 1.6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _addproducts(Product selectedProduct) {
    final prods = database.child('Products');
    prods.child(selectedProduct.title).set({
      'title': selectedProduct.title,
      'image': selectedProduct.image,
      'price': selectedProduct.price,
      'category': selectedProduct.category,
      'subTitle': selectedProduct.subTitle,
      'description': selectedProduct.description,
    });
  }

  _removeproducts(Product selectedProduct) {
    final prods = database.child('Products');
    prods.child(selectedProduct.title).remove();
  }
}

bool checkOrientation(orientation) {
  if (orientation > 1) {
    return true;
  } else {
    return false;
  }
}
