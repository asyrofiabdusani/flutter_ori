import 'dart:math' as math;

import 'package:flutter/foundation.dart' show clampDouble;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../dart/dart_font.dart';
import '../../dart/dart_color.dart';

// Some design constants
const double _kChipHeight = 32.0;
const double _kDeleteIconSize = 18.0;

const int _kCheckmarkAlpha = 0xde; // 87%
const int _kDisabledAlpha = 0x61; // 38%
const double _kCheckmarkStrokeWidth = 2.0;

const Duration _kSelectDuration = Duration(milliseconds: 195);
const Duration _kCheckmarkDuration = Duration(milliseconds: 150);
const Duration _kCheckmarkReverseDuration = Duration(milliseconds: 50);
const Duration _kDrawerDuration = Duration(milliseconds: 150);
const Duration _kReverseDrawerDuration = Duration(milliseconds: 100);
const Duration _kDisableDuration = Duration(milliseconds: 75);

const Color _kSelectScrimColor = Color(0x60191919);
const Icon _kDefaultDeleteIcon = Icon(Icons.cancel, size: _kDeleteIconSize);

abstract class ChipAttributes {
  ChipAttributes._();

  Widget get label;
  Widget? get avatar;
  TextStyle? get labelStyle;
  BorderSide? get side;
  OutlinedBorder? get shape;
  Clip get clipBehavior;
  FocusNode? get focusNode;
  bool get autofocus;
  Color? get backgroundColor;
  EdgeInsetsGeometry? get padding;
  VisualDensity? get visualDensity;
  EdgeInsetsGeometry? get labelPadding;
  MaterialTapTargetSize? get materialTapTargetSize;
  double? get elevation;
  Color? get shadowColor;
  Color? get surfaceTintColor;
  IconThemeData? get iconTheme;
}

abstract class DeletableChipAttributes {
  DeletableChipAttributes._();
  Widget? get deleteIcon;
  VoidCallback? get onDeleted;
  Color? get deleteIconColor;
  String? get deleteButtonTooltipMessage;
  @Deprecated('Migrate to deleteButtonTooltipMessage. '
      'This feature was deprecated after v2.10.0-0.3.pre.')
  bool get useDeleteButtonTooltip;
}

abstract class CheckmarkableChipAttributes {
  CheckmarkableChipAttributes._();
  bool? get showCheckmark;
  Color? get checkmarkColor;
}

abstract class SelectableChipAttributes {
  SelectableChipAttributes._();
  bool get selected;
  ValueChanged<bool>? get onSelected;
  double? get pressElevation;
  Color? get selectedColor;
  Color? get selectedShadowColor;
  String? get tooltip;
  ShapeBorder get avatarBorder;
}

abstract class DisabledChipAttributes {
  DisabledChipAttributes._();
  bool get isEnabled;
  Color? get disabledColor;
}

abstract class TappableChipAttributes {
  TappableChipAttributes._();
  VoidCallback? get onPressed;
  String? get tooltip;
}

/// A Material Design chip.
///
/// Chips are compact elements that represent an attribute, text, entity, or
/// action.
///
/// Supplying a non-null [onDeleted] callback will cause the chip to include a
/// button for deleting the chip.
///
/// Its ancestors must include [Material], [MediaQuery], [Directionality], and
/// [MaterialLocalizations]. Typically all of these widgets are provided by
/// [MaterialApp] and [Scaffold]. The [label] and [clipBehavior] arguments must
/// not be null.
///
/// {@tool snippet}
///
/// ```dart
/// Chip(
///   avatar: CircleAvatar(
///     backgroundColor: Colors.grey.shade800,
///     child: const Text('AB'),
///   ),
///   label: const Text('Aaron Burr'),
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [InputChip], a chip that represents a complex piece of information, such
///    as an entity (person, place, or thing) or conversational text, in a
///    compact form.
///  * [ChoiceChip], allows a single selection from a set of options. Choice
///    chips contain related descriptive text or categories.
///  * [FilterChip], uses tags or descriptive words as a way to filter content.
///  * [ActionChip], represents an action related to primary content.
///  * [CircleAvatar], which shows images or initials of entities.
///  * [Wrap], A widget that displays its children in multiple horizontal or
///    vertical runs.
///  * <https://material.io/design/components/chips.html>
class AdChip extends StatelessWidget
    implements ChipAttributes, DeletableChipAttributes {
  const AdChip({
    super.key,
    this.avatar,
    required this.label,
    this.labelStyle,
    this.labelPadding,
    this.deleteIcon,
    this.onDeleted,
    this.deleteIconColor,
    this.deleteButtonTooltipMessage,
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
    @Deprecated('Migrate to deleteButtonTooltipMessage. '
        'This feature was deprecated after v2.10.0-0.3.pre.')
        this.useDeleteButtonTooltip = true,
  })  : assert(label != null),
        assert(autofocus != null),
        assert(clipBehavior != null),
        assert(elevation == null || elevation >= 0.0);

  @override
  final Widget? avatar;
  @override
  final Widget label;
  @override
  final TextStyle? labelStyle;
  @override
  final EdgeInsetsGeometry? labelPadding;
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
  final Widget? deleteIcon;
  @override
  final VoidCallback? onDeleted;
  @override
  final Color? deleteIconColor;
  @override
  final String? deleteButtonTooltipMessage;
  @override
  final MaterialTapTargetSize? materialTapTargetSize;
  @override
  final double? elevation;
  @override
  final Color? shadowColor;
  @override
  final Color? surfaceTintColor;
  @override
  final IconThemeData? iconTheme;
  @override
  @Deprecated('Migrate to deleteButtonTooltipMessage. '
      'This feature was deprecated after v2.10.0-0.3.pre.')
  final bool useDeleteButtonTooltip;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    return AdRawChip(
      avatar: avatar,
      label: label,
      labelStyle: labelStyle,
      labelPadding: labelPadding,
      deleteIcon: deleteIcon,
      onDeleted: onDeleted,
      deleteIconColor: deleteIconColor,
      useDeleteButtonTooltip: useDeleteButtonTooltip,
      deleteButtonTooltipMessage: deleteButtonTooltipMessage,
      tapEnabled: false,
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
    );
  }
}

