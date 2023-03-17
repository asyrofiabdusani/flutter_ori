import 'package:flutter/material.dart';
import 'ad_checkbox.dart';
import 'dart:math' as math;
import '../../tokens/dart/dart_color.dart';
import '../../tokens/dart/dart_font.dart';

typedef DataColumnSortCallback = void Function(int columnIndex, bool ascending);

@immutable
class AdDataColumn {
  const AdDataColumn({
    required this.label,
    this.tooltip,
    this.numeric = false,
    this.onSort,
  });
  // : assert(label != null);

  final Widget label;
  final String? tooltip;
  final bool numeric;
  final DataColumnSortCallback? onSort;
  bool get _debugInteractive => onSort != null;
}

@immutable
class AdDataRow {
  const AdDataRow({
    this.key,
    this.selected = false,
    this.onSelectChanged,
    this.onLongPress,
    this.color,
    required this.cells,
  });
  //: assert(cells != null);

  AdDataRow.byIndex({
    int? index,
    this.selected = false,
    this.onSelectChanged,
    this.onLongPress,
    this.color,
    required this.cells,
  }) : key = ValueKey<int?>(index);

  final LocalKey? key;
  final ValueChanged<bool?>? onSelectChanged;
  final GestureLongPressCallback? onLongPress;
  final bool selected;
  final List<AdDataCell> cells;
  final MaterialStateProperty<Color?>? color;

  bool get _debugInteractive =>
      onSelectChanged != null ||
      cells.any((AdDataCell cell) => cell._debugInteractive);
}

@immutable
class AdDataCell {
  const AdDataCell(
    this.child, {
    this.placeholder = false,
    this.showEditIcon = false,
    this.onTap,
    this.onLongPress,
    this.onTapDown,
    this.onDoubleTap,
    this.onTapCancel,
  });
  // : assert(child != null);

  static const AdDataCell empty = AdDataCell(SizedBox(
    width: 0.0,
    height: 0.0,
  ));

  final Widget child;
  final bool placeholder;
  final bool showEditIcon;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onDoubleTap;
  final GestureTapCallback? onLongPress;
  final GestureTapDownCallback? onTapDown;
  final GestureTapCallback? onTapCancel;

  bool get _debugInteractive =>
      onTap != null ||
      onDoubleTap != null ||
      onLongPress != null ||
      onTapDown != null ||
      onTapCancel != null;
}

class AdDataTable extends StatelessWidget {
  AdDataTable({
    super.key,
    required this.columns,
    this.sortColumnIndex,
    this.sortAscending = true,
    this.onSelectAll,
    this.decoration,
    this.dataRowColor,
    this.dataRowHeight,
    this.dataTextStyle,
    this.headingRowColor,
    this.headingRowHeight,
    this.headingTextStyle,
    this.horizontalMargin,
    this.columnSpacing,
    this.showCheckboxColumn = true,
    this.showBottomBorder = false,
    this.dividerThickness,
    required this.rows,
    this.checkboxHorizontalMargin,
    this.border,
  })  : assert(columns.isNotEmpty),
        assert(sortColumnIndex == null ||
            (sortColumnIndex >= 0 && sortColumnIndex < columns.length)),
        //assert(sortAscending != null),
        //assert(showCheckboxColumn != null),
        //assert(rows != null),
        assert(
            !rows.any((AdDataRow row) => row.cells.length != columns.length)),
        assert(dividerThickness == null || dividerThickness >= 0),
        _onlyTextColumn = _initOnlyTextColumn(columns);

