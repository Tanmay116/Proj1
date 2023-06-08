import 'package:flutter/material.dart';
import 'package:proj1/screens/home/components/categories.dart';
import 'package:proj1/screens/home/components/img_picker.dart';
import 'package:proj1/screens/home/components/recommended_products.dart';
import 'package:proj1/screens/home/components/title_text.dart';
import 'package:proj1/services/fetchCategories.dart';
import 'package:proj1/services/fetchProducts.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double orientation = MediaQuery.of(context).size.aspectRatio;
    double defaultSize =
        checkOrientation(orientation) ? height * 0.024 : width * 0.024;
    // enabling scrolling
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 40,
              child: Stack(
                children: [
                  Positioned(
                    left: 360,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PCamera(),
                        ));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0, 3),
                                  blurRadius: 8)
                            ]),
                        child: const Icon(Icons.add_photo_alternate_outlined,
                            color: Colors.black87, size: 32),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(defaultSize * 2), //20
              child: TitleText(
                defaultSize: defaultSize,
                title: 'Browse by Categories',
              ),
            ),
            FutureBuilder(
                future: fetchCategories(),
                builder: (context, AsyncSnapshot snapshot) => snapshot.hasData
                    ? Categories(
                        categories: snapshot.data,
                      )
                    : Center(child: Image.asset('assets/ripple.gif'))),
            const Divider(height: 5),
            Padding(
              padding: EdgeInsets.all(defaultSize * 2), //20
              child: TitleText(
                title: "Recommended  For You",
                defaultSize: defaultSize,
              ),
            ),
            // Right Now product is our demo product
            FutureBuilder(
                future: fetchProducts(),
                builder: (context, AsyncSnapshot snapshot) {
                  // print(snapshot.data);
                  return snapshot.hasData
                      ? RecommendedProducts(products: snapshot.data)
                      : Center(child: Image.asset('assets/ripple.gif'));
                }),
            // ProductCard(product: product, press: () {})
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
