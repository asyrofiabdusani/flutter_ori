import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_ori/tokens/dart/dart_color.dart';
import 'package:flutter_ori/tokens/dart/dart_size.dart';
import 'package:flutter_ori/tokens/dart/dart_font.dart';
import 'sidebar_widget/SidebarListTile.dart';
import 'sidebar_widget/AccordionMenu.dart';
import 'sidebar_widget/AccordionMenu.dart';
import 'package:flutter_ori/tokens/dart/dart_text.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: adrColor.backgroundPrimaryContainer,
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
              child: Image.asset(
                "images/logo-ADMF-background-putih-2x.png",
                width: 150,
              ),
            ),
            SidebarListTile(
              title: adrText.menu1,
              icon: "icons/Home.svg",
            ),
            SizedBox(
              height: 10,
            ),
            AccordionMenu(
              title: adrText.menu2,
              icon: "icons/insuranceclaim.svg",
            ),
          ],
        ),
      ),
    );
  }
}