/// A raw Material Design chip.
///
/// This serves as the basis for all of the chip widget types to aggregate.
/// It is typically not created directly, one of the other chip types
/// that are appropriate for the use case are used instead:
///
///  * [Chip] a simple chip that can only display information and be deleted.
///  * [InputChip] represents a complex piece of information, such as an entity
///    (person, place, or thing) or conversational text, in a compact form.
///  * [ChoiceChip] allows a single selection from a set of options.
///  * [FilterChip] a chip that uses tags or descriptive words as a way to
///    filter content.
///  * [ActionChip]s display a set of actions related to primary content.
///
/// Raw chips are typically only used if you want to create your own custom chip
/// type.
///
/// Raw chips can be selected by setting [onSelected], deleted by setting
/// [onDeleted], and pushed like a button with [onPressed]. They have a [label],
/// and they can have a leading icon (see [avatar]) and a trailing icon
/// ([deleteIcon]). Colors and padding can be customized.
///
/// Requires one of its ancestors to be a [Material] widget.
///
/// See also:
///
///  * [CircleAvatar], which shows images or initials of people.
///  * [Wrap], A widget that displays its children in multiple horizontal or
///    vertical runs.
///  * <https://material.io/design/components/chips.html>
class AdRawChip extends StatefulWidget
    implements
        ChipAttributes,
        DeletableChipAttributes,
        SelectableChipAttributes,
        CheckmarkableChipAttributes,
        DisabledChipAttributes,
        TappableChipAttributes {
  const AdRawChip({
    super.key,
    this.defaultProperties,
    this.avatar,
    required this.label,
    this.labelStyle,
    this.padding,
    this.visualDensity,
    this.labelPadding,
    Widget? deleteIcon,
    this.onDeleted,
    this.deleteIconColor,
    this.deleteButtonTooltipMessage,
    this.onPressed,
    this.onSelected,
    this.pressElevation,
    this.tapEnabled = true,
    this.selected = false,
    this.isEnabled = true,
    this.disabledColor,
    this.selectedColor,
    this.tooltip,
    this.side,
    this.shape,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.backgroundColor,
    this.materialTapTargetSize,
    this.elevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.iconTheme,
    this.selectedShadowColor,
    this.showCheckmark = true,
    this.checkmarkColor,
    this.avatarBorder = const CircleBorder(),
    @Deprecated('Migrate to deleteButtonTooltipMessage. '
        'This feature was deprecated after v2.10.0-0.3.pre.')
        this.useDeleteButtonTooltip = true,
  })  : assert(label != null),
        assert(isEnabled != null),
        assert(selected != null),
        assert(clipBehavior != null),
        assert(autofocus != null),
        assert(pressElevation == null || pressElevation >= 0.0),
        assert(elevation == null || elevation >= 0.0),
        deleteIcon = deleteIcon ?? _kDefaultDeleteIcon;

  final ChipThemeData? defaultProperties;

  @override
  final Widget? avatar;
  @override
  final Widget label;
  @override
  final TextStyle? labelStyle;
  @override
  final EdgeInsetsGeometry? labelPadding;
  @override
  final Widget deleteIcon;
  @override
  final VoidCallback? onDeleted;
  @override
  final Color? deleteIconColor;
  @override
  final String? deleteButtonTooltipMessage;
  @override
  final ValueChanged<bool>? onSelected;
  @override
  final VoidCallback? onPressed;
  @override
  final double? pressElevation;
  @override
  final bool selected;
  @override
  final bool isEnabled;
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
  final IconThemeData? iconTheme;
  @override
  final Color? selectedShadowColor;
  @override
  final bool? showCheckmark;
  @override
  final Color? checkmarkColor;
  @override
  final ShapeBorder avatarBorder;
  @override
  @Deprecated('Migrate to deleteButtonTooltipMessage. '
      'This feature was deprecated after v2.10.0-0.3.pre.')
  final bool useDeleteButtonTooltip;

  final bool tapEnabled;

  @override
  State<AdRawChip> createState() => _AdRawChipState();
}

class _AdRawChipState extends State<AdRawChip>
    with MaterialStateMixin, TickerProviderStateMixin<AdRawChip> {
  static const Duration pressedAnimationDuration = Duration(milliseconds: 75);

  late AnimationController selectController;
  late AnimationController avatarDrawerController;
  late AnimationController deleteDrawerController;
  late AnimationController enableController;
  late Animation<double> checkmarkAnimation;
  late Animation<double> avatarDrawerAnimation;
  late Animation<double> deleteDrawerAnimation;
  late Animation<double> enableAnimation;
  late Animation<double> selectionFade;

  bool get hasDeleteButton => widget.onDeleted != null;
  bool get hasAvatar => widget.avatar != null;

  bool get canTap {
    return widget.isEnabled &&
        widget.tapEnabled &&
        (widget.onPressed != null || widget.onSelected != null);
  }

  bool _isTapping = false;
  bool get isTapping => canTap && _isTapping;

  @override
  void initState() {
    assert(widget.onSelected == null || widget.onPressed == null);
    super.initState();
    setMaterialState(MaterialState.disabled, !widget.isEnabled);
    setMaterialState(MaterialState.selected, widget.selected);
    selectController = AnimationController(
      duration: _kSelectDuration,
      value: widget.selected == true ? 1.0 : 0.0,
      vsync: this,
    );
    selectionFade = CurvedAnimation(
      parent: selectController,
      curve: Curves.fastOutSlowIn,
    );
    avatarDrawerController = AnimationController(
      duration: _kDrawerDuration,
      value: hasAvatar || widget.selected == true ? 1.0 : 0.0,
      vsync: this,
    );
    deleteDrawerController = AnimationController(
      duration: _kDrawerDuration,
      value: hasDeleteButton ? 1.0 : 0.0,
      vsync: this,
    );
    enableController = AnimationController(
      duration: _kDisableDuration,
      value: widget.isEnabled ? 1.0 : 0.0,
      vsync: this,
    );

    final double checkmarkPercentage =
        _kCheckmarkDuration.inMilliseconds / _kSelectDuration.inMilliseconds;
    final double checkmarkReversePercentage =
        _kCheckmarkReverseDuration.inMilliseconds /
            _kSelectDuration.inMilliseconds;
    final double avatarDrawerReversePercentage =
        _kReverseDrawerDuration.inMilliseconds /
            _kSelectDuration.inMilliseconds;
    checkmarkAnimation = CurvedAnimation(
      parent: selectController,
      curve:
          Interval(1.0 - checkmarkPercentage, 1.0, curve: Curves.fastOutSlowIn),
      reverseCurve: Interval(
        1.0 - checkmarkReversePercentage,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    deleteDrawerAnimation = CurvedAnimation(
      parent: deleteDrawerController,
      curve: Curves.fastOutSlowIn,
    );
    avatarDrawerAnimation = CurvedAnimation(
      parent: avatarDrawerController,
      curve: Curves.fastOutSlowIn,
      reverseCurve: Interval(
        1.0 - avatarDrawerReversePercentage,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    enableAnimation = CurvedAnimation(
      parent: enableController,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void dispose() {
    selectController.dispose();
    avatarDrawerController.dispose();
    deleteDrawerController.dispose();
    enableController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (!canTap) {
      return;
    }
    setMaterialState(MaterialState.pressed, true);
    setState(() {
      _isTapping = true;
    });
  }

  void _handleTapCancel() {
    if (!canTap) {
      return;
    }
    setMaterialState(MaterialState.pressed, false);
    setState(() {
      _isTapping = false;
    });
  }

  void _handleTap() {
    if (!canTap) {
      return;
    }
    setMaterialState(MaterialState.pressed, false);
    setState(() {
      _isTapping = false;
    });
    // Only one of these can be set, so only one will be called.
    widget.onSelected?.call(!widget.selected);
    widget.onPressed?.call();
  }

  OutlinedBorder _getShape(
      ThemeData theme, ChipThemeData chipTheme, ChipThemeData chipDefaults) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.disabled
    };
    final BorderSide? resolvedSide =
        MaterialStateProperty.resolveAs<BorderSide?>(
                widget.side, materialStates) ??
            MaterialStateProperty.resolveAs<BorderSide?>(
                chipTheme.side, materialStates) ??
            MaterialStateProperty.resolveAs<BorderSide?>(
                chipDefaults.side, materialStates);

    final BorderSide? resolvedSideDisabled =
        MaterialStateProperty.resolveAs<BorderSide?>(
            const BorderSide(color: adrColor.borderDisable, width: 1.0),
            interactiveStates);

    final OutlinedBorder resolvedShape =
        MaterialStateProperty.resolveAs<OutlinedBorder?>(
                widget.shape, materialStates) ??
            MaterialStateProperty.resolveAs<OutlinedBorder?>(
                chipTheme.shape, materialStates) ??
            MaterialStateProperty.resolveAs<OutlinedBorder?>(
                chipDefaults.shape, materialStates) ??
            //const StadiumBorder();
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8));
    //return resolvedShape.copyWith(side: resolvedSide);
    if (widget.isEnabled) {
      return resolvedShape.copyWith(side: resolvedSide);
    } else {
      return resolvedShape.copyWith(side: resolvedSideDisabled);
    }
  }

  /// Picks between three different colors, depending upon the state of two
  /// different animations.
  Color? _getBackgroundColor(
      ThemeData theme, ChipThemeData chipTheme, ChipThemeData chipDefaults) {
    if (theme.useMaterial3) {
      final ColorTween backgroundTween = ColorTween(
        begin: widget.disabledColor ??
            chipTheme.disabledColor ??
            adrColor.backgroundDisable,
        //chipDefaults.disabledColor,
        end: widget.backgroundColor ??
            chipTheme.backgroundColor ??
            adrColor.backgroundDisable,
        //chipDefaults.backgroundColor,
      );
      final ColorTween selectTween = ColorTween(
        begin: backgroundTween.evaluate(enableController),
        end: widget.selectedColor ??
            chipTheme.selectedColor ??
            adrColor.backgroundDisable,
        //chipDefaults.selectedColor,
      );
      return selectTween.evaluate(selectionFade);
    } else {
      final ColorTween backgroundTween = ColorTween(
        begin: widget.disabledColor ??
            chipTheme.disabledColor ??
            //theme.disabledColor ??
            adrColor.backgroundDisable,
        end: widget.backgroundColor ??
            chipTheme.backgroundColor ??
            theme.chipTheme.backgroundColor ??
            adrColor.backgroundDisable,
        //chipDefaults.backgroundColor,
      );
      final ColorTween selectTween = ColorTween(
          begin: backgroundTween.evaluate(enableController),
          end: widget.selectedColor ??
              chipTheme.selectedColor ??
              theme.chipTheme.selectedColor ??
              widget.backgroundColor ??
              adrColor.backgroundDisable
          //chipDefaults.selectedColor,
          );
      return selectTween.evaluate(selectionFade);
    }
  }

  @override
  void didUpdateWidget(AdRawChip oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isEnabled != widget.isEnabled) {
      setState(() {
        setMaterialState(MaterialState.disabled, !widget.isEnabled);
        if (widget.isEnabled) {
          enableController.forward();
        } else {
          enableController.reverse();
        }
      });
    }
    if (oldWidget.avatar != widget.avatar ||
        oldWidget.selected != widget.selected) {
      setState(() {
        if (hasAvatar || widget.selected == true) {
          avatarDrawerController.forward();
        } else {
          avatarDrawerController.reverse();
        }
      });
    }
    if (oldWidget.selected != widget.selected) {
      setState(() {
        setMaterialState(MaterialState.selected, widget.selected);
        if (widget.selected == true) {
          selectController.forward();
        } else {
          selectController.reverse();
        }
      });
    }
    if (oldWidget.onDeleted != widget.onDeleted) {
      setState(() {
        if (hasDeleteButton) {
          deleteDrawerController.forward();
        } else {
          deleteDrawerController.reverse();
        }
      });
    }
  }

  Widget? _wrapWithTooltip(
      {String? tooltip, bool enabled = true, Widget? child}) {
    if (child == null || !enabled || tooltip == null) {
      return child;
    }
    return Tooltip(
      message: tooltip,
      child: child,
    );
  }

  Widget? _buildDeleteIcon(
    BuildContext context,
    ThemeData theme,
    ChipThemeData chipTheme,
    ChipThemeData chipDefaults,
  ) {
    if (!hasDeleteButton) {
      return null;
    }
    return Semantics(
      container: true,
      button: true,
      child: _wrapWithTooltip(
        tooltip: widget.useDeleteButtonTooltip
            ? widget.deleteButtonTooltipMessage ??
                MaterialLocalizations.of(context).deleteButtonTooltip
            : null,
        enabled: widget.onDeleted != null,
        child: InkWell(
          // Radius should be slightly less than the full size of the chip.
          radius: (_kChipHeight + (widget.padding?.vertical ?? 0.0)) * .45,
          // Keeps the splash from being constrained to the icon alone.
          splashFactory:
              _UnconstrainedInkSplashFactory(Theme.of(context).splashFactory),
          onTap: widget.isEnabled ? widget.onDeleted : null,
          child: IconTheme(
            data: theme.iconTheme.copyWith(
                color: widget.deleteIconColor ??
                    chipTheme.deleteIconColor ??
                    theme.chipTheme.deleteIconColor ??
                    widget.labelStyle?.color ??
                    adrColor.textGray
                //chipDefaults.deleteIconColor,
                ),
            child: widget.deleteIcon,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    assert(debugCheckHasMediaQuery(context));
    assert(debugCheckHasDirectionality(context));
    assert(debugCheckHasMaterialLocalizations(context));

    /// The chip at text scale 1 starts with 8px on each side and as text scaling
    /// gets closer to 2 the label padding is linearly interpolated from 8px to 4px.
    /// Once the widget has a text scaling of 2 or higher than the label padding
    /// remains 4px.
    ///
    final EdgeInsetsGeometry defaultLabelPadding = EdgeInsets.lerp(
      const EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
      const EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
      clampDouble(MediaQuery.of(context).textScaleFactor - 1.0, 0.0, 1.0),
    )!;
    // final EdgeInsetsGeometry defaultLabelPadding = EdgeInsets.lerp(
    //   const EdgeInsets.symmetric(horizontal: 8.0),
    //   const EdgeInsets.symmetric(horizontal: 4.0),
    //   clampDouble(MediaQuery.of(context).textScaleFactor - 1.0, 0.0, 1.0),
    // )!;

    final ThemeData theme = Theme.of(context);
    final ChipThemeData chipTheme = ChipTheme.of(context);
    final Brightness brightness = chipTheme.brightness ?? theme.brightness;
    final ChipThemeData chipDefaults = widget.defaultProperties ??
        ChipThemeData.fromDefaults(
          brightness: brightness,
          secondaryColor: brightness == Brightness.dark
              ? Colors.tealAccent[200]!
              : theme.primaryColor,
          labelStyle: theme.textTheme.bodyText1!,
        );
    final TextDirection? textDirection = Directionality.maybeOf(context);
    final OutlinedBorder resolvedShape =
        _getShape(theme, chipTheme, chipDefaults);

    final double elevation =
        widget.elevation ?? chipTheme.elevation ?? chipDefaults.elevation ?? 0;
    final double pressElevation = widget.pressElevation ??
        chipTheme.pressElevation ??
        chipDefaults.pressElevation ??
        0;
    final Color? shadowColor =
        widget.shadowColor ?? chipTheme.shadowColor ?? chipDefaults.shadowColor;
    final Color? surfaceTintColor = widget.surfaceTintColor ??
        chipTheme.surfaceTintColor ??
        chipDefaults.surfaceTintColor;
    final Color? selectedShadowColor = widget.selectedShadowColor ??
        chipTheme.selectedShadowColor ??
        chipDefaults.selectedShadowColor;

    // final Color? checkmarkColor =
    //     widget.checkmarkColor ?? chipTheme.checkmarkColor ??
    //adrColor.textButtonPrimary;
    //chipDefaults.checkmarkColor;
    final bool showCheckmark = widget.showCheckmark ??
        chipTheme.showCheckmark ??
        chipDefaults.showCheckmark!;
    final EdgeInsetsGeometry padding =
        widget.padding ?? chipTheme.padding ?? chipDefaults.padding!;
    // Widget's label style is merged with this below.
    const adChipLabelStyle =
        TextStyle(color: adrColor.textGray, fontWeight: adrFont.weightSemibold);
    final TextStyle labelStyle =
        //chipTheme.labelStyle ?? chipDefaults.labelStyle!;
        chipTheme.labelStyle ?? adChipLabelStyle;
    final Color checkmarkColor = widget.checkmarkColor ??
        //chipTheme.checkmarkColor ??
        //resolvedCheckmarkColor ??
        widget.labelStyle?.color ??
        adrColor.textGray;
    final EdgeInsetsGeometry labelPadding = widget.labelPadding ??
        chipTheme.labelPadding ??
        chipDefaults.labelPadding ??
        defaultLabelPadding;
    final IconThemeData? iconTheme =
        widget.iconTheme ?? chipTheme.iconTheme ?? chipDefaults.iconTheme;

    final TextStyle effectiveLabelStyle = labelStyle.merge(widget.labelStyle);
    final Color? resolvedLabelColor = MaterialStateProperty.resolveAs<Color?>(
        effectiveLabelStyle.color, materialStates);
    final TextStyle resolvedLabelStyle =
        effectiveLabelStyle.copyWith(color: resolvedLabelColor);
    final Widget? avatar = iconTheme != null && hasAvatar
        ? IconTheme(data: iconTheme, child: widget.avatar!)
        : widget.avatar;

    Widget result = Material(
      elevation: isTapping ? pressElevation : elevation,
      shadowColor: widget.selected ? selectedShadowColor : shadowColor,
      surfaceTintColor: surfaceTintColor,
      animationDuration: pressedAnimationDuration,
      shape: resolvedShape,
      clipBehavior: widget.clipBehavior,
      child: InkWell(
        onFocusChange: updateMaterialState(MaterialState.focused),
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        canRequestFocus: widget.isEnabled,
        onTap: canTap ? _handleTap : null,
        onTapDown: canTap ? _handleTapDown : null,
        onTapCancel: canTap ? _handleTapCancel : null,
        onHover: canTap ? updateMaterialState(MaterialState.hovered) : null,
        customBorder: resolvedShape,
        child: AnimatedBuilder(
          animation: Listenable.merge(
              <Listenable>[selectController, enableController]),
          builder: (BuildContext context, Widget? child) {
            return Container(
              //added padding on Container
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: ShapeDecoration(
                shape: resolvedShape,
                color: _getBackgroundColor(theme, chipTheme, chipDefaults),
              ),
              child: child,
            );
          },
          child: _wrapWithTooltip(
            tooltip: widget.tooltip,
            enabled: widget.onPressed != null || widget.onSelected != null,
            child: _ChipRenderWidget(
              theme: _ChipRenderTheme(
                label: DefaultTextStyle(
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  softWrap: false,
                  style: resolvedLabelStyle,
                  child: widget.label,
                ),
                avatar: AnimatedSwitcher(
                  duration: _kDrawerDuration,
                  switchInCurve: Curves.fastOutSlowIn,
                  child: avatar,
                ),
                deleteIcon: AnimatedSwitcher(
                  duration: _kDrawerDuration,
                  switchInCurve: Curves.fastOutSlowIn,
                  child:
                      _buildDeleteIcon(context, theme, chipTheme, chipDefaults),
                ),
                brightness: brightness,
                padding: padding.resolve(textDirection),
                visualDensity: widget.visualDensity ?? theme.visualDensity,
                labelPadding: labelPadding.resolve(textDirection),
                showAvatar: hasAvatar,
                showCheckmark: showCheckmark,
                checkmarkColor: checkmarkColor,
                canTapBody: canTap,
              ),
              value: widget.selected,
              checkmarkAnimation: checkmarkAnimation,
              enableAnimation: enableAnimation,
              avatarDrawerAnimation: avatarDrawerAnimation,
              deleteDrawerAnimation: deleteDrawerAnimation,
              isEnabled: widget.isEnabled,
              avatarBorder: widget.avatarBorder,
            ),
          ),
        ),
      ),
    );

    final BoxConstraints constraints;
    final Offset densityAdjustment =
        (widget.visualDensity ?? theme.visualDensity).baseSizeAdjustment;
    switch (widget.materialTapTargetSize ?? theme.materialTapTargetSize) {
      case MaterialTapTargetSize.padded:
        constraints = BoxConstraints(
          minWidth: kMinInteractiveDimension + densityAdjustment.dx,
          minHeight: kMinInteractiveDimension + densityAdjustment.dy,
        );
        break;
      case MaterialTapTargetSize.shrinkWrap:
        constraints = const BoxConstraints();
        break;
    }
    result = _ChipRedirectingHitDetectionWidget(
      constraints: constraints,
      child: Center(
        widthFactor: 1.0,
        heightFactor: 1.0,
        child: result,
      ),
    );
    // if (height != null) {
    //   result = SizedBox(height: height, child: result);
    // }
    return Semantics(
      button: widget.tapEnabled,
      container: true,
      selected: widget.selected,
      enabled: widget.tapEnabled ? canTap : null,
      child: result,
    );
  }
}

class _ChipRedirectingHitDetectionWidget extends SingleChildRenderObjectWidget {
  const _ChipRedirectingHitDetectionWidget({
    super.child,
    required this.constraints,
  });

  final BoxConstraints constraints;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderChipRedirectingHitDetection(constraints);
  }

  @override
  void updateRenderObject(BuildContext context,
      covariant _RenderChipRedirectingHitDetection renderObject) {
    renderObject.additionalConstraints = constraints;
  }
}

class _RenderChipRedirectingHitDetection extends RenderConstrainedBox {
  _RenderChipRedirectingHitDetection(BoxConstraints additionalConstraints)
      : super(additionalConstraints: additionalConstraints);

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    if (!size.contains(position)) {
      return false;
    }
    // Only redirects hit detection which occurs above and below the render object.
    // In order to make this assumption true, I have removed the minimum width
    // constraints, since any reasonable chip would be at least that wide.
    final Offset offset = Offset(position.dx, size.height / 2);
    return result.addWithRawTransform(
      transform: MatrixUtils.forceToPoint(offset),
      position: position,
      hitTest: (BoxHitTestResult result, Offset position) {
        assert(position == offset);
        return child!.hitTest(result, position: offset);
      },
    );
  }
}

class _ChipRenderWidget extends RenderObjectWidget
    with SlottedMultiChildRenderObjectWidgetMixin<_ChipSlot> {
  const _ChipRenderWidget({
    required this.theme,
    this.value,
    this.isEnabled,
    required this.checkmarkAnimation,
    required this.avatarDrawerAnimation,
    required this.deleteDrawerAnimation,
    required this.enableAnimation,
    this.avatarBorder,
  }) : assert(theme != null);

  final _ChipRenderTheme theme;
  final bool? value;
  final bool? isEnabled;
  final Animation<double> checkmarkAnimation;
  final Animation<double> avatarDrawerAnimation;
  final Animation<double> deleteDrawerAnimation;
  final Animation<double> enableAnimation;
  final ShapeBorder? avatarBorder;

  @override
  Iterable<_ChipSlot> get slots => _ChipSlot.values;

  @override
  Widget? childForSlot(_ChipSlot slot) {
    switch (slot) {
      case _ChipSlot.label:
        return theme.label;
      case _ChipSlot.avatar:
        return theme.avatar;
      case _ChipSlot.deleteIcon:
        return theme.deleteIcon;
    }
  }

  @override
  void updateRenderObject(BuildContext context, _RenderChip renderObject) {
    renderObject
      ..theme = theme
      ..textDirection = Directionality.of(context)
      ..value = value
      ..isEnabled = isEnabled
      ..checkmarkAnimation = checkmarkAnimation
      ..avatarDrawerAnimation = avatarDrawerAnimation
      ..deleteDrawerAnimation = deleteDrawerAnimation
      ..enableAnimation = enableAnimation
      ..avatarBorder = avatarBorder;
  }

  @override
  SlottedContainerRenderObjectMixin<_ChipSlot> createRenderObject(
      BuildContext context) {
    return _RenderChip(
      theme: theme,
      textDirection: Directionality.of(context),
      value: value,
      isEnabled: isEnabled,
      checkmarkAnimation: checkmarkAnimation,
      avatarDrawerAnimation: avatarDrawerAnimation,
      deleteDrawerAnimation: deleteDrawerAnimation,
      enableAnimation: enableAnimation,
      avatarBorder: avatarBorder,
    );
  }
}

enum _ChipSlot {
  label,
  avatar,
  deleteIcon,
}

@immutable
class _ChipRenderTheme {
  const _ChipRenderTheme({
    required this.avatar,
    required this.label,
    required this.deleteIcon,
    required this.brightness,
    required this.padding,
    required this.visualDensity,
    required this.labelPadding,
    required this.showAvatar,
    required this.showCheckmark,
    required this.checkmarkColor,
    required this.canTapBody,
  });

  final Widget avatar;
  final Widget label;
  final Widget deleteIcon;
  final Brightness brightness;
  final EdgeInsets padding;
  final VisualDensity visualDensity;
  final EdgeInsets labelPadding;
  final bool showAvatar;
  final bool showCheckmark;
  final Color? checkmarkColor;
  final bool canTapBody;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is _ChipRenderTheme &&
        other.avatar == avatar &&
        other.label == label &&
        other.deleteIcon == deleteIcon &&
        other.brightness == brightness &&
        other.padding == padding &&
        other.labelPadding == labelPadding &&
        other.showAvatar == showAvatar &&
        other.showCheckmark == showCheckmark &&
        other.checkmarkColor == checkmarkColor &&
        other.canTapBody == canTapBody;
  }

  @override
  int get hashCode => Object.hash(
        avatar,
        label,
        deleteIcon,
        brightness,
        padding,
        labelPadding,
        showAvatar,
        showCheckmark,
        checkmarkColor,
        canTapBody,
      );
}

class _RenderChip extends RenderBox
    with SlottedContainerRenderObjectMixin<_ChipSlot> {
  _RenderChip({
    required _ChipRenderTheme theme,
    required TextDirection textDirection,
    this.value,
    this.isEnabled,
    required this.checkmarkAnimation,
    required this.avatarDrawerAnimation,
    required this.deleteDrawerAnimation,
    required this.enableAnimation,
    this.avatarBorder,
  })  : assert(theme != null),
        assert(textDirection != null),
        _theme = theme,
        _textDirection = textDirection {
    checkmarkAnimation.addListener(markNeedsPaint);
    avatarDrawerAnimation.addListener(markNeedsLayout);
    deleteDrawerAnimation.addListener(markNeedsLayout);
    enableAnimation.addListener(markNeedsPaint);
  }

  bool? value;
  bool? isEnabled;
  late Rect _deleteButtonRect;
  late Rect _pressRect;
  Animation<double> checkmarkAnimation;
  Animation<double> avatarDrawerAnimation;
  Animation<double> deleteDrawerAnimation;
  Animation<double> enableAnimation;
  ShapeBorder? avatarBorder;

  RenderBox? get avatar => childForSlot(_ChipSlot.avatar);
  RenderBox? get deleteIcon => childForSlot(_ChipSlot.deleteIcon);
  RenderBox? get label => childForSlot(_ChipSlot.label);

  _ChipRenderTheme get theme => _theme;
  _ChipRenderTheme _theme;
  set theme(_ChipRenderTheme value) {
    if (_theme == value) {
      return;
    }
    _theme = value;
    markNeedsLayout();
  }

  TextDirection? get textDirection => _textDirection;
  TextDirection? _textDirection;
  set textDirection(TextDirection? value) {
    if (_textDirection == value) {
      return;
    }
    _textDirection = value;
    markNeedsLayout();
  }

  // The returned list is ordered for hit testing.
  @override
  Iterable<RenderBox> get children {
    return <RenderBox>[
      if (avatar != null) avatar!,
      if (label != null) label!,
      if (deleteIcon != null) deleteIcon!,
    ];
  }

  bool get isDrawingCheckmark =>
      theme.showCheckmark && !checkmarkAnimation.isDismissed;
  bool get deleteIconShowing => !deleteDrawerAnimation.isDismissed;

  @override
  bool get sizedByParent => false;

  static double _minWidth(RenderBox? box, double height) {
    return box == null ? 0.0 : box.getMinIntrinsicWidth(height);
  }

  static double _maxWidth(RenderBox? box, double height) {
    return box == null ? 0.0 : box.getMaxIntrinsicWidth(height);
  }

  static double _minHeight(RenderBox? box, double width) {
    return box == null ? 0.0 : box.getMinIntrinsicHeight(width);
  }

  static Size _boxSize(RenderBox? box) => box == null ? Size.zero : box.size;

  static Rect _boxRect(RenderBox? box) =>
      box == null ? Rect.zero : _boxParentData(box).offset & box.size;

  static BoxParentData _boxParentData(RenderBox box) =>
      box.parentData! as BoxParentData;

  @override
  double computeMinIntrinsicWidth(double height) {
    // The overall padding isn't affected by missing avatar or delete icon
    // because we add the padding regardless to give extra padding for the label
    // when they're missing.
    final double overallPadding =
        theme.padding.horizontal + theme.labelPadding.horizontal;
    return overallPadding +
        _minWidth(avatar, height) +
        _minWidth(label, height) +
        _minWidth(deleteIcon, height);
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    final double overallPadding =
        theme.padding.horizontal + theme.labelPadding.horizontal;
    return overallPadding +
        _maxWidth(avatar, height) +
        _maxWidth(label, height) +
        _maxWidth(deleteIcon, height);
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    return math.max(
      _kChipHeight,
      theme.padding.vertical +
          theme.labelPadding.vertical +
          _minHeight(label, width),
    );
  }

  @override
  double computeMaxIntrinsicHeight(double width) =>
      computeMinIntrinsicHeight(width);

  @override
  double? computeDistanceToActualBaseline(TextBaseline baseline) {
    // The baseline of this widget is the baseline of the label.
    return label!.getDistanceToActualBaseline(baseline);
  }

  Size _layoutLabel(BoxConstraints contentConstraints, double iconSizes,
      Size size, Size rawSize,
      [ChildLayouter layoutChild = ChildLayoutHelper.layoutChild]) {
    // Now that we know the label height and the width of the icons, we can
    // determine how much to shrink the width constraints for the "real" layout.
    if (contentConstraints.maxWidth.isFinite) {
      final double maxWidth = math.max(
        0.0,
        contentConstraints.maxWidth -
            iconSizes -
            theme.labelPadding.horizontal -
            theme.padding.horizontal,
      );
      final Size updatedSize = layoutChild(
        label!,
        BoxConstraints(
          maxWidth: maxWidth,
          minHeight: rawSize.height,
          maxHeight: size.height,
        ),
      );

      return Size(
        updatedSize.width + theme.labelPadding.horizontal,
        updatedSize.height + theme.labelPadding.vertical,
      );
    }

    final Size updatedSize = layoutChild(
      label!,
      BoxConstraints(
        minHeight: rawSize.height,
        maxHeight: size.height,
        maxWidth: size.width,
      ),
    );

    return Size(
      updatedSize.width + theme.labelPadding.horizontal,
      updatedSize.height + theme.labelPadding.vertical,
    );
  }

  Size _layoutAvatar(BoxConstraints contentConstraints, double contentSize,
      [ChildLayouter layoutChild = ChildLayoutHelper.layoutChild]) {
    final double requestedSize = math.max(0.0, contentSize);
    final BoxConstraints avatarConstraints = BoxConstraints.tightFor(
      width: requestedSize,
      height: requestedSize,
    );
    final Size avatarBoxSize = layoutChild(avatar!, avatarConstraints);
    if (!theme.showCheckmark && !theme.showAvatar) {
      return Size(0.0, contentSize);
    }
    double avatarWidth = 0.0;
    double avatarHeight = 0.0;
    if (theme.showAvatar) {
      avatarWidth += avatarDrawerAnimation.value * avatarBoxSize.width;
    } else {
      avatarWidth += avatarDrawerAnimation.value * contentSize;
    }
    avatarHeight += avatarBoxSize.height;
    return Size(avatarWidth, avatarHeight);
  }

  Size _layoutDeleteIcon(BoxConstraints contentConstraints, double contentSize,
      [ChildLayouter layoutChild = ChildLayoutHelper.layoutChild]) {
    final double requestedSize = math.max(0.0, contentSize);
    final BoxConstraints deleteIconConstraints = BoxConstraints.tightFor(
      width: requestedSize,
      height: requestedSize,
    );
    final Size boxSize = layoutChild(deleteIcon!, deleteIconConstraints);
    if (!deleteIconShowing) {
      return Size(0.0, contentSize);
    }
    double deleteIconWidth = 0.0;
    double deleteIconHeight = 0.0;
    deleteIconWidth += deleteDrawerAnimation.value * boxSize.width;
    deleteIconHeight += boxSize.height;
    return Size(deleteIconWidth, deleteIconHeight);
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    if (!size.contains(position)) {
      return false;
    }
    final bool hitIsOnDeleteIcon = deleteIcon != null &&
        _hitIsOnDeleteIcon(
          padding: theme.padding,
          tapPosition: position,
          chipSize: size,
          deleteButtonSize: deleteIcon!.size,
          textDirection: textDirection!,
        );
    final RenderBox? hitTestChild =
        hitIsOnDeleteIcon ? (deleteIcon ?? label ?? avatar) : (label ?? avatar);

    if (hitTestChild != null) {
      final Offset center = hitTestChild.size.center(Offset.zero);
      return result.addWithRawTransform(
        transform: MatrixUtils.forceToPoint(center),
        position: position,
        hitTest: (BoxHitTestResult result, Offset position) {
          assert(position == center);
          return hitTestChild.hitTest(result, position: center);
        },
      );
    }
    return false;
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return _computeSizes(constraints, ChildLayoutHelper.dryLayoutChild).size;
  }

  _ChipSizes _computeSizes(
      BoxConstraints constraints, ChildLayouter layoutChild) {
    final BoxConstraints contentConstraints = constraints.loosen();
    // Find out the height of the label within the constraints.
    final Offset densityAdjustment =
        Offset(0.0, theme.visualDensity.baseSizeAdjustment.dy / 2.0);
    final Size rawLabelSize = layoutChild(label!, contentConstraints);
    final double contentSize = math.max(
      _kChipHeight - theme.padding.vertical + theme.labelPadding.vertical,
      rawLabelSize.height + theme.labelPadding.vertical,
    );
    final Size avatarSize =
        _layoutAvatar(contentConstraints, contentSize, layoutChild);
    final Size deleteIconSize =
        _layoutDeleteIcon(contentConstraints, contentSize, layoutChild);
    final Size labelSize = _layoutLabel(
      contentConstraints,
      avatarSize.width + deleteIconSize.width,
      Size(rawLabelSize.width, contentSize),
      rawLabelSize,
      layoutChild,
    );

    // This is the overall size of the content: it doesn't include
    // theme.padding, that is added in at the end.
    final Size overallSize = Size(
          avatarSize.width + labelSize.width + deleteIconSize.width,
          contentSize,
        ) +
        densityAdjustment;
    final Size paddedSize = Size(
      overallSize.width + theme.padding.horizontal,
      overallSize.height + theme.padding.vertical,
    );

    return _ChipSizes(
      size: constraints.constrain(paddedSize),
      overall: overallSize,
      content: contentSize,
      densityAdjustment: densityAdjustment,
      avatar: avatarSize,
      label: labelSize,
      deleteIcon: deleteIconSize,
    );
  }

  @override
  void performLayout() {
    final _ChipSizes sizes =
        _computeSizes(constraints, ChildLayoutHelper.layoutChild);

    // Now we have all of the dimensions. Place the children where they belong.

    const double left = 0.0;
    final double right = sizes.overall.width;

    Offset centerLayout(Size boxSize, double x) {
      assert(sizes.content >= boxSize.height);
      switch (textDirection!) {
        case TextDirection.rtl:
          return Offset(
              x - boxSize.width,
              (sizes.content - boxSize.height + sizes.densityAdjustment.dy) /
                  2.0);
        case TextDirection.ltr:
          return Offset(
              x,
              (sizes.content - boxSize.height + sizes.densityAdjustment.dy) /
                  2.0);
      }
    }

    // These are the offsets to the upper left corners of the boxes (including
    // the child's padding) containing the children, for each child, but not
    // including the overall padding.
    Offset avatarOffset = Offset.zero;
    Offset labelOffset = Offset.zero;
    Offset deleteIconOffset = Offset.zero;
    switch (textDirection!) {
      case TextDirection.rtl:
        double start = right;
        if (theme.showCheckmark || theme.showAvatar) {
          avatarOffset = centerLayout(sizes.avatar, start);
          start -= sizes.avatar.width;
        }
        labelOffset = centerLayout(sizes.label, start);
        start -= sizes.label.width;
        if (deleteIconShowing) {
          _deleteButtonRect = Rect.fromLTWH(
            0.0,
            0.0,
            sizes.deleteIcon.width + theme.padding.right,
            sizes.overall.height + theme.padding.vertical,
          );
          deleteIconOffset = centerLayout(sizes.deleteIcon, start);
        } else {
          _deleteButtonRect = Rect.zero;
        }
        start -= sizes.deleteIcon.width;
        if (theme.canTapBody) {
          _pressRect = Rect.fromLTWH(
            _deleteButtonRect.width,
            0.0,
            sizes.overall.width -
                _deleteButtonRect.width +
                theme.padding.horizontal,
            sizes.overall.height + theme.padding.vertical,
          );
        } else {
          _pressRect = Rect.zero;
        }
        break;
      case TextDirection.ltr:
        double start = left;
        if (theme.showCheckmark || theme.showAvatar) {
          avatarOffset = centerLayout(sizes.avatar,
              start - _boxSize(avatar).width + sizes.avatar.width);
          start += sizes.avatar.width;
        }
        labelOffset = centerLayout(sizes.label, start);
        start += sizes.label.width;
        if (theme.canTapBody) {
          _pressRect = Rect.fromLTWH(
            0.0,
            0.0,
            deleteIconShowing
                ? start + theme.padding.left
                : sizes.overall.width + theme.padding.horizontal,
            sizes.overall.height + theme.padding.vertical,
          );
        } else {
          _pressRect = Rect.zero;
        }
        start -= _boxSize(deleteIcon).width - sizes.deleteIcon.width;
        if (deleteIconShowing) {
          deleteIconOffset = centerLayout(sizes.deleteIcon, start);
          _deleteButtonRect = Rect.fromLTWH(
            start + theme.padding.left,
            0.0,
            sizes.deleteIcon.width + theme.padding.right,
            sizes.overall.height + theme.padding.vertical,
          );
        } else {
          _deleteButtonRect = Rect.zero;
        }
        break;
    }
    // Center the label vertically.
    labelOffset = labelOffset +
        Offset(
          0.0,
          ((sizes.label.height - theme.labelPadding.vertical) -
                  _boxSize(label).height) /
              2.0,
        );
    _boxParentData(avatar!).offset = theme.padding.topLeft + avatarOffset;
    _boxParentData(label!).offset =
        theme.padding.topLeft + labelOffset + theme.labelPadding.topLeft;
    _boxParentData(deleteIcon!).offset =
        theme.padding.topLeft + deleteIconOffset;
    final Size paddedSize = Size(
      sizes.overall.width + theme.padding.horizontal,
      sizes.overall.height + theme.padding.vertical,
    );
    size = constraints.constrain(paddedSize);
    assert(
      size.height == constraints.constrainHeight(paddedSize.height),
      "Constrained height ${size.height} doesn't match expected height "
      '${constraints.constrainWidth(paddedSize.height)}',
    );
    assert(
      size.width == constraints.constrainWidth(paddedSize.width),
      "Constrained width ${size.width} doesn't match expected width "
      '${constraints.constrainWidth(paddedSize.width)}',
    );
  }

  static final ColorTween selectionScrimTween = ColorTween(
    begin: Colors.transparent,
    end: _kSelectScrimColor,
  );

  Color get _disabledColor {
    if (enableAnimation == null || enableAnimation.isCompleted) {
      return Colors.white;
    }
    final ColorTween enableTween;
    switch (theme.brightness) {
      case Brightness.light:
        enableTween = ColorTween(
          begin: Colors.white.withAlpha(_kDisabledAlpha),
          end: Colors.white,
        );
        break;
      case Brightness.dark:
        enableTween = ColorTween(
          begin: Colors.black.withAlpha(_kDisabledAlpha),
          end: Colors.black,
        );
        break;
    }
    return enableTween.evaluate(enableAnimation)!;
  }

  void _paintCheck(Canvas canvas, Offset origin, double size) {
    Color? paintColor;
    if (theme.checkmarkColor != null) {
      paintColor = theme.checkmarkColor;
    } else {
      switch (theme.brightness) {
        case Brightness.light:
          paintColor = theme.showAvatar
              ? Colors.white
              : Colors.black.withAlpha(_kCheckmarkAlpha);
          break;
        case Brightness.dark:
          paintColor = theme.showAvatar
              ? Colors.black
              : Colors.white.withAlpha(_kCheckmarkAlpha);
          break;
      }
    }

    final ColorTween fadeTween =
        ColorTween(begin: Colors.transparent, end: paintColor);

    paintColor = checkmarkAnimation.status == AnimationStatus.reverse
        ? fadeTween.evaluate(checkmarkAnimation)
        : paintColor;

    final Paint paint = Paint()
      ..color = paintColor!
      ..style = PaintingStyle.stroke
      ..strokeWidth = _kCheckmarkStrokeWidth *
          (avatar != null ? avatar!.size.height / 24.0 : 1.0);
    final double t = checkmarkAnimation.status == AnimationStatus.reverse
        ? 1.0
        : checkmarkAnimation.value;
    if (t == 0.0) {
      // Nothing to draw.
      return;
    }
    assert(t > 0.0 && t <= 1.0);
    // As t goes from 0.0 to 1.0, animate the two check mark strokes from the
    // short side to the long side.
    final Path path = Path();
    final Offset start = Offset(size * 0.15, size * 0.45);
    final Offset mid = Offset(size * 0.4, size * 0.7);
    final Offset end = Offset(size * 0.85, size * 0.25);
    if (t < 0.5) {
      final double strokeT = t * 2.0;
      final Offset drawMid = Offset.lerp(start, mid, strokeT)!;
      path.moveTo(origin.dx + start.dx, origin.dy + start.dy);
      path.lineTo(origin.dx + drawMid.dx, origin.dy + drawMid.dy);
    } else {
      final double strokeT = (t - 0.5) * 2.0;
      final Offset drawEnd = Offset.lerp(mid, end, strokeT)!;
      path.moveTo(origin.dx + start.dx, origin.dy + start.dy);
      path.lineTo(origin.dx + mid.dx, origin.dy + mid.dy);
      path.lineTo(origin.dx + drawEnd.dx, origin.dy + drawEnd.dy);
    }
    canvas.drawPath(path, paint);
  }

  void _paintSelectionOverlay(PaintingContext context, Offset offset) {
    if (isDrawingCheckmark) {
      if (theme.showAvatar) {
        final Rect avatarRect = _boxRect(avatar).shift(offset);
        final Paint darkenPaint = Paint()
          ..color = selectionScrimTween.evaluate(checkmarkAnimation)!
          ..blendMode = BlendMode.srcATop;
        final Path path = avatarBorder!.getOuterPath(avatarRect);
        context.canvas.drawPath(path, darkenPaint);
      }
      // Need to make the check mark be a little smaller than the avatar.
      final double checkSize = avatar!.size.height * 0.75;
      final Offset checkOffset = _boxParentData(avatar!).offset +
          Offset(avatar!.size.height * 0.125, avatar!.size.height * 0.125);
      _paintCheck(context.canvas, offset + checkOffset, checkSize);
    }
  }

  void _paintAvatar(PaintingContext context, Offset offset) {
    void paintWithOverlay(PaintingContext context, Offset offset) {
      context.paintChild(avatar!, _boxParentData(avatar!).offset + offset);
      _paintSelectionOverlay(context, offset);
    }

    if (theme.showAvatar == false && avatarDrawerAnimation.isDismissed) {
      return;
    }
    final Color disabledColor = _disabledColor;
    final int disabledColorAlpha = disabledColor.alpha;
    if (needsCompositing) {
      context.pushLayer(
          OpacityLayer(alpha: disabledColorAlpha), paintWithOverlay, offset);
    } else {
      if (disabledColorAlpha != 0xff) {
        context.canvas.saveLayer(
          _boxRect(avatar).shift(offset).inflate(20.0),
          Paint()..color = disabledColor,
        );
      }
      paintWithOverlay(context, offset);
      if (disabledColorAlpha != 0xff) {
        context.canvas.restore();
      }
    }
  }

  void _paintChild(PaintingContext context, Offset offset, RenderBox? child,
      bool? isEnabled) {
    if (child == null) {
      return;
    }
    final int disabledColorAlpha = _disabledColor.alpha;
    if (!enableAnimation.isCompleted) {
      if (needsCompositing) {
        context.pushLayer(
          OpacityLayer(alpha: disabledColorAlpha),
          (PaintingContext context, Offset offset) {
            context.paintChild(child, _boxParentData(child).offset + offset);
          },
          offset,
        );
      } else {
        final Rect childRect = _boxRect(child).shift(offset);
        context.canvas.saveLayer(
            childRect.inflate(20.0), Paint()..color = _disabledColor);
        context.paintChild(child, _boxParentData(child).offset + offset);
        context.canvas.restore();
      }
    } else {
      context.paintChild(child, _boxParentData(child).offset + offset);
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    _paintAvatar(context, offset);
    if (deleteIconShowing) {
      _paintChild(context, offset, deleteIcon, isEnabled);
    }
    _paintChild(context, offset, label, isEnabled);
  }

  // Set this to true to have outlines of the tap targets drawn over
  // the chip.  This should never be checked in while set to 'true'.
  static const bool _debugShowTapTargetOutlines = false;

  @override
  void debugPaint(PaintingContext context, Offset offset) {
    assert(!_debugShowTapTargetOutlines ||
        () {
          // Draws a rect around the tap targets to help with visualizing where
          // they really are.
          final Paint outlinePaint = Paint()
            ..color = const Color(0xff800000)
            ..strokeWidth = 1.0
            ..style = PaintingStyle.stroke;
          if (deleteIconShowing) {
            context.canvas
                .drawRect(_deleteButtonRect.shift(offset), outlinePaint);
          }
          context.canvas.drawRect(
            _pressRect.shift(offset),
            outlinePaint..color = const Color(0xff008000),
          );
          return true;
        }());
  }

  @override
  bool hitTestSelf(Offset position) =>
      _deleteButtonRect.contains(position) || _pressRect.contains(position);
}

class _ChipSizes {
  _ChipSizes({
    required this.size,
    required this.overall,
    required this.content,
    required this.avatar,
    required this.label,
    required this.deleteIcon,
    required this.densityAdjustment,
  });
  final Size size;
  final Size overall;
  final double content;
  final Size avatar;
  final Size label;
  final Size deleteIcon;
  final Offset densityAdjustment;
}

class _UnconstrainedInkSplashFactory extends InteractiveInkFeatureFactory {
  const _UnconstrainedInkSplashFactory(this.parentFactory);

  final InteractiveInkFeatureFactory parentFactory;

  @override
  InteractiveInkFeature create({
    required MaterialInkController controller,
    required RenderBox referenceBox,
    required Offset position,
    required Color color,
    required TextDirection textDirection,
    bool containedInkWell = false,
    RectCallback? rectCallback,
    BorderRadius? borderRadius,
    ShapeBorder? customBorder,
    double? radius,
    VoidCallback? onRemoved,
  }) {
    return parentFactory.create(
      controller: controller,
      referenceBox: referenceBox,
      position: position,
      color: color,
      rectCallback: rectCallback,
      borderRadius: borderRadius,
      customBorder: customBorder,
      radius: radius,
      onRemoved: onRemoved,
      textDirection: textDirection,
    );
  }
}

bool _hitIsOnDeleteIcon({
  required EdgeInsetsGeometry padding,
  required Offset tapPosition,
  required Size chipSize,
  required Size deleteButtonSize,
  required TextDirection textDirection,
}) {
  final EdgeInsets resolvedPadding = padding.resolve(textDirection);
  final Size deflatedSize = resolvedPadding.deflateSize(chipSize);
  final Offset adjustedPosition =
      tapPosition - Offset(resolvedPadding.left, resolvedPadding.top);
  final double accessibleDeleteButtonWidth = math.min(
    deflatedSize.width * 0.499,
    math.max(deleteButtonSize.width, 24.0 + deleteButtonSize.width / 2.0),
  );
  switch (textDirection) {
    case TextDirection.ltr:
      return adjustedPosition.dx >=
          deflatedSize.width - accessibleDeleteButtonWidth;
    case TextDirection.rtl:
      return adjustedPosition.dx <= accessibleDeleteButtonWidth;
  }
}
