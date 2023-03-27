import 'package:flutter/material.dart';
import 'package:flutter_ori/tokens/dart/dart_color.dart';

class StyledPaginatedTable extends StatefulWidget {
  int? initialFirstRowIndex = 0;
  final List<DataColumn> columns;
  final DataTableSource rows;
  final int rowPerPage;
  List<int>? availableRowsPerPage = [];

  StyledPaginatedTable({
    super.key,
    required this.columns,
    required this.rows,
    required this.rowPerPage,
    this.initialFirstRowIndex,
    this.availableRowsPerPage,
  });

  @override
  State<StyledPaginatedTable> createState() => _StyledPaginatedTableState();
}

class _StyledPaginatedTableState extends State<StyledPaginatedTable> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          cardColor: Colors.transparent,
          cardTheme: const CardTheme(elevation: 0),
          dividerColor: adrColor.borderBase),
      child: Stack(
        children: [
          Container(
            height: 98,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: adrColor.borderBase),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Transform.scale(
              scaleX: 1.01,
              child: SingleChildScrollView(
                child: PaginatedDataTable(
                  initialFirstRowIndex: widget.initialFirstRowIndex,
                  rowsPerPage: 5,
                  availableRowsPerPage: widget.availableRowsPerPage ?? [],
                  headingRowHeight: 93,
                  columns: widget.columns,
                  source: widget.rows,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
