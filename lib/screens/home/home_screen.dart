import 'dart:math';
import 'package:flutter/material.dart';
import 'package:proj1/screens/home/components/SideMenu/sidemenu.dart';
import 'package:proj1/screens/home/components/body.dart';
import 'package:rive/rive.dart';
import '../../models/menu_btn.dart';
import '../../utils/riveutils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

late SMIBool isSideBarClosed;
bool isSideMenuClosed = true;

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scalAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(
        () {
          setState(() {});
        },
      );
    scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Helps to make responsive
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    // double orientation = MediaQuery.of(context).size.aspectRatio;
    // double defaultSize =
    //     checkOrientation(orientation) ? height * 0.024 : width * 0.024;
    // print("aspect ratio =  $orientation");

    return Scaffold(
      backgroundColor: const Color(0XFF17203A),
      // floatingActionButton: ElevatedButton(
      //     onPressed: () {
      //       Navigator.of(context).push(MaterialPageRoute(
      //         builder: (context) => Dummy(),
      //       ));
      //     },
      //     child: Icon(Icons.add)),
      // appBar: buildAppBar(defaultSize, context),
      body: Stack(children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 200),
          curve: Curves.fastOutSlowIn,
          width: 288,
          left: isSideMenuClosed ? -288 : 0,
          height: MediaQuery.of(context).size.height,
          child: const SideMenu(),
        ),
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(animation.value - 30 * animation.value * pi / 180),
          child: Transform.translate(
            offset: Offset(animation.value * 265, 0),
            child: Transform.scale(
                scale: scalAnimation.value,
                child: const ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                    child: Body())),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 200),
          left: isSideMenuClosed ? 0 : 220,
          child: MenuBtn(
            riveonInit: (artboard) {
              StateMachineController controller = RiveUtils.getRiveController(
                artboard,
                stateMachineName: "State Machine",
              );
              isSideBarClosed = controller.findSMI("isOpen") as SMIBool;
              isSideBarClosed.value = true;
            },
            press: () {
              isSideBarClosed.value = !isSideBarClosed.value;
              if (isSideMenuClosed) {
                _animationController.forward();
              } else {
                _animationController.reverse();
              }
              setState(() {
                isSideMenuClosed = isSideBarClosed.value;
              });
            },
          ),
        ),
        // isSideMenuClosed
        //     ? AnimatedPositioned(
        //         left: 360,
        //         child: Icon(Icons.add),
        //         duration: Duration(milliseconds: 200))
        //     : SizedBox()
      ]),
    );
  }
}

// bool checkOrientation(orientation) {
//   if (orientation > 1) {
//     return true;
//   } else {
//     return false;
//   }
// }