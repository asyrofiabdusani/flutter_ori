import 'package:flutter/foundation.dart' show clampDouble;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../dart/dart_color.dart';

import 'ad_chip.dart' as ad_chip;

class AdInputChip extends StatelessWidget
    implements
        ChipAttributes,
        DeletableChipAttributes,
        SelectableChipAttributes,
        CheckmarkableChipAttributes,
        DisabledChipAttributes,
        TappableChipAttributes {
  const AdInputChip({
    super.key,
    this.avatar,
    required this.label,
    this.labelStyle,
    this.labelPadding,
    this.selected = false,
    this.isEnabled = true,
    this.onSelected,
    this.deleteIcon,
    this.onDeleted,
    this.deleteIconColor,
    this.deleteButtonTooltipMessage,
    this.onPressed,
    this.pressElevation,
    this.disabledColor,
    this.selectedColor,
    this.tooltip,
    this.side,
    this.shape,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.backgroundColor,
    this.padding,
    this.visualDensity,
    this.materialTapTargetSize,
    this.elevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.iconTheme,
    this.selectedShadowColor,
    this.showCheckmark,
    this.checkmarkColor,
    this.avatarBorder = const CircleBorder(),
    @Deprecated('Migrate to deleteButtonTooltipMessage. '
        'This feature was deprecated after v2.10.0-0.3.pre.')
        this.useDeleteButtonTooltip = true,
  });

  factory AdInputChip.success({
    Key? key,
    Widget? avatar,
    required Widget label,
    // TextStyle? labelStyle,
    // EdgeInsetsGeometry? labelPadding,
    bool selected,
    // bool isEnabled,
    ValueChanged<bool>? onSelected,
    // Widget? deleteIcon,
    VoidCallback? onDeleted,
    // Color? deleteIconColor,
    // String? deleteButtonTooltipMessage,
    // VoidCallback? onPressed,
    // double? pressElevation,
    // Color? disabledColor,
    // Color? selectedColor,
    // String? tooltip,
    // BorderSide? side,
    // OutlinedBorder? shape,
    // Clip clipBehavior,
    // FocusNode? focusNode,
    // bool? autofocus,
    // Color? backgroundColor,
    // EdgeInsetsGeometry? padding,
    // VisualDensity? visualDensity,
    // MaterialTapTargetSize? materialTapTargetSize,
    // double? elevation,
    // Color? shadowColor,
    // Color? surfaceTintColor,
    // Color? selectedShadowColor,
    // bool? showCheckmark,
    // Color? checkmarkColor,
    // ShapeBorder avatarBorder,
    // IconThemeData? iconTheme,
    // bool useDeleteButtonTooltip
  }) = _AdInputChipSuccess;

  factory AdInputChip.warning({
    Key? key,
    Widget? avatar,
    required Widget label,
    bool selected,
    ValueChanged<bool>? onSelected,
    VoidCallback? onDeleted,
  }) = _AdInputChipWarning;

  factory AdInputChip.error({
    Key? key,
    Widget? avatar,
    required Widget label,
    bool selected,
    ValueChanged<bool>? onSelected,
    VoidCallback? onDeleted,
  }) = _AdInputChipError;

  factory AdInputChip.confirmed({
    Key? key,
    Widget? avatar,
    required Widget label,
    bool selected,
    ValueChanged<bool>? onSelected,
    VoidCallback? onDeleted,
  }) = _AdInputChipConfirmed;

  @override
  final Widget? avatar;
  @override
  final Widget label;
  @override
  final TextStyle? labelStyle;
  @override
  final EdgeInsetsGeometry? labelPadding;
  @override
  final bool selected;
  @override
  final bool isEnabled;
  @override
  final ValueChanged<bool>? onSelected;
  @override
  final Widget? deleteIcon;
  @override
  final VoidCallback? onDeleted;
  @override
  final Color? deleteIconColor;
  @override
  final String? deleteButtonTooltipMessage;
  @override
  final VoidCallback? onPressed;
  @override
  final double? pressElevation;
  @override
  final Color? disabledColor;
  @override
  final Color? selectedColor;
  @override
  final String? tooltip;
  @override
  final BorderSide? side;
  @override
  final OutlinedBorder? shape;
  @override
  final Clip clipBehavior;
  @override
  final FocusNode? focusNode;
  @override
  final bool autofocus;
  @override
  final Color? backgroundColor;
  @override
  final EdgeInsetsGeometry? padding;
  @override
  final VisualDensity? visualDensity;
  @override
  final MaterialTapTargetSize? materialTapTargetSize;
  @override
  final double? elevation;
  @override
  final Color? shadowColor;
  @override
  final Color? surfaceTintColor;
  @override
  final Color? selectedShadowColor;
  @override
  final bool? showCheckmark;
  @override
  final Color? checkmarkColor;
  @override
  final ShapeBorder avatarBorder;
  @override
  final IconThemeData? iconTheme;
  @override
  @Deprecated('Migrate to deleteButtonTooltipMessage. '
      'This feature was deprecated after v2.10.0-0.3.pre.')
  final bool useDeleteButtonTooltip;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    final ChipThemeData? defaults = Theme.of(context).useMaterial3
        ? _InputChipDefaultsM3(context, isEnabled)
        : null;
    const adDeleteIcon = const Icon(Icons.highlight_off);
    final Widget? resolvedDeleteIcon = deleteIcon ?? adDeleteIcon;
    // _deleteIcon : null;
    // (Theme.of(context).useMaterial3
    //     ? const Icon(Icons.highlight_off, size: 18)
    //     : null);
    return ad_chip.AdRawChip(
      defaultProperties: defaults,
      avatar: avatar,
      label: label,
      labelStyle: labelStyle,
      labelPadding: labelPadding,
      deleteIcon: resolvedDeleteIcon,
      onDeleted: onDeleted,
      deleteIconColor: deleteIconColor,
      useDeleteButtonTooltip: useDeleteButtonTooltip,
      deleteButtonTooltipMessage: deleteButtonTooltipMessage,
      onSelected: onSelected,
      onPressed: onPressed,
      pressElevation: pressElevation,
      selected: selected,
      disabledColor: disabledColor,
      selectedColor: selectedColor,
      tooltip: tooltip,
      side: side,
      shape: shape,
      clipBehavior: clipBehavior,
      focusNode: focusNode,
      autofocus: autofocus,
      backgroundColor: backgroundColor,
      padding: padding,
      visualDensity: visualDensity,
      materialTapTargetSize: materialTapTargetSize,
      elevation: elevation,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTintColor,
      selectedShadowColor: selectedShadowColor,
      showCheckmark: showCheckmark,
      checkmarkColor: checkmarkColor,
      isEnabled: isEnabled &&
          (onSelected != null || onDeleted != null || onPressed != null),
      avatarBorder: avatarBorder,
    );
  }
}

class _InputChipDefaultsM3 extends ChipThemeData {
  const _InputChipDefaultsM3(this.context, this.isEnabled)
      : super(
          elevation: 0.0,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0))),
          showCheckmark: true,
        );

  final BuildContext context;
  final bool isEnabled;

  @override
  TextStyle? get labelStyle => Theme.of(context).textTheme.labelLarge;

  @override
  Color? get backgroundColor => null;

  @override
  Color? get shadowColor => null;

  @override
  @override
  Color? get surfaceTintColor => null;

  @override
  Color? get selectedColor => Theme.of(context).colorScheme.secondaryContainer;

  @override
  Color? get checkmarkColor => null;

  @override
  Color? get disabledColor => null;

  @override
  Color? get deleteIconColor =>
      Theme.of(context).colorScheme.onSecondaryContainer;

  @override
  BorderSide? get side => isEnabled
      ? BorderSide(color: Theme.of(context).colorScheme.outline)
      : BorderSide(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.12));

  @override
  IconThemeData? get iconTheme => IconThemeData(
        color: isEnabled ? null : Theme.of(context).colorScheme.onSurface,
        size: 18.0,
      );

  @override
  EdgeInsetsGeometry? get padding => const EdgeInsets.all(8.0);

  @override
  EdgeInsetsGeometry? get labelPadding => EdgeInsets.lerp(
        const EdgeInsets.symmetric(horizontal: 8.0),
        const EdgeInsets.symmetric(horizontal: 4.0),
        clampDouble(MediaQuery.of(context).textScaleFactor - 1.0, 0.0, 1.0),
      )!;
}

