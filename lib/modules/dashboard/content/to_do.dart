import 'package:flutter/material.dart';
import 'package:flutter_ori/tokens/dart/dart_color.dart';
import 'package:flutter_ori/tokens/dart/dart_font.dart';
import 'package:flutter_ori/tokens/dart/dart_text.dart';
import 'package:flutter_ori/widgets/table/paginated_2.dart';
import 'package:flutter_ori/widgets/table/paginated_3.dart';
import 'package:flutter_ori/widgets/table/table_1.dart';
import 'package:flutter_ori/widgets/table/table_2.dart';
import 'package:flutter_ori/widgets/table/table_3.dart';
import 'package:flutter_ori/widgets/table/paginated_1.dart';

class ToDoWg extends StatefulWidget {
  @override
  State<ToDoWg> createState() => _ToDoWgState();
}

class _ToDoWgState extends State<ToDoWg> {
  int activeMenu = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'To Do List',
          style: TextStyle(
              fontSize: adrFont.subtitle2FontSize, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                flex: 3,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: FilledButton(
                              onPressed: () {
                                setState(() {
                                  activeMenu = 0;
                                });
                              },
                              child: const Text(
                                adrText.main_dashboard_to_do_list1,
                                style: TextStyle(fontSize: 12),
                              ),
                              style: activeMenu == 0
                                  ? ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          adrColor.backgroundPrimaryContainer),
                                      foregroundColor: MaterialStatePropertyAll(
                                          adrColor.textButtonPrimary),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                              width: 1,
                                              color:
                                                  adrColor.backgroundPrimary),
                                        ),
                                      ),
                                    )
                                  : ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          adrColor.backgroundBaseLight),
                                      foregroundColor: MaterialStatePropertyAll(
                                          adrColor.textButtonPrimary),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                              width: 1,
                                              color: adrColor.borderBase),
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: FilledButton(
                              onPressed: () {
                                setState(() {
                                  activeMenu = 1;
                                });
                              },
                              child: const Text(
                                adrText.main_dashboard_to_do_list2,
                                style: TextStyle(fontSize: 12),
                              ),
                              style: activeMenu == 1
                                  ? ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          adrColor.backgroundPrimaryContainer),
                                      foregroundColor: MaterialStatePropertyAll(
                                          adrColor.textButtonPrimary),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                              width: 1,
                                              color:
                                                  adrColor.backgroundPrimary),
                                        ),
                                      ),
                                    )
                                  : ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          adrColor.backgroundBaseLight),
                                      foregroundColor: MaterialStatePropertyAll(
                                          adrColor.textButtonPrimary),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                              width: 1,
                                              color: adrColor.borderBase),
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: FilledButton(
                              onPressed: () {
                                setState(() {
                                  activeMenu = 2;
                                });
                              },
                              child: const Text(
                                adrText.main_dashboard_to_do_list3,
                                style: TextStyle(fontSize: 12),
                              ),
                              style: activeMenu == 2
                                  ? ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          adrColor.backgroundPrimaryContainer),
                                      foregroundColor: MaterialStatePropertyAll(
                                          adrColor.textButtonPrimary),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                              width: 1,
                                              color:
                                                  adrColor.backgroundPrimary),
                                        ),
                                      ),
                                    )
                                  : ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          adrColor.backgroundBaseLight),
                                      foregroundColor: MaterialStatePropertyAll(
                                          adrColor.textButtonPrimary),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                              width: 1,
                                              color: adrColor.borderBase),
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: FilledButton(
                              onPressed: () {
                                setState(() {
                                  activeMenu = 3;
                                });
                              },
                              child: const Text(
                                adrText.main_dashboard_to_do_list4,
                                style: TextStyle(fontSize: 12),
                              ),
                              style: activeMenu == 3
                                  ? ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          adrColor.backgroundPrimaryContainer),
                                      foregroundColor: MaterialStatePropertyAll(
                                          adrColor.textButtonPrimary),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                              width: 1,
                                              color:
                                                  adrColor.backgroundPrimary),
                                        ),
                                      ),
                                    )
                                  : ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          adrColor.backgroundBaseLight),
                                      foregroundColor: MaterialStatePropertyAll(
                                          adrColor.textButtonPrimary),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                              width: 1,
                                              color: adrColor.borderBase),
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: FilledButton(
                              onPressed: () {
                                setState(() {
                                  activeMenu = 4;
                                });
                              },
                              child: const Text(
                                adrText.main_dashboard_to_do_list5,
                                style: TextStyle(fontSize: 12),
                              ),
                              style: activeMenu == 4
                                  ? ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          adrColor.backgroundPrimaryContainer),
                                      foregroundColor: MaterialStatePropertyAll(
                                          adrColor.textButtonPrimary),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                              width: 1,
                                              color:
                                                  adrColor.backgroundPrimary),
                                        ),
                                      ),
                                    )
                                  : ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          adrColor.backgroundBaseLight),
                                      foregroundColor: MaterialStatePropertyAll(
                                          adrColor.textButtonPrimary),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                              width: 1,
                                              color: adrColor.borderBase),
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: FilledButton(
                              onPressed: () {
                                setState(() {
                                  activeMenu = 5;
                                });
                              },
                              child: const Text(
                                adrText.main_dashboard_to_do_list6,
                                style: TextStyle(fontSize: 12),
                              ),
                              style: activeMenu == 5
                                  ? ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          adrColor.backgroundPrimaryContainer),
                                      foregroundColor: MaterialStatePropertyAll(
                                          adrColor.textButtonPrimary),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                              width: 1,
                                              color:
                                                  adrColor.backgroundPrimary),
                                        ),
                                      ),
                                    )
                                  : ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          adrColor.backgroundBaseLight),
                                      foregroundColor: MaterialStatePropertyAll(
                                          adrColor.textButtonPrimary),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                              width: 1,
                                              color: adrColor.borderBase),
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon:
                        IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: EdgeInsets.all(0),
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            if (activeMenu == 0) ...[
              const PaginatedFirst(),
            ] else if (activeMenu == 1) ...[
              const PaginatedSecond(),
            ] else if (activeMenu == 2) ...[
              const PaginatedSecond(),
            ] else if (activeMenu == 3) ...[
              const PaginatedThird(),
            ] else if (activeMenu == 4) ...[
              const PaginatedThird(),
            ] else if (activeMenu == 5) ...[
              const PaginatedSecond(),
            ],
          ],
        )
      ],
    );
  }
}