  final List<AdDataColumn> columns;
  final int? sortColumnIndex;
  final bool sortAscending;
  final ValueSetter<bool?>? onSelectAll;
  final Decoration? decoration;
  final MaterialStateProperty<Color?>? dataRowColor;
  final double? dataRowHeight;
  final TextStyle? dataTextStyle;
  final MaterialStateProperty<Color?>? headingRowColor;
  final double? headingRowHeight;
  final TextStyle? headingTextStyle;
  final double? horizontalMargin;
  final double? columnSpacing;
  final bool showCheckboxColumn;
  final List<AdDataRow> rows;
  final double? dividerThickness;
  final bool showBottomBorder;
  final double? checkboxHorizontalMargin;
  final TableBorder? border;

  final int? _onlyTextColumn;
  static int? _initOnlyTextColumn(List<AdDataColumn> columns) {
    int? result;
    for (int index = 0; index < columns.length; index += 1) {
      final AdDataColumn column = columns[index];
      if (!column.numeric) {
        if (result != null) {
          return null;
        }
        result = index;
      }
    }
    return result;
  }

  bool get _debugInteractive {
    return columns.any((AdDataColumn column) => column._debugInteractive) ||
        rows.any((AdDataRow row) => row._debugInteractive);
  }

  static final LocalKey _headingRowKey = UniqueKey();

  void _handleSelectAll(bool? checked, bool someChecked) {
    final bool effectiveChecked = someChecked || (checked ?? false);
    if (onSelectAll != null) {
      onSelectAll!(effectiveChecked);
    } else {
      for (final AdDataRow row in rows) {
        if (row.onSelectChanged != null && row.selected != effectiveChecked) {
          row.onSelectChanged!(effectiveChecked);
        }
      }
    }
  }

//TODO GANTI STYLING UKURAN DISINI
  static const double _headingRowHeight = 60.0;
  static const double _horizontalMargin = 24.0;
  static const double _columnSpacing = 56.0;
  static const double _sortArrowPadding = 2.0;
  static const double _dividerThickness = 1.0;

  static const Duration _sortArrowAnimationDuration =
      Duration(milliseconds: 150);

  Widget _buildCheckbox({
    required BuildContext context,
    required VoidCallback? onRowTap,
    required bool? checked,
    required ValueChanged<bool?>? onCheckboxChanged,
    required MaterialStateProperty<Color?>? overlayColor,
    required bool tristate,
  }) {
    final ThemeData themeData = Theme.of(context);
    final double effectiveHorizontalMargin = horizontalMargin ??
        themeData.dataTableTheme.horizontalMargin ??
        _horizontalMargin;
    final double effectiveCheckboxHorizontalMarginStart =
        checkboxHorizontalMargin ??
            themeData.dataTableTheme.checkboxHorizontalMargin ??
            effectiveHorizontalMargin;
    final double effectiveCheckboxHorizontalMarginEnd =
        checkboxHorizontalMargin ??
            themeData.dataTableTheme.checkboxHorizontalMargin ??
            effectiveHorizontalMargin / 2.0;
    Widget contents = Semantics(
      container: true,
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          start: effectiveCheckboxHorizontalMarginStart,
          end: effectiveCheckboxHorizontalMarginEnd,
        ),
        child: Center(
            child: AdCheckbox(
          value: checked,
          onChanged: onCheckboxChanged,
          tristate: tristate,
        )),
      ),
    );
    if (onRowTap != null) {
      contents = TableRowInkWell(
        onTap: onRowTap,
        overlayColor: overlayColor,
        child: contents,
      );
    }
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.fill,
      child: contents,
    );
  }

  Widget _buildHeadingCell({
    required BuildContext context,
    required EdgeInsetsGeometry padding,
    required Widget label,
    required String? tooltip,
    required bool numeric,
    required VoidCallback? onSort,
    required bool sorted,
    required bool ascending,
    required MaterialStateProperty<Color?>? overlayColor,
  }) {
    final ThemeData themeData = Theme.of(context);
    final DataTableThemeData dataTableTheme = DataTableTheme.of(context);
    label = Row(
      //ARAH TEXT
      textDirection: numeric ? TextDirection.rtl : null,
      children: <Widget>[
        label,
        if (onSort != null) ...<Widget>[
          _SortArrow(
              visible: sorted,
              up: sorted ? ascending : null,
              duration: _sortArrowAnimationDuration),
          const SizedBox(
            width: _sortArrowPadding,
          ),
        ],
      ],
    );

    const adHeadingTextStyle =
        TextStyle(color: (adrColor.textNormal), fontWeight: adrFont.weightBold);

    final TextStyle effectiveHeadingTextStyle =
        headingTextStyle ?? adHeadingTextStyle;
    //?? dataTableTheme.headingTextStyle ??
    //themeData.dataTableTheme.headingTextStyle ??
    //themeData.textTheme.subtitle2!;
    final double effectiveHeadingRowHeight = headingRowHeight ??
        dataTableTheme.headingRowHeight ??
        themeData.dataTableTheme.headingRowHeight ??
        _headingRowHeight;
    label = Container(
      //TODO WARNA HEADING ROW DISINI
      // color: adrColor.textLink,
      // decoration: const BoxDecoration(boxShadow: [
      //   BoxShadow(
      //     color: Colors.black26,
      //     offset: Offset(0, 1),
      //     //blurRadius: 2.0,
      //     //spreadRadius: 2.0
      //   )
      // ]), SHADOW NYA SUSAH
      padding: padding,
      height: effectiveHeadingRowHeight,
      alignment:
          numeric ? Alignment.centerRight : AlignmentDirectional.centerStart,
      child: AnimatedDefaultTextStyle(
        style: effectiveHeadingTextStyle,
        //TODO STYLING FONT HEADING TABLE
        //style: const TextStyle( color: (adrColor.textNormal), fontWeight: adrFont.weightBold),
        softWrap: false,
        duration: _sortArrowAnimationDuration,
        child: label,
      ),
    );
    if (tooltip != null) {
      label = Tooltip(
        message: tooltip,
        child: label,
      );
    }

    label = InkWell(
      onTap: onSort,
      overlayColor: overlayColor,
      child: label,
    );
    return label;
  }

  Widget _buildDataCell({
    required BuildContext context,
    required EdgeInsetsGeometry padding,
    required Widget label,
    required bool numeric,
    required bool placeholder,
    required bool showEditIcon,
    required GestureTapCallback? onTap,
    required VoidCallback? onSelectChanged,
    required GestureTapCallback? onDoubleTap,
    required GestureLongPressCallback? onLongPress,
    required GestureTapDownCallback? onTapDown,
    required GestureTapCancelCallback? onTapCancel,
    required MaterialStateProperty<Color?>? overlayColor,
    required GestureLongPressCallback? onRowLongPress,
  }) {
    final ThemeData themeData = Theme.of(context);
    final DataTableThemeData dataTableTheme = DataTableTheme.of(context);
    if (showEditIcon) {
      const Widget icon = Icon(Icons.edit, size: 18.0);
      label = Expanded(child: label);
      label = Row(
        textDirection: numeric ? TextDirection.rtl : null,
        children: <Widget>[label, icon],
      );
    }

    final TextStyle effectiveDataTextStyle = dataTextStyle ??
        dataTableTheme.dataTextStyle ??
        themeData.dataTableTheme.dataTextStyle ??
        themeData.textTheme.bodyText2!;
    final double effectiveDataRowHeight = dataRowHeight ??
        dataTableTheme.dataRowHeight ??
        themeData.dataTableTheme.dataRowHeight ??
        kMinInteractiveDimension;
    label = Container(
      padding: padding,
      height: effectiveDataRowHeight,
      alignment:
          numeric ? Alignment.centerRight : AlignmentDirectional.centerStart,
      child: DefaultTextStyle(
        style: effectiveDataTextStyle.copyWith(
            color: placeholder
                ? effectiveDataTextStyle.color!.withOpacity(0.6)
                : null),
        child: DropdownButtonHideUnderline(child: label),
      ),
    );
    if (onTap != null ||
        onDoubleTap != null ||
        onLongPress != null ||
        onTapDown != null ||
        onTapCancel != null) {
      label = InkWell(
        onTap: onTap,
        onDoubleTap: onDoubleTap,
        onLongPress: onLongPress,
        onTapCancel: onTapCancel,
        onTapDown: onTapDown,
        overlayColor: overlayColor,
        child: label,
      );
    } else if (onSelectChanged != null || onRowLongPress != null) {
      label = TableRowInkWell(
        onTap: onSelectChanged,
        onLongPress: onRowLongPress,
        overlayColor: overlayColor,
        child: label,
      );
    }
    return label;
  }

  @override
  Widget build(BuildContext context) {
    assert(!_debugInteractive || debugCheckHasMaterial(context));
    final adHeadingRowColor = MaterialStateColor.resolveWith(
        (states) => adrColor.backgroundBaseLight);
    final adDataRowColor =
        MaterialStateColor.resolveWith((states) => Color(0xffffffff));
    final ThemeData theme = Theme.of(context);
    final DataTableThemeData dataTableTheme = DataTableTheme.of(context);
    final MaterialStateProperty<Color?>? effectiveHeadingRowColor =
        headingRowColor ?? adHeadingRowColor;
    //?? dataTableTheme.dataRowColor ??
    //theme.dataTableTheme.headingRowColor;
    final MaterialStateProperty<Color?>? effectiveDataRowColor =
        dataRowColor ?? adDataRowColor;
    //dataTableTheme.dataRowColor ?? theme.dataTableTheme.dataRowColor;
    final MaterialStateProperty<Color?> defaultRowColor =
        MaterialStateProperty.resolveWith(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return theme.colorScheme.primary.withOpacity(0.08);
        }
        return null;
      },
    );
    final bool anyRowSelectable =
        rows.any((AdDataRow row) => row.onSelectChanged != null);
    final bool displayCheckboxColumn = showCheckboxColumn && anyRowSelectable;
    final Iterable<AdDataRow> rowsWithCheckbox = displayCheckboxColumn
        ? rows.where((AdDataRow row) => row.onSelectChanged != null)
        : <AdDataRow>[];
    final Iterable<AdDataRow> rowsChecked =
        rowsWithCheckbox.where((AdDataRow row) => row.selected);
    final bool allChecked =
        displayCheckboxColumn && rowsChecked.length == rowsWithCheckbox.length;
    final bool anyChecked = displayCheckboxColumn && rowsChecked.isNotEmpty;
    final bool someChecked = anyChecked && !allChecked;
    final double effectiveHorizontalMargin = horizontalMargin ??
        dataTableTheme.horizontalMargin ??
        theme.dataTableTheme.horizontalMargin ??
        _horizontalMargin;
    final double effectiveCheckboxHorizontalMarginStart =
        checkboxHorizontalMargin ??
            dataTableTheme.checkboxHorizontalMargin ??
            theme.dataTableTheme.checkboxHorizontalMargin ??
            effectiveHorizontalMargin;
    final double effectiveCheckboxHorizontalMarginEnd =
        checkboxHorizontalMargin ??
            dataTableTheme.checkboxHorizontalMargin ??
            theme.dataTableTheme.checkboxHorizontalMargin ??
            effectiveHorizontalMargin / 2.0;
    final double effectiveColumnSpacing = columnSpacing ??
        dataTableTheme.columnSpacing ??
        theme.dataTableTheme.columnSpacing ??
        _columnSpacing;

    final List<TableColumnWidth> tableColumns = List<TableColumnWidth>.filled(
        columns.length + (displayCheckboxColumn ? 1 : 0),
        const _NullTableColumnWidth());
    final List<TableRow> tableRows = List<TableRow>.generate(
      rows.length + 1,
      (int index) {
        final bool isSelected = index > 0 && rows[index - 1].selected;
        final bool isDisabled = index > 0 &&
            anyRowSelectable &&
            rows[index - 1].onSelectChanged == null;
        final Set<MaterialState> states = <MaterialState>{
          if (isSelected) MaterialState.selected,
          if (isDisabled) MaterialState.disabled,
        };
        //TODO COLORING ADA DISINI
        final Color? resolvedDataRowColor = index > 0
            ? (rows[index - 1].color ?? effectiveDataRowColor)?.resolve(states)
            : null;
        final Color? resolvedHeadingRowColor =
            effectiveHeadingRowColor?.resolve(<MaterialState>{});
        // adrColor.backgroundBaseLight;
        final Color? rowColor =
            index > 0 ? resolvedDataRowColor : resolvedHeadingRowColor;
        final BorderSide borderSide = Divider.createBorderSide(
          context,
          width: dividerThickness ??
              dataTableTheme.dividerThickness ??
              theme.dataTableTheme.dividerThickness ??
              _dividerThickness,
        );
        final Border? border = showBottomBorder
            ? Border(bottom: borderSide)
            : index == 0
                ? null
                : Border(top: borderSide);
        return TableRow(
          key: index == 0 ? _headingRowKey : rows[index - 1].key,
          decoration: BoxDecoration(
            border: border,
            color: rowColor ?? defaultRowColor.resolve(states),
          ),
          children:
              List<Widget>.filled(tableColumns.length, const _NullWidget()),
        );
      },
    );

    int rowIndex;

    int displayColumnIndex = 0;
    if (displayCheckboxColumn) {
      tableColumns[0] = FixedColumnWidth(
          effectiveCheckboxHorizontalMarginStart +
              Checkbox.width +
              effectiveCheckboxHorizontalMarginEnd);
      tableRows[0].children![0] = _buildCheckbox(
        context: context,
        checked: someChecked ? null : allChecked,
        onRowTap: null,
        onCheckboxChanged: (bool? checked) =>
            _handleSelectAll(checked, someChecked),
        overlayColor: null,
        tristate: true,
      );
      rowIndex = 1;
      for (final AdDataRow row in rows) {
        tableRows[rowIndex].children![0] = _buildCheckbox(
          context: context,
          checked: row.selected,
          onRowTap: row.onSelectChanged == null
              ? null
              : () => row.onSelectChanged?.call(!row.selected),
          onCheckboxChanged: row.onSelectChanged,
          overlayColor: row.color ?? effectiveDataRowColor,
          tristate: false,
        );
        rowIndex += 1;
      }
      displayColumnIndex += 1;
    }

    for (int dataColumnIndex = 0;
        dataColumnIndex < columns.length;
        dataColumnIndex += 1) {
      final AdDataColumn column = columns[dataColumnIndex];

      final double paddingStart;
      if (dataColumnIndex == 0 &&
          displayCheckboxColumn &&
          checkboxHorizontalMargin != null) {
        paddingStart = effectiveHorizontalMargin;
      } else if (dataColumnIndex == 0 && displayCheckboxColumn) {
        paddingStart = effectiveHorizontalMargin / 2.0;
      } else if (dataColumnIndex == 0 && !displayCheckboxColumn) {
        paddingStart = effectiveHorizontalMargin;
      } else {
        paddingStart = effectiveColumnSpacing / 2.0;
      }

      final double paddingEnd;
      if (dataColumnIndex == columns.length - 1) {
        paddingEnd = effectiveHorizontalMargin;
      } else {
        paddingEnd = effectiveColumnSpacing / 2.0;
      }

      final EdgeInsetsDirectional padding = EdgeInsetsDirectional.only(
        start: paddingStart,
        end: paddingEnd,
      );
      if (dataColumnIndex == _onlyTextColumn) {
        tableColumns[displayColumnIndex] =
            const IntrinsicColumnWidth(flex: 1.0);
      } else {
        tableColumns[displayColumnIndex] = const IntrinsicColumnWidth();
      }
      tableRows[0].children![displayColumnIndex] = _buildHeadingCell(
        context: context,
        padding: padding,
        label: column.label,
        tooltip: column.tooltip,
        numeric: column.numeric,
        onSort: column.onSort != null
            ? () => column.onSort!(dataColumnIndex,
                sortColumnIndex != dataColumnIndex || !sortAscending)
            : null,
        sorted: dataColumnIndex == sortColumnIndex,
        ascending: sortAscending,
        overlayColor: effectiveHeadingRowColor,
      );
      rowIndex = 1;
      for (final AdDataRow row in rows) {
        final AdDataCell cell = row.cells[dataColumnIndex];
        tableRows[rowIndex].children![displayColumnIndex] = _buildDataCell(
          context: context,
          padding: padding,
          label: cell.child,
          numeric: column.numeric,
          placeholder: cell.placeholder,
          showEditIcon: cell.showEditIcon,
          onTap: cell.onTap,
          onDoubleTap: cell.onDoubleTap,
          onLongPress: cell.onLongPress,
          onTapCancel: cell.onTapCancel,
          onTapDown: cell.onTapDown,
          onSelectChanged: row.onSelectChanged == null
              ? null
              : () => row.onSelectChanged?.call(!row.selected),
          overlayColor: row.color ?? effectiveDataRowColor,
          onRowLongPress: row.onLongPress,
        );
        rowIndex += 1;
      }
      displayColumnIndex += 1;
    }

    return Container(
      decoration: decoration ??
          dataTableTheme.decoration ??
          theme.dataTableTheme.decoration,
      child: Material(
        type: MaterialType.transparency,
        child: Table(
          columnWidths: tableColumns.asMap(),
          children: tableRows,
          border: border,
        ),
      ),
    );
  }
}

class _SortArrow extends StatefulWidget {
  const _SortArrow({
    required this.visible,
    required this.up,
    required this.duration,
  });

  final bool visible;

  final bool? up;

  final Duration duration;

  @override
  _SortArrowState createState() => _SortArrowState();
}

class _SortArrowState extends State<_SortArrow> with TickerProviderStateMixin {
  late AnimationController _opacityController;
  late Animation<double> _opacityAnimation;

  late AnimationController _orientationController;
  late Animation<double> _orientationAnimation;
  double _orientationOffset = 0.0;

  bool? _up;

  static final Animatable<double> _turnTween =
      Tween<double>(begin: 0.0, end: math.pi)
          .chain(CurveTween(curve: Curves.easeIn));

  @override
  void initState() {
    super.initState();
    _up = widget.up;
    _opacityAnimation = CurvedAnimation(
      parent: _opacityController = AnimationController(
        duration: widget.duration,
        vsync: this,
      ),
      curve: Curves.fastOutSlowIn,
    )..addListener(_rebuild);
    _opacityController.value = widget.visible ? 1.0 : 0.0;
    _orientationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _orientationAnimation = _orientationController.drive(_turnTween)
      ..addListener(_rebuild)
      ..addStatusListener(_resetOrientationAnimation);
    if (widget.visible) {
      _orientationOffset = widget.up! ? 0.0 : math.pi;
    }
  }

  void _rebuild() {
    setState(() {});
  }

  void _resetOrientationAnimation(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      assert(_orientationAnimation.value == math.pi);
      _orientationOffset += math.pi;
      _orientationController.value =
          0.0; // TODO(ianh): This triggers a pointless rebuild.
    }
  }

  @override
  void didUpdateWidget(_SortArrow oldWidget) {
    super.didUpdateWidget(oldWidget);
    bool skipArrow = false;
    final bool? newUp = widget.up ?? _up;
    if (oldWidget.visible != widget.visible) {
      if (widget.visible &&
          (_opacityController.status == AnimationStatus.dismissed)) {
        _orientationController.stop();
        _orientationController.value = 0.0;
        _orientationOffset = newUp! ? 0.0 : math.pi;
        skipArrow = true;
      }
      if (widget.visible) {
        _opacityController.forward();
      } else {
        _opacityController.reverse();
      }
    }
    if ((_up != newUp) && !skipArrow) {
      if (_orientationController.status == AnimationStatus.dismissed) {
        _orientationController.forward();
      } else {
        _orientationController.reverse();
      }
    }
    _up = newUp;
  }

  @override
  void dispose() {
    _opacityController.dispose();
    _orientationController.dispose();
    super.dispose();
  }

  static const double _arrowIconBaselineOffset = 0.5;
  //static const double _arrowIconBaselineOffset = 16.5;
  static const double _arrowIconSize = 16.0;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: Transform(
          transform: Matrix4.rotationX(
              _orientationOffset + _orientationAnimation.value)
            ..setTranslationRaw(0.0, _arrowIconBaselineOffset, 0.0),

          //transform: Matrix4.zero(),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Margin(
                vertical: 3,
                top: 2,
                child: Icon(
                  Icons.arrow_drop_up,
                  size: _arrowIconSize,
                ),
              ),
              Margin(
                top: -2,
                child: Opacity(
                  opacity: 0.5,
                  child: Icon(
                    Icons.arrow_drop_down,
                    size: _arrowIconSize,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

class _NullTableColumnWidth extends TableColumnWidth {
  const _NullTableColumnWidth();
  @override
  double maxIntrinsicWidth(Iterable<RenderBox> cells, double containerWidth) =>
      throw UnimplementedError();

  @override
  double minIntrinsicWidth(Iterable<RenderBox> cells, double containerWidth) =>
      throw UnimplementedError();
}

class _NullWidget extends Widget {
  const _NullWidget();

  @override
  Element createElement() => throw UnimplementedError();
}

// MINUS MARGIN //
class SizeProviderWidget extends StatefulWidget {
  final Widget child;
  final Function(Size) onChildSize;

  const SizeProviderWidget({
    super.key,
    required this.onChildSize,
    required this.child,
  });
  @override
  _SizeProviderWidgetState createState() => _SizeProviderWidgetState();
}

class _SizeProviderWidgetState extends State<SizeProviderWidget> {
  @override
  void initState() {
    _onResize();
    super.initState();
  }

  void _onResize() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (context.size is Size) {
        widget.onChildSize(context.size!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ///add size listener for every build uncomment the fallowing
    ///_onResize();
    return widget.child;
  }
}

class Margin extends StatefulWidget {
  const Margin({
    super.key,
    required this.child,
    this.horizontal = 0,
    this.vertical = 0,
    this.left = 0,
    this.top = 0,
  });

  final Widget child;
  final double horizontal;
  final double vertical;
  final double top;
  final double left;

  @override
  State<Margin> createState() => _MarginState();
}

class _MarginState extends State<Margin> {
  Size childSize = Size.zero;

  @override
  Widget build(BuildContext context) {
    final horizontalMargin = widget.horizontal * 2 * -1;
    final verticalMargin = widget.vertical * 2 * -1;

    final newWidth = childSize.width + horizontalMargin;
    final newHeight = childSize.height + verticalMargin;

    if (childSize != Size.zero) {
      return LimitedBox(
        maxWidth: newWidth,
        maxHeight: newHeight,
        child: OverflowBox(
          maxWidth: newWidth,
          maxHeight: newHeight,
          child: Transform.translate(
            offset: Offset(widget.left, widget.top),
            child: SizedBox(
              width: newWidth,
              height: newHeight,
              child: widget.child,
            ),
          ),
        ),
      );
    }

    return SizeProviderWidget(
      child: widget.child,
      onChildSize: (size) {
        setState(() => childSize = size);
      },
    );
  }
}