class _AdInputChipSuccess extends AdInputChip {
  const _AdInputChipSuccess({
    super.key,
    super.avatar,
    required super.label,
    // super.labelStyle,
    // super.labelPadding,
    super.selected,
    // super.isEnabled,
    super.onSelected,
    // super.deleteIcon,
    super.onDeleted,
    // super.deleteIconColor,
    // super.onPressed,
    // super.pressElevation,
    // super.disabledColor,
    // super.selectedColor,
    // super.tooltip,
    // super.side,
    // super.shape,
    // super.clipBehavior = Clip.none,
    // super.focusNode,
    // super.autofocus = false,
    // super.backgroundColor,
    // super.padding,
    // super.visualDensity,
    // super.materialTapTargetSize,
    // super.elevation,
    // super.shadowColor,
    // super.surfaceTintColor,
    // super.iconTheme,
    // super.selectedShadowColor,
    // super.showCheckmark,
    // super.checkmarkColor,
    // super.avatarBorder = const CircleBorder(),
    // @Deprecated('Migrate to deleteButtonTooltipMessage. '
    //     'This feature was deprecated after v2.10.0-0.3.pre.')
    //     super.useDeleteButtonTooltip = true,
  });

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    final ChipThemeData? defaults = Theme.of(context).useMaterial3
        ? _InputChipDefaultsM3(context, isEnabled)
        : null;
    const adDeleteIcon = Icon(Icons.highlight_off);
    final Widget resolvedDeleteIcon = deleteIcon ?? adDeleteIcon;

    return ad_chip.AdRawChip(
      defaultProperties: defaults,
      label: label,
      backgroundColor: adrColor.backgroundSuccess,
      deleteIcon: resolvedDeleteIcon,
      selected: selected,
      onDeleted: onDeleted,
      onSelected: onSelected,
      labelStyle: const TextStyle(color: adrColor.textSuccess),
    );
  }
}

class _AdInputChipWarning extends AdInputChip {
  const _AdInputChipWarning({
    super.key,
    super.avatar,
    required super.label,
    super.selected,
    super.onSelected,
    super.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    final ChipThemeData? defaults = Theme.of(context).useMaterial3
        ? _InputChipDefaultsM3(context, isEnabled)
        : null;
    const adDeleteIcon = Icon(Icons.highlight_off);
    final Widget resolvedDeleteIcon = deleteIcon ?? adDeleteIcon;

    return ad_chip.AdRawChip(
      defaultProperties: defaults,
      label: label,
      backgroundColor: adrColor.backgroundWarning,
      deleteIcon: resolvedDeleteIcon,
      selected: selected,
      onDeleted: onDeleted,
      onSelected: onSelected,
      labelStyle: const TextStyle(color: adrColor.textWarning),
    );
  }
}

class _AdInputChipError extends AdInputChip {
  const _AdInputChipError({
    super.key,
    super.avatar,
    required super.label,
    super.selected,
    super.onSelected,
    super.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    final ChipThemeData? defaults = Theme.of(context).useMaterial3
        ? _InputChipDefaultsM3(context, isEnabled)
        : null;
    const adDeleteIcon = Icon(Icons.highlight_off);
    final Widget resolvedDeleteIcon = deleteIcon ?? adDeleteIcon;

    return ad_chip.AdRawChip(
      defaultProperties: defaults,
      label: label,
      backgroundColor: adrColor.backgroundError,
      deleteIcon: resolvedDeleteIcon,
      selected: selected,
      onDeleted: onDeleted,
      onSelected: onSelected,
      labelStyle: const TextStyle(color: adrColor.textError),
    );
  }
}

class _AdInputChipConfirmed extends AdInputChip {
  const _AdInputChipConfirmed({
    super.key,
    super.avatar,
    required super.label,
    super.selected,
    super.onSelected,
    super.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    final ChipThemeData? defaults = Theme.of(context).useMaterial3
        ? _InputChipDefaultsM3(context, isEnabled)
        : null;
    const adDeleteIcon = Icon(Icons.highlight_off);
    final Widget resolvedDeleteIcon = deleteIcon ?? adDeleteIcon;

    return ad_chip.AdRawChip(
      defaultProperties: defaults,
      label: label,
      backgroundColor: adrColor.backgroundLink,
      deleteIcon: resolvedDeleteIcon,
      selected: selected,
      onDeleted: onDeleted,
      onSelected: onSelected,
      labelStyle: const TextStyle(color: adrColor.textLink),
    );
  }
}
