import 'package:flutter/material.dart';
import '../../dart/dart_color.dart';

class AdCheckbox extends StatefulWidget {
  const AdCheckbox({
    super.key,
    required this.value,
    this.tristate = false,
    required this.onChanged,
    this.mouseCursor,
    this.activeColor,
    this.fillColor,
    this.checkColor,
    this.focusColor,
    this.hoverColor,
    this.overlayColor,
    this.splashRadius,
    this.materialTapTargetSize,
    this.visualDensity,
    this.focusNode,
    this.autofocus = false,
    this.shape,
    this.side,
  })  : assert(tristate != null),
        assert(tristate || value != null),
        assert(autofocus != null);

  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final MouseCursor? mouseCursor;
  final Color? activeColor;
  final MaterialStateProperty<Color?>? fillColor;
  final Color? checkColor;
  final bool tristate;
  final MaterialTapTargetSize? materialTapTargetSize;
  final VisualDensity? visualDensity;
  final Color? focusColor;
  final Color? hoverColor;
  final MaterialStateProperty<Color?>? overlayColor;
  final double? splashRadius;
  final FocusNode? focusNode;
  final bool autofocus;
  final OutlinedBorder? shape;
  final BorderSide? side;
  static const double width = 18.0;

  @override
  State<AdCheckbox> createState() => _AdCheckboxState();
}

class _AdCheckboxState extends State<AdCheckbox>
    with TickerProviderStateMixin, ToggleableStateMixin {
  final _AdCheckboxPainter _painter = _AdCheckboxPainter();
  bool? _previousValue;

  @override
  void initState() {
    super.initState();
    _previousValue = widget.value;
  }

  @override
  void didUpdateWidget(AdCheckbox oldwidget) {
    super.didUpdateWidget(oldwidget);
    if (oldwidget.value != widget.value) {
      _previousValue = oldwidget.value;
      animateToValue();
    }
  }

  @override
  void dispose() {
    _painter.dispose();
    super.dispose();
  }

  @override
  ValueChanged<bool?>? get onChanged => widget.onChanged;

  @override
  bool get tristate => widget.tristate;

  @override
  bool? get value => widget.value;

  MaterialStateProperty<Color?> get _widgetFillColor {
    return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return widget.activeColor;
      }
      return null;
    });
  }

  MaterialStateProperty<Color> get _defaultFillColor {
    final ThemeData themeData = Theme.of(context);
    return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        //return themeData.disabledColor;
        return adrColor.backgroundBaseGrey;
      }
      if (states.contains(MaterialState.selected)) {
        //return themeData.toggleableActiveColor;
        return adrColor.backgroundBaseLight;
      }
      return themeData.unselectedWidgetColor;
    });
  }

  MaterialStateProperty<Color> get _disabledCheckColor {
    return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return adrColor.borderBase;
      }
      return adrColor.textSuccess;
    });
  }

  BorderSide? _resolveSide(BorderSide? side) {
    if (side is MaterialStateBorderSide) {
      return MaterialStateProperty.resolveAs<BorderSide?>(side, states);
    }
    if (!states.contains(MaterialState.selected)) {
      return side;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    final ThemeData themeData = Theme.of(context);
    final CheckboxThemeData checkboxTheme = CheckboxTheme.of(context);
    final MaterialTapTargetSize effectiveMaterialTapTargetSize =
        widget.materialTapTargetSize ??
            checkboxTheme.materialTapTargetSize ??
            themeData.materialTapTargetSize;
    final VisualDensity effectiveVisualDensity = widget.visualDensity ??
        checkboxTheme.visualDensity ??
        themeData.visualDensity;
    Size size;
    switch (effectiveMaterialTapTargetSize) {
      case MaterialTapTargetSize.padded:
        size = const Size(kMinInteractiveDimension, kMinInteractiveDimension);
        break;
      case MaterialTapTargetSize.shrinkWrap:
        size = const Size(
            kMinInteractiveDimension - 8.0, kMinInteractiveDimension - 8.0);
        break;
    }
    size += effectiveVisualDensity.baseSizeAdjustment;

    final MaterialStateProperty<MouseCursor> effectiveMouseCursor =
        MaterialStateProperty.resolveWith<MouseCursor>(
            (Set<MaterialState> states) {
      return MaterialStateProperty.resolveAs<MouseCursor?>(
              widget.mouseCursor, states) ??
          checkboxTheme.mouseCursor?.resolve(states) ??
          MaterialStateMouseCursor.clickable.resolve(states);
    });

    final Set<MaterialState> activeStates = states..add(MaterialState.selected);
    final Set<MaterialState> inactiveStates = states
      ..remove(MaterialState.selected);
    final Color effectiveActiveColor =
        widget.fillColor?.resolve(activeStates) ??
            _widgetFillColor.resolve(activeStates) ??
            checkboxTheme.fillColor?.resolve(activeStates) ??
            _defaultFillColor.resolve(activeStates);
    //??adrColor.backgroundBaseLight;
    final Color effectiveInactiveColor =
        widget.fillColor?.resolve(inactiveStates) ??
            _widgetFillColor.resolve(inactiveStates) ??
            checkboxTheme.fillColor?.resolve(inactiveStates) ??
            _defaultFillColor.resolve(inactiveStates);

    final Set<MaterialState> focusedStates = states..add(MaterialState.focused);
    final Color effectiveFocusOverlayColor =
        widget.overlayColor?.resolve(focusedStates) ??
            widget.focusColor ??
            checkboxTheme.overlayColor?.resolve(focusedStates) ??
            themeData.focusColor;

    final Set<MaterialState> hoveredStates = states..add(MaterialState.focused);
    final Color effectiveHoverOverlayColor =
        widget.overlayColor?.resolve(hoveredStates) ??
            widget.hoverColor ??
            checkboxTheme.overlayColor?.resolve(hoveredStates) ??
            themeData.hoverColor;

    final Set<MaterialState> activePressedStates = activeStates
      ..add(MaterialState.pressed);
    final Color effectiveActivePressedOverlayColor =
        widget.overlayColor?.resolve(activePressedStates) ??
            checkboxTheme.overlayColor?.resolve(activePressedStates) ??
            effectiveActiveColor.withAlpha(kRadialReactionAlpha);

    final Set<MaterialState> inactivePressedStates = inactiveStates
      ..add(MaterialState.pressed);
    final Color effectiveInactivePressedOverlayColor =
        widget.overlayColor?.resolve(inactivePressedStates) ??
            checkboxTheme.overlayColor?.resolve(inactivePressedStates) ??
            effectiveActiveColor.withAlpha(kRadialReactionAlpha);

    //TODO CHECKCOLOR KALAU DISABLED return adrColor.borderBase
    // final Set<MaterialState> disabledStates = disabledStates
    //   ..add(MaterialState.disabled);
    final Color effectiveCheckColor = widget.checkColor ??
        checkboxTheme.checkColor?.resolve(states) ??
        _disabledCheckColor.resolve(states);

    //checkboxTheme.checkColor?.resolve(disabledStates) ??
    //_disbledCheckColor;
    //if (states.contains(MaterialState.disabled)) return adrColor.textSuccess;
    //adrColor.textSuccess;
    //const Color(0xFFFFFFFF);

    return Semantics(
      checked: widget.value ?? false,
      child: buildToggleable(
        mouseCursor: effectiveMouseCursor,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        size: size,
        painter: _painter
          ..position = position
          ..reaction = reaction
          ..reactionFocusFade = reactionFocusFade
          ..reactionHoverFade = reactionHoverFade
          ..inactiveReactionColor = effectiveInactivePressedOverlayColor
          ..reactionColor = effectiveActivePressedOverlayColor
          ..hoverColor = effectiveHoverOverlayColor
          ..focusColor = effectiveFocusOverlayColor
          ..splashRadius = widget.splashRadius ??
              checkboxTheme.splashRadius ??
              kRadialReactionRadius
          ..downPosition = downPosition
          ..isFocused = states.contains(MaterialState.focused)
          ..isHovered = states.contains(MaterialState.hovered)
          ..activeColor = effectiveActiveColor
          ..inactiveColor = effectiveInactiveColor
          ..checkColor = effectiveCheckColor
          ..value = value
          ..previousValue = _previousValue
          ..shape = widget.shape ??
              checkboxTheme.shape ??
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              )
          ..side =
              _resolveSide(widget.side) ?? _resolveSide(checkboxTheme.side),
      ),
    );
  }
}

const double _kEdgeSize = AdCheckbox.width;
const double _kStrokeWidth = 2.0;

class _AdCheckboxPainter extends ToggleablePainter {
  Color get checkColor => _checkColor!;
  Color? _checkColor;
  set checkColor(Color value) {
    if (_checkColor == value) {
      return;
    }
    _checkColor = value;
    notifyListeners();
  }

  bool? get value => _value;
  bool? _value;
  set value(bool? value) {
    if (_value == value) {
      return;
    }
    _value = value;
    notifyListeners();
  }

  bool? get previousValue => _previousValue;
  bool? _previousValue;
  set previousValue(bool? value) {
    if (_previousValue == value) {
      return;
    }
    _previousValue = value;
    notifyListeners();
  }

  OutlinedBorder get shape => _shape!;
  OutlinedBorder? _shape;
  set shape(OutlinedBorder value) {
    if (_shape == value) {
      return;
    }
    _shape = value;
    notifyListeners();
  }

  BorderSide? get side => _side;
  BorderSide? _side;
  set side(BorderSide? value) {
    if (_side == value) {
      return;
    }
    _side = value;
    notifyListeners();
  }

  Rect _outerRectAt(Offset origin, double t) {
    final double inset = 1.0 - (t - 0.5).abs() * 2.0;
    final double size = _kEdgeSize - inset * _kStrokeWidth;
    final Rect rect =
        Rect.fromLTWH(origin.dx + inset, origin.dy + inset, size, size);
    return rect;
  }

  Color _colorAt(double t) {
    // As t goes from 0.0 to 0.25, animate from the inactiveColor to activeColor.
    return t >= 0.25
        ? activeColor
        : Color.lerp(inactiveColor, activeColor, t * 4.0)!;
  }

  Paint _createStrokePaint() {
    return Paint()
      ..color = checkColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = _kStrokeWidth;
  }

  void _drawBox(
      Canvas canvas, Rect outer, Paint paint, BorderSide? side, bool fill) {
    if (fill) {
      canvas.drawPath(shape.getOuterPath(outer), paint);
    }
    if (side != null) {
      shape.copyWith(side: side).paint(canvas, outer);
      //canvas.drawPath(shape.getOuterPath(outer), paint);
    }
  }

