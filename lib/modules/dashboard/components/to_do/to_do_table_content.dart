import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ori/bloc/to_do_menu.dart';
import 'table_1.dart';
import 'table_2.dart';
import 'table_3.dart';
import 'package:flutter_ori/widgets/table/styled_paginated_table.dart';

class ToDoTableContent extends StatelessWidget {
  const ToDoTableContent({super.key});

  @override
  Widget build(BuildContext context) {
    TodoMenuCubit todoMenu = BlocProvider.of(context);
    return BlocBuilder(
      bloc: todoMenu,
      builder: (context, state) {
        return Column(
          children: [
            if (state == 1) ...[
              StyledPaginatedTable(
                  columns: headDataColumnFirst(),
                  rows: TableRowFirst(),
                  rowPerPage: 5),
            ] else if (state == 2) ...[
              StyledPaginatedTable(
                  columns: headDataColumnSecond(),
                  rows: TableRowSecond(),
                  rowPerPage: 5),
            ] else if (state == 3) ...[
              StyledPaginatedTable(
                  columns: headDataColumnSecond(),
                  rows: TableRowSecond(),
                  rowPerPage: 5),
            ] else if (state == 4) ...[
              StyledPaginatedTable(
                  columns: headDataColumnThird(),
                  rows: TableRowThird(),
                  rowPerPage: 5),
            ] else if (state == 5) ...[
              StyledPaginatedTable(
                  columns: headDataColumnThird(),
                  rows: TableRowThird(),
                  rowPerPage: 5),
            ] else if (state == 6) ...[
              StyledPaginatedTable(
                  columns: headDataColumnSecond(),
                  rows: TableRowSecond(),
                  rowPerPage: 5),
            ],
          ],
        );
      },
    );
  }
}
