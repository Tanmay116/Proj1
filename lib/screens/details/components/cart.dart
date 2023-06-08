import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proj1/constants.dart';

class CartPage extends StatelessWidget {
  CartPage({
    super.key,
  });
  final database = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    final prods = database.child('Products/');
    // List carts;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double orientation = MediaQuery.of(context).size.aspectRatio;
    double defaultSize =
        checkOrientation(orientation) ? height * 0.024 : width * 0.024;
    return Scaffold(
      appBar: buildAppBar(context, defaultSize),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //  ElevatedButton(onPressed: null, child: Text('remove')),
            StreamBuilder(
              stream: database
                  .child('Products')
                  .orderByKey()
                  .limitToLast(10)
                  .onValue,
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if (snapshot.hasData) {
                  Map<dynamic, dynamic> map =
                      snapshot.data?.snapshot.value as dynamic;
                  List<dynamic> list = [];
                  list.clear();
                  list = map.values.toList();
                  // print(prods.onValue);
                  return
                      // Text('hii');
                      ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.snapshot.children.length,
                    itemBuilder: (context, index) {
                      // print(snapshot.data?.snapshot.value.runtimeType);
                      return ListTile(
                        leading: Image.network(list[index]['image']),
                        title: Text(list[index]['title']),
                        trailing:
                            Text("\$${(list[index]['price']).toString()}"),
                        minVerticalPadding: defaultSize * 2,
                        shape: const BeveledRectangleBorder(),
                        minLeadingWidth: 10,
                        // contentPadding: EdgeInsets.all(defaultSize / 1.5),
                        tileColor: kSecondaryColor,
                      );
                      // print(list[1]['title']);
                    },
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

AppBar buildAppBar(BuildContext context, double defaultSize) {
  return AppBar(
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: SvgPicture.asset('assets/icons/arrow-long-left.svg')),
    actions: <Widget>[
      // IconButton(
      //     onPressed: () => Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (BuildContext context) => CartPage(),
      //         )),
      //     icon: SvgPicture.asset('assets/icons/bag.svg')),
      SizedBox(
        width: defaultSize,
      )
    ],
  );
}

bool checkOrientation(orientation) {
  if (orientation > 1) {
    return true;
  } else {
    return false;
  }
}
