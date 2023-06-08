// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proj1/models/rive_asset.dart';
import 'package:proj1/screens/home/components/SideMenu/info_card.dart';
import 'package:proj1/screens/home/components/SideMenu/side_menu_tile.dart';
import 'package:rive/rive.dart';

import '../../../../utils/riveutils.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

RiveAsset selectedMenu = sideMenus.first;

class _SideMenuState extends State<SideMenu> {
  late final ValueChanged<Artboard> riveonInit;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        color: const Color(0XFF17203A),
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const InfoCard(name: "Tanmay Mistry", profession: "Student"),
            Padding(
              padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
              child: Text(
                "BROWSE",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.white70),
              ),
            ),
            ...sideMenus.map((menu) => SideMenuTile(
                  menu: menu,
                  riveonInit: (artboard) {
                    // For Animations
                    StateMachineController controller =
                        RiveUtils.getRiveController(artboard,
                            stateMachineName: menu.stateMachineName);
                    menu.input = controller.findSMI("active") as SMIBool;
                  },
                  press: () {
                    menu.input!.change(true);

                    Future.delayed(const Duration(seconds: 1), () {
                      menu.input!.change(false);
                    });
                    setState(() {
                      selectedMenu = menu;
                    });
                  },
                  isActive: selectedMenu == menu,
                )),
            Padding(
              padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
              child: Text(
                "HISTORy",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.white70),
              ),
            ),
            ...sideMenu2.map((menu) => SideMenuTile(
                  menu: menu,
                  riveonInit: (artboard) {
                    // For Animations
                    StateMachineController controller =
                        RiveUtils.getRiveController(artboard,
                            stateMachineName: menu.stateMachineName);
                    menu.input = controller.findSMI("active") as SMIBool;
                  },
                  press: () {
                    menu.input!.change(true);

                    Future.delayed(const Duration(seconds: 1), () {
                      menu.input!.change(false);
                    });
                    setState(() {
                      selectedMenu = menu;
                    });
                  },
                  isActive: selectedMenu == menu,
                )),
          ],
        )),
      ),
    ));
  }
}