  void _drawCheck(Canvas canvas, Offset origin, double t, Paint paint) {
    assert(t >= 0.0 && t <= 1.0);

    final Path path = Path();
    const Offset start = Offset(_kEdgeSize * 0.25, _kEdgeSize * 0.45);
    const Offset mid = Offset(_kEdgeSize * 0.45, _kEdgeSize * 0.6);
    const Offset end = Offset(_kEdgeSize * 0.75, _kEdgeSize * 0.28);
    // ORIGINAL VALUE
    // const Offset start = Offset(_kEdgeSize * 0.15, _kEdgeSize * 0.45);
    // const Offset mid = Offset(_kEdgeSize * 0.4, _kEdgeSize * 0.7);
    // const Offset end = Offset(_kEdgeSize * 0.85, _kEdgeSize * 0.25);
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

  void _drawDash(Canvas canvas, Offset origin, double t, Paint paint) {
    assert(t >= 0.0 && t <= 1.0);
    // As t goes from 0.0 to 1.0, animate the horizontal line from the
    // mid point outwards.
    const Offset start = Offset(_kEdgeSize * 0.2, _kEdgeSize * 0.5);
    //const Offset mid = Offset(_kEdgeSize * 0.5, _kEdgeSize * 0.5);
    const Offset mid = Offset(_kEdgeSize * 0.5, _kEdgeSize * 0.5);
    const Offset end = Offset(_kEdgeSize * 0.8, _kEdgeSize * 0.5);
    //final Offset drawStart = Offset.lerp(start, mid, 1.0 - t)!;
    final Offset drawStart = Offset.lerp(start, mid, 2.0 - t)!;
    final Offset drawEnd = Offset.lerp(mid, end, t)!;
    // canvas.drawLine(origin + drawStart, origin + drawEnd, paint);
    //Rect rect = Rect.fromLTWH(11.9, 11.9, 8, 8);
    Rect rect =
        Rect.fromCenter(center: origin + drawStart, width: 8, height: 8);
    Radius radius = Radius.circular(1);
    RRect rRect = RRect.fromRectAndRadius(rect, radius);
    final Paint stroke = Paint()
      ..color = adrColor.backgroundButtonInfoHover
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    canvas.drawRRect(rRect, stroke);
  }

  @override
  void paint(Canvas canvas, Size size) {
    paintRadialReaction(canvas: canvas, origin: size.center(Offset.zero));

    final Paint strokePaint = _createStrokePaint();
    final Offset origin =
        size / 2.0 - const Size.square(_kEdgeSize) / 2.0 as Offset;
    final AnimationStatus status = position.status;
    final double tNormalized =
        status == AnimationStatus.forward || status == AnimationStatus.completed
            ? position.value
            : 1.0 - position.value;

    // Four cases: false to null, false to true, null to false, true to false
    if (previousValue == false || value == false) {
      final double t = value == false ? 1.0 - tNormalized : tNormalized;
      final Rect outer = _outerRectAt(origin, t);
      final Paint paint = Paint()..color = _colorAt(t);

      if (t <= 0.5) {
        final BorderSide border =
            side ?? BorderSide(width: 1, color: adrColor.borderBase);
        //side ?? BorderSide(width: 2, color: paint.color); ORIGINAL VALUE
        _drawBox(canvas, outer, paint, border, false); // only paint the border
      } else {
        _drawBox(canvas, outer, paint, side, true);
        final BorderSide border =
            side ?? BorderSide(width: 1, color: adrColor.borderBase);
        final double tShrink = (t - 0.5) * 2.0;
        if (previousValue == null || value == null) {
          _drawDash(canvas, origin, tShrink, strokePaint);
          _drawBox(canvas, outer, paint, border, false);
        } else {
          _drawCheck(canvas, origin, tShrink, strokePaint);
          _drawBox(canvas, outer, paint, border, false);
        }
      }
    } else {
      // Two cases: null to true, true to null
      final Rect outer = _outerRectAt(origin, 1.0);
      final Paint paint = Paint()..color = _colorAt(1.0);

      _drawBox(canvas, outer, paint, side, true);
      if (tNormalized <= 0.5) {
        final double tShrink = 1.0 - tNormalized * 2.0;
        final BorderSide border =
            side ?? BorderSide(width: 1, color: adrColor.borderBase);
        if (previousValue ?? false) {
          _drawCheck(canvas, origin, tShrink, strokePaint);
          _drawBox(canvas, outer, paint, border, false);
        } else {
          _drawDash(canvas, origin, tShrink, strokePaint);
          _drawBox(canvas, outer, paint, border, false);
        }
      } else {
        final double tExpand = (tNormalized - 0.5) * 2.0;

        final BorderSide border =
            side ?? BorderSide(width: 1, color: adrColor.borderBase);
        if (value ?? false) {
          _drawCheck(canvas, origin, tExpand, strokePaint);
          _drawBox(canvas, outer, paint, border, false);
        } else {
          _drawDash(canvas, origin, tExpand, strokePaint);
          _drawBox(canvas, outer, paint, border, false);
        }
      }
    }
  }
}
