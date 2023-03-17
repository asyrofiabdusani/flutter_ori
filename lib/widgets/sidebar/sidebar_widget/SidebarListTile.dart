import 'package:flutter/material.dart';
import 'package:flutter_ori/tokens/dart/dart_color.dart';
import 'package:flutter_ori/tokens/dart/dart_size.dart';
import 'package:flutter_ori/tokens/dart/dart_font.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SidebarListTile extends StatelessWidget {
  String status = "";
  String title;
  String icon;
  int level = 1;

  SidebarListTile({
    super.key,
    this.status = "nonactive",
    required this.title,
    required this.icon,
    this.level = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: status == "active"
              ? adrColor.backgroundButtonDarkActive
              : Colors.transparent,
          borderRadius: BorderRadius.circular(adrSize.buttonRadius - 15)),
      width: 300,
      child: ListTile(
        onTap: () {},
        contentPadding:
            EdgeInsets.only(left: level > 1 ? (level * 5) + 20 : 20),
        title: Text(
          this.title,
          style: TextStyle(
            fontSize: 15,
            color: status == "active" ? Colors.white : adrColor.textSidebar,
          ),
        ),
        leading: SvgPicture.asset(
          this.icon,
          color: status == "active" ? Colors.white : adrColor.textSidebar,
          height: 16,
        ),
      ),
    );
  }
}
