import 'package:flutter/material.dart';
import 'package:flutter_ori/bloc/sidebar_menu.dart';
import 'package:flutter_ori/tokens/dart/dart_color.dart';
import 'sidebar_widget/SidebarListTile.dart';
import 'sidebar_widget/menu_list.dart';
import 'package:flutter_ori/tokens/dart/dart_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SideBar extends StatelessWidget {
  final String route;

  const SideBar({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shadowColor: Colors.transparent,
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
            const MenuList(),
          ],
        ),
      ),
    );
  }
}
