import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ori/tokens/dart/dart_color.dart';
import 'package:flutter_ori/tokens/dart/dart_size.dart';
import 'package:flutter_ori/tokens/dart/dart_font.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'SidebarListTile.dart';

class AccordionMenu extends StatefulWidget {
  final String title;
  final String icon;

  const AccordionMenu({super.key, required this.title, required this.icon});

  @override
  State<AccordionMenu> createState() => _AccordionMenuState();
}

class _AccordionMenuState extends State<AccordionMenu> {
  bool _showContent = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(adrSize.buttonRadius - 15)),
          width: 300,
          child: ListTile(
            onTap: () {
              setState(() {
                _showContent = !_showContent;
              });
            },
            contentPadding: EdgeInsets.only(left: 20),
            title: Text(
              widget.title,
              style: TextStyle(
                fontSize: 15,
                color: adrColor.textSidebar,
              ),
            ),
            leading: SvgPicture.asset(
              widget.icon,
              color: adrColor.textSidebar,
              height: 16,
            ),
            trailing: Icon(
              _showContent
                  ? Icons.keyboard_arrow_down
                  : Icons.keyboard_arrow_right,
              color: adrColor.textSidebar,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        _showContent
            ? Container(
                child: Align(
                child: Column(children: [
                  SidebarListTile(
                    status: "active",
                    title: "Input Claim",
                    icon: "icons/claim.svg",
                    level: 2,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SidebarListTile(
                    title: "Monitoring Claim",
                    icon: "icons/monitor.svg",
                    level: 2,
                  ),
                ]),
              ))
            : Container()
      ],
    );
  }
}
