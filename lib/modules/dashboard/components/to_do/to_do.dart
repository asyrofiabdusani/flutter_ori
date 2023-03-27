import 'package:flutter/material.dart';
import 'package:flutter_ori/tokens/dart/dart_color.dart';
import 'package:flutter_ori/tokens/dart/dart_font.dart';
import 'package:flutter_ori/tokens/dart/dart_text.dart';
import 'package:flutter_ori/widgets/table/paginated_2.dart';
import 'package:flutter_ori/widgets/table/paginated_3.dart';
import 'package:flutter_ori/widgets/table/paginated_1.dart';
import 'package:flutter_ori/bloc/to_do_menu.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToDoWg extends StatelessWidget {
  const ToDoWg({super.key});

  @override
  Widget build(BuildContext context) {
    TodoMenuCubit todoMenu = BlocProvider.of(context);

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
                    BlocBuilder(
                      bloc: todoMenu,
                      builder: (context, state) {
                        return Row(
                          children: [
                            //? to do menus
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: FilledButton(
                                onPressed: () {
                                  todoMenu.changeState(1);
                                },
                                style: state == 1
                                    ? ButtonStyle(
                                        backgroundColor:
                                            const MaterialStatePropertyAll(
                                                adrColor
                                                    .backgroundPrimaryContainer),
                                        foregroundColor:
                                            const MaterialStatePropertyAll(
                                                adrColor.textButtonPrimary),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: const BorderSide(
                                                width: 1,
                                                color:
                                                    adrColor.backgroundPrimary),
                                          ),
                                        ),
                                      )
                                    : ButtonStyle(
                                        backgroundColor:
                                            const MaterialStatePropertyAll(
                                                adrColor.backgroundBaseLight),
                                        foregroundColor:
                                            const MaterialStatePropertyAll(
                                                adrColor.textButtonPrimary),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: const BorderSide(
                                                width: 1,
                                                color: adrColor.borderBase),
                                          ),
                                        ),
                                      ),
                                child: const Text(
                                  adrText.main_dashboard_to_do_list1,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: FilledButton(
                                onPressed: () {
                                  todoMenu.changeState(2);
                                },
                                style: state == 2
                                    ? ButtonStyle(
                                        backgroundColor:
                                            const MaterialStatePropertyAll(
                                                adrColor
                                                    .backgroundPrimaryContainer),
                                        foregroundColor:
                                            const MaterialStatePropertyAll(
                                                adrColor.textButtonPrimary),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: const BorderSide(
                                                width: 1,
                                                color:
                                                    adrColor.backgroundPrimary),
                                          ),
                                        ),
                                      )
                                    : ButtonStyle(
                                        backgroundColor:
                                            const MaterialStatePropertyAll(
                                                adrColor.backgroundBaseLight),
                                        foregroundColor:
                                            const MaterialStatePropertyAll(
                                                adrColor.textButtonPrimary),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: const BorderSide(
                                                width: 1,
                                                color: adrColor.borderBase),
                                          ),
                                        ),
                                      ),
                                child: const Text(
                                  adrText.main_dashboard_to_do_list2,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: FilledButton(
                                onPressed: () {
                                  todoMenu.changeState(3);
                                },
                                style: state == 3
                                    ? ButtonStyle(
                                        backgroundColor:
                                            const MaterialStatePropertyAll(
                                                adrColor
                                                    .backgroundPrimaryContainer),
                                        foregroundColor:
                                            const MaterialStatePropertyAll(
                                                adrColor.textButtonPrimary),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: const BorderSide(
                                                width: 1,
                                                color:
                                                    adrColor.backgroundPrimary),
                                          ),
                                        ),
                                      )
                                    : ButtonStyle(
                                        backgroundColor:
                                            const MaterialStatePropertyAll(
                                                adrColor.backgroundBaseLight),
                                        foregroundColor:
                                            const MaterialStatePropertyAll(
                                                adrColor.textButtonPrimary),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: const BorderSide(
                                                width: 1,
                                                color: adrColor.borderBase),
                                          ),
                                        ),
                                      ),
                                child: const Text(
                                  adrText.main_dashboard_to_do_list3,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: FilledButton(
                                onPressed: () {
                                  todoMenu.changeState(4);
                                },
                                style: state == 4
                                    ? ButtonStyle(
                                        backgroundColor:
                                            const MaterialStatePropertyAll(
                                                adrColor
                                                    .backgroundPrimaryContainer),
                                        foregroundColor:
                                            const MaterialStatePropertyAll(
                                                adrColor.textButtonPrimary),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: const BorderSide(
                                                width: 1,
                                                color:
                                                    adrColor.backgroundPrimary),
                                          ),
                                        ),
                                      )
                                    : ButtonStyle(
                                        backgroundColor:
                                            const MaterialStatePropertyAll(
                                                adrColor.backgroundBaseLight),
                                        foregroundColor:
                                            const MaterialStatePropertyAll(
                                                adrColor.textButtonPrimary),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: const BorderSide(
                                                width: 1,
                                                color: adrColor.borderBase),
                                          ),
                                        ),
                                      ),
                                child: const Text(
                                  adrText.main_dashboard_to_do_list4,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: FilledButton(
                                onPressed: () {
                                  todoMenu.changeState(5);
                                },
                                style: state == 5
                                    ? ButtonStyle(
                                        backgroundColor:
                                            const MaterialStatePropertyAll(
                                                adrColor
                                                    .backgroundPrimaryContainer),
                                        foregroundColor:
                                            const MaterialStatePropertyAll(
                                                adrColor.textButtonPrimary),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: const BorderSide(
                                                width: 1,
                                                color:
                                                    adrColor.backgroundPrimary),
                                          ),
                                        ),
                                      )
                                    : ButtonStyle(
                                        backgroundColor:
                                            const MaterialStatePropertyAll(
                                                adrColor.backgroundBaseLight),
                                        foregroundColor:
                                            const MaterialStatePropertyAll(
                                                adrColor.textButtonPrimary),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: const BorderSide(
                                                width: 1,
                                                color: adrColor.borderBase),
                                          ),
                                        ),
                                      ),
                                child: const Text(
                                  adrText.main_dashboard_to_do_list5,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: FilledButton(
                                onPressed: () {
                                  todoMenu.changeState(6);
                                },
                                style: state == 6
                                    ? ButtonStyle(
                                        backgroundColor:
                                            const MaterialStatePropertyAll(
                                                adrColor
                                                    .backgroundPrimaryContainer),
                                        foregroundColor:
                                            const MaterialStatePropertyAll(
                                                adrColor.textButtonPrimary),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: const BorderSide(
                                                width: 1,
                                                color:
                                                    adrColor.backgroundPrimary),
                                          ),
                                        ),
                                      )
                                    : ButtonStyle(
                                        backgroundColor:
                                            const MaterialStatePropertyAll(
                                                adrColor.backgroundBaseLight),
                                        foregroundColor:
                                            const MaterialStatePropertyAll(
                                                adrColor.textButtonPrimary),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: const BorderSide(
                                                width: 1,
                                                color: adrColor.borderBase),
                                          ),
                                        ),
                                      ),
                                child: const Text(
                                  adrText.main_dashboard_to_do_list6,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),

              //? searching in to do
              Expanded(
                flex: 1,
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.search)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.all(0),
                  ),
                ),
              ),
            ],
          ),
        ),

        //? table content
        BlocBuilder(
          bloc: todoMenu,
          builder: (context, state) {
            return Column(
              children: [
                if (state == 1) ...[
                  const PaginatedFirst(),
                ] else if (state == 2) ...[
                  const PaginatedSecond(),
                ] else if (state == 3) ...[
                  const PaginatedSecond(),
                ] else if (state == 4) ...[
                  const PaginatedThird(),
                ] else if (state == 5) ...[
                  const PaginatedThird(),
                ] else if (state == 6) ...[
                  const PaginatedSecond(),
                ],
              ],
            );
          },
        ),
      ],
    );
  }
}
