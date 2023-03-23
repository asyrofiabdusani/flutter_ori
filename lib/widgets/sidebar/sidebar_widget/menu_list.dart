import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_ori/tokens/dart/dart_color.dart';
import 'package:flutter_ori/tokens/dart/dart_size.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'SidebarListTile.dart';
import 'package:flutter_ori/tokens/dart/dart_text.dart';

class MenuList extends StatefulWidget {
  const MenuList({super.key});

  @override
  State<MenuList> createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  bool _showContent = false;
  List path = Uri.base.toString().split('/');

  @override
  Widget build(BuildContext context) {
    List lastElement = path[path.length - 1].toString().split('?');
    String lastPath = lastElement[0];

    return Column(
      children: [
        SidebarListTile(
          status: lastPath == 'dashboard' ? 'active' : 'nonactive',
          title: adrText.menu1,
          icon: "icons/Home.svg",
          route: 'dashboard',
        ),
        const SizedBox(
          height: 10,
        ),
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
            contentPadding: const EdgeInsets.only(left: 20),
            title: const Text(
              adrText.menu2,
              style: TextStyle(
                fontSize: 15,
                color: adrColor.textSidebar,
              ),
            ),
            leading: SvgPicture.asset(
              'icons/insuranceclaim.svg',
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
        const SizedBox(
          height: 10,
        ),
        _showContent || lastPath == 'claim_asuransi' || lastPath == ''
            ? Container(
                child: Align(
                  child: Column(
                    children: [
                      SidebarListTile(
                        status: lastPath == 'claim_asuransi'
                            ? 'active'
                            : 'nonactive',
                        title: adrText.menu2_1,
                        icon: "icons/claim.svg",
                        level: 2,
                        route: 'claim_asuransi',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SidebarListTile(
                        // status: widget.route == '' ? 'active' : 'nonactive',
                        title: adrText.menu2_2,
                        icon: "icons/monitor.svg",
                        level: 2,
                        route: '',
                      ),
                    ],
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}
