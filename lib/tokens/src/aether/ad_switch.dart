import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../dart/dart_color.dart';

// const double _kTrackHeight = 14.0;
// const double _kTrackWidth = 33.0;
// const double _kTrackRadius = _kTrackHeight / 2.0;
// const double _kThumbRadius = 10.0;
const double _kSwitchMinSize = kMinInteractiveDimension - 8.0;
//const double _kSwitchWidth = _kTrackWidth - 2 * _kTrackRadius + _kSwitchMinSize;
//const double _kSwitchHeight = _kSwitchMinSize + 8.0;
//const double _kSwitchHeightCollapsed = _kSwitchMinSize;

enum _SwitchType { material, adaptive }

class AdSwitch extends StatelessWidget {
  const AdSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.activeTrackColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
    this.activeThumbImage,
    this.onActiveThumbImageError,
    this.inactiveThumbImage,
    this.onInactiveThumbImageError,
    this.thumbColor,
    this.trackColor,
    this.thumbIcon,
    this.materialTapTargetSize,
    this.dragStartBehavior = DragStartBehavior.start,
    this.mouseCursor,
    this.focusColor,
    this.hoverColor,
    this.overlayColor,
    this.splashRadius,
    this.focusNode,
    this.onFocusChange,
    this.autofocus = false,
  })  : _switchType = _SwitchType.material,
        //assert(dragStartBehavior != null),
        assert(activeThumbImage != null || onActiveThumbImageError == null),
        assert(inactiveThumbImage != null || onInactiveThumbImageError == null);

  const AdSwitch.adaptive({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.activeTrackColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
    this.activeThumbImage,
    this.onActiveThumbImageError,
    this.inactiveThumbImage,
    this.onInactiveThumbImageError,
    this.materialTapTargetSize,
    this.thumbColor,
    this.trackColor,
    this.thumbIcon,
    this.dragStartBehavior = DragStartBehavior.start,
    this.mouseCursor,
    this.focusColor,
    this.hoverColor,
    this.overlayColor,
    this.splashRadius,
    this.focusNode,
    this.onFocusChange,
    this.autofocus = false,
  })  : //assert(autofocus != null),
        assert(activeThumbImage != null || onActiveThumbImageError == null),
        assert(inactiveThumbImage != null || onInactiveThumbImageError == null),
        _switchType = _SwitchType.adaptive;

  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color? activeColor;
  final Color? activeTrackColor;
  final Color? inactiveThumbColor;
  final Color? inactiveTrackColor;
  final ImageProvider? activeThumbImage;
  final ImageErrorListener? onActiveThumbImageError;
  final ImageProvider? inactiveThumbImage;
  final ImageErrorListener? onInactiveThumbImageError;
  final MaterialStateProperty<Color?>? thumbColor;
  final MaterialStateProperty<Color?>? trackColor;
  final MaterialStateProperty<Icon?>? thumbIcon;
  final MaterialTapTargetSize? materialTapTargetSize;
  final _SwitchType _switchType;
  final DragStartBehavior dragStartBehavior;
  final MouseCursor? mouseCursor;
  final Color? focusColor;
  final Color? hoverColor;
  final MaterialStateProperty<Color?>? overlayColor;
  final double? splashRadius;
  final FocusNode? focusNode;
  final ValueChanged<bool>? onFocusChange;
  final bool autofocus;

  Size _getSwitchSize(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final SwitchThemeData switchTheme = SwitchTheme.of(context);
    // final _SwitchConfig switchConfig =
    //     theme.useMaterial3 ? _SwitchConfigM3(context) : _SwitchConfigM2();
    final _SwitchConfig switchConfig = _SwitchConfigM3(context);

    final MaterialTapTargetSize effectiveMaterialTapTargetSize =
        materialTapTargetSize ??
            switchTheme.materialTapTargetSize ??
            theme.materialTapTargetSize;
    switch (effectiveMaterialTapTargetSize) {
      // case MaterialTapTargetSize.padded:
      //   return const Size(_kSwitchWidth, _kSwitchHeight);
      case MaterialTapTargetSize.padded:
        return Size(switchConfig.switchWidth, switchConfig.switchHeight);
      case MaterialTapTargetSize.shrinkWrap:
        // return const Size(_kSwitchWidth, _kSwitchHeightCollapsed);
        return Size(
            switchConfig.switchWidth, switchConfig.switchHeightCollapsed);
    }
  }

  Widget _buildCupertinoSwitch(BuildContext context) {
    final Size size = _getSwitchSize(context);
    return Focus(
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      autofocus: autofocus,
      child: Container(
        width: size.width, // Same size as the Material switch.
        height: size.height,
        alignment: Alignment.center,
        child: CupertinoSwitch(
          dragStartBehavior: dragStartBehavior,
          value: value,
          onChanged: onChanged,
          activeColor: activeColor,
          trackColor: inactiveTrackColor,
        ),
      ),
    );
  }

  Widget _buildMaterialSwitch(BuildContext context) {
    return _MaterialSwitch(
      value: value,
      onChanged: onChanged,
      size: _getSwitchSize(context),
      activeColor: activeColor,
      activeTrackColor: activeTrackColor,
      inactiveThumbColor: inactiveThumbColor,
      inactiveTrackColor: inactiveTrackColor,
      activeThumbImage: activeThumbImage,
      onActiveThumbImageError: onActiveThumbImageError,
      inactiveThumbImage: inactiveThumbImage,
      onInactiveThumbImageError: onInactiveThumbImageError,
      thumbColor: thumbColor,
      trackColor: trackColor,
      thumbIcon: thumbIcon,
      materialTapTargetSize: materialTapTargetSize,
      dragStartBehavior: dragStartBehavior,
      mouseCursor: mouseCursor,
      focusColor: focusColor,
      hoverColor: hoverColor,
      overlayColor: overlayColor,
      splashRadius: splashRadius,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      autofocus: autofocus,
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (_switchType) {
      case _SwitchType.material:
        return _buildMaterialSwitch(context);

      case _SwitchType.adaptive:
        {
          final ThemeData theme = Theme.of(context);
          //assert(theme.platform != null);
          switch (theme.platform) {
            case TargetPlatform.android:
            case TargetPlatform.fuchsia:
            case TargetPlatform.linux:
            case TargetPlatform.windows:
              return _buildMaterialSwitch(context);
            case TargetPlatform.iOS:
            case TargetPlatform.macOS:
              return _buildCupertinoSwitch(context);
          }
        }
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('value',
        value: value, ifTrue: 'on', ifFalse: 'off', showName: true));
    properties.add(ObjectFlagProperty<ValueChanged<bool>>(
        'onChanged', onChanged,
        ifNull: 'disabled'));
  }
}

class _MaterialSwitch extends StatefulWidget {
  const _MaterialSwitch({
    required this.value,
    required this.onChanged,
    required this.size,
    this.activeColor,
    this.activeTrackColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
    this.activeThumbImage,
    this.onActiveThumbImageError,
    this.inactiveThumbImage,
    this.onInactiveThumbImageError,
    this.thumbColor,
    this.trackColor,
    this.thumbIcon,
    this.materialTapTargetSize,
    this.dragStartBehavior = DragStartBehavior.start,
    this.mouseCursor,
    this.focusColor,
    this.hoverColor,
    this.overlayColor,
    this.splashRadius,
    this.focusNode,
    this.onFocusChange,
    this.autofocus = false,
  })  : //assert(dragStartBehavior != null),
        assert(activeThumbImage != null || onActiveThumbImageError == null),
        assert(inactiveThumbImage != null || onInactiveThumbImageError == null);

  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color? activeColor;
  final Color? activeTrackColor;
  final Color? inactiveThumbColor;
  final Color? inactiveTrackColor;
  final ImageProvider? activeThumbImage;
  final ImageErrorListener? onActiveThumbImageError;
  final ImageProvider? inactiveThumbImage;
  final ImageErrorListener? onInactiveThumbImageError;
  final MaterialStateProperty<Color?>? thumbColor;
  final MaterialStateProperty<Color?>? trackColor;
  final MaterialStateProperty<Icon?>? thumbIcon;
  final MaterialTapTargetSize? materialTapTargetSize;
  final DragStartBehavior dragStartBehavior;
  final MouseCursor? mouseCursor;
  final Color? focusColor;
  final Color? hoverColor;
  final MaterialStateProperty<Color?>? overlayColor;
  final double? splashRadius;
  final FocusNode? focusNode;
  final Function(bool)? onFocusChange;
  final bool autofocus;
  final Size size;

  @override
  State<_MaterialSwitch> createState() => __MaterialSwitchState();
}

class __MaterialSwitchState extends State<_MaterialSwitch>
    with TickerProviderStateMixin, ToggleableStateMixin {
  final _SwitchPainter _painter = _SwitchPainter();

  @override
  void didUpdateWidget(_MaterialSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      // During a drag we may have modified the curve, reset it if its possible
      // to do without visual discontinuation.
      if (position.value == 0.0 || position.value == 1.0) {
        if (Theme.of(context).useMaterial3) {
          position
            ..curve = Curves.easeOutBack
            ..reverseCurve = Curves.easeOutBack.flipped;
        } else {
          // position
          //   ..curve = Curves.easeIn
          //   ..reverseCurve = Curves.easeOut;
          position
            ..curve = Curves.easeOutBack
            ..reverseCurve = Curves.easeOutBack.flipped;
        }
      }
      animateToValue();
    }
  }

  @override
  void dispose() {
    _painter.dispose();
    super.dispose();
  }

  @override
  ValueChanged<bool?>? get onChanged =>
      widget.onChanged != null ? _handleChanged : null;

  @override
  bool get tristate => false;

  @override
  bool? get value => widget.value;

  MaterialStateProperty<Color?> get _widgetThumbColor {
    return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return widget.inactiveThumbColor;
        //return adrColor.textError;
      }
      if (states.contains(MaterialState.selected)) {
        return widget.activeColor;
      }
      return widget.inactiveThumbColor;
      // return adrColor.textError;
    });
  }

  MaterialStateProperty<Color?> get _widgetTrackColor {
    return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        // return adrColor.textError;
        if (states.contains(MaterialState.selected)) {
          return widget.activeTrackColor;
        }
        return adrColor.backgroundDisable;
      }
      //return adrColor.textError;
      if (states.contains(MaterialState.selected)) {
        return widget.activeTrackColor;
      }
      return widget.inactiveTrackColor;
    });
  }

  double get _trackInnerLength => widget.size.width - _kSwitchMinSize;

  // MaterialStateProperty<Color> get _defaultThumbColor {
  //   final ThemeData theme = Theme.of(context);
  //   final bool isDark = theme.brightness == Brightness.dark;

  //   return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
  //     if (states.contains(MaterialState.disabled)) {
  //       return isDark ? Colors.grey.shade800 : Colors.grey.shade400;
  //     }
  //     if (states.contains(MaterialState.selected)) {
  //       return theme.toggleableActiveColor;
  //     }
  //     return isDark ? Colors.grey.shade400 : Colors.grey.shade50;
  //   });
  // }

  // MaterialStateProperty<Color?> get _widgetTrackColor {
  //   return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
  //     if (states.contains(MaterialState.disabled)) {
  //       return widget.inactiveTrackColor;
  //     }
  //     if (states.contains(MaterialState.selected)) {
  //       return widget.activeTrackColor;
  //     }
  //     return widget.inactiveTrackColor;
  //   });
  // }

  void _handleDragStart(DragStartDetails details) {
    if (isInteractive) {
      reactionController.forward();
    }
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (isInteractive) {
      position
        ..curve = Curves.linear
        ..reverseCurve = null;
      final double delta = details.primaryDelta! / _trackInnerLength;
      switch (Directionality.of(context)) {
        case TextDirection.rtl:
          positionController.value -= delta;
          break;
        case TextDirection.ltr:
          positionController.value += delta;
          break;
      }
    }
  }

  // MaterialStateProperty<Color> get _defaultTrackColor {
  //   final ThemeData theme = Theme.of(context);
  //   final bool isDark = theme.brightness == Brightness.dark;
  //   const Color black32 = Color(0x52000000); // Black with 32% opacity

  //   return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
  //     if (states.contains(MaterialState.disabled)) {
  //       return isDark ? Colors.white10 : Colors.black12;
  //     }
  //     if (states.contains(MaterialState.selected)) {
  //       final Set<MaterialState> activeState = states
  //         ..add(MaterialState.selected);
  //       final Color activeColor = _widgetThumbColor.resolve(activeState) ??
  //           _defaultThumbColor.resolve(activeState);
  //       return activeColor.withAlpha(0x80);
  //     }
  //     return isDark ? Colors.white30 : black32;
  //   });
  // }

  // void _handleDragStart(DragStartDetails details) {
  //   if (isInteractive) {
  //     reactionController.forward();
  //   }
  // }

  // void _handleDragUpdate(DragUpdateDetails details) {
  //   if (isInteractive) {
  //     position
  //       ..curve = Curves.linear
  //       ..reverseCurve = null;
  //     final double delta = details.primaryDelta! / _trackInnerLength;
  //     switch (Directionality.of(context)) {
  //       case TextDirection.rtl:
  //         positionController.value -= delta;
  //         break;
  //       case TextDirection.ltr:
  //         positionController.value += delta;
  //         break;
  //     }
  //   }
  // }

  bool _needsPositionAnimation = false;

  void _handleDragEnd(DragEndDetails details) {
    if (position.value >= 0.5 != widget.value) {
      widget.onChanged?.call(!widget.value);
      // Wait with finishing the animation until widget.value has changed to
      // !widget.value as part of the widget.onChanged call above.
      setState(() {
        _needsPositionAnimation = true;
      });
    } else {
      animateToValue();
    }
    reactionController.reverse();
  }

  void _handleChanged(bool? value) {
    assert(value != null);
    assert(widget.onChanged != null);
    widget.onChanged?.call(value!);
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));

    if (_needsPositionAnimation) {
      _needsPositionAnimation = false;
      animateToValue();
    }

    final ThemeData theme = Theme.of(context);
    final SwitchThemeData switchTheme = SwitchTheme.of(context);
    // final _SwitchConfig switchConfig =
    //     theme.useMaterial3 ? _SwitchConfigM3(context) : _SwitchConfigM2();

    final _SwitchConfig switchConfig = _SwitchConfigM3(context);
    // final SwitchThemeData defaults = theme.useMaterial3
    //     ? _SwitchDefaultsM3(context)
    //     : _SwitchDefaultsM2(context);
    final SwitchThemeData defaults = _SwitchDefaultsM3(context);

    positionController.duration =
        Duration(milliseconds: switchConfig.toggleDuration);

    // Colors need to be resolved in selected and non selected states separately
    // so that they can be lerped between.
    final Set<MaterialState> activeStates = states..add(MaterialState.selected);
    final Set<MaterialState> inactiveStates = states
      ..remove(MaterialState.selected);

    final Color? activeThumbColor = widget.thumbColor?.resolve(activeStates) ??
        _widgetThumbColor.resolve(activeStates) ??
        switchTheme.thumbColor?.resolve(activeStates);
    final Color effectiveActiveThumbColor =
        activeThumbColor ?? defaults.thumbColor!.resolve(activeStates)!;
    //?? adrColor.backgroundButtonPrimaryActive;
    // widget.thumbColor?.resolve(activeStates) ??
    //     _widgetThumbColor.resolve(activeStates) ??
    //     switchTheme.thumbColor?.resolve(activeStates) ??
    //     _defaultThumbColor.resolve(activeStates);
    // final Color effectiveInactiveThumbColor =
    //     widget.thumbColor?.resolve(inactiveStates) ??
    //         _widgetThumbColor.resolve(inactiveStates) ??
    //         switchTheme.thumbColor?.resolve(inactiveStates) ??
    //         _defaults.thumbColor.resolve(inactiveStates);
    final Color? inactiveThumbColor =
        widget.thumbColor?.resolve(inactiveStates);
    final Color effectiveInactiveThumbColor =
        inactiveThumbColor ?? adrColor.backgroundDisable;
    defaults.thumbColor!.resolve(inactiveStates)!;
    // final Color effectiveActiveTrackColor =
    //     widget.trackColor?.resolve(activeStates) ??
    //         _widgetTrackColor.resolve(activeStates) ??
    //         switchTheme.trackColor?.resolve(activeStates) ??
    //         _defaultTrackColor.resolve(activeStates);
    final Color effectiveActiveTrackColor =
        widget.trackColor?.resolve(activeStates) ??
            _widgetTrackColor.resolve(activeStates) ??
            switchTheme.trackColor?.resolve(activeStates) ??
            _widgetThumbColor.resolve(activeStates)?.withAlpha(0x80) ??
            //defaults.trackColor!.resolve(activeStates)!;
            adrColor.backgroundButtonPrimaryActive;
    final Color effectiveInactiveTrackColor =
        widget.trackColor?.resolve(inactiveStates) ??
            _widgetTrackColor.resolve(inactiveStates) ??
            switchTheme.trackColor?.resolve(inactiveStates) ??
            //defaults.trackColor!.resolve(inactiveStates)!;
            adrColor.backgroundButtonLightSelected;
    final Color? effectiveInactiveTrackOutlineColor =
        switchConfig.trackOutlineColor?.resolve(inactiveStates);

    final Icon? effectiveActiveIcon = widget.thumbIcon?.resolve(activeStates) ??
        switchTheme.thumbIcon?.resolve(activeStates);
    final Icon? effectiveInactiveIcon =
        widget.thumbIcon?.resolve(inactiveStates) ??
            switchTheme.thumbIcon?.resolve(inactiveStates);

    final Color effectiveActiveIconColor = effectiveActiveIcon?.color ??
        switchConfig.iconColor.resolve(activeStates);
    final Color effectiveInactiveIconColor = effectiveInactiveIcon?.color ??
        switchConfig.iconColor.resolve(inactiveStates);

    final Set<MaterialState> focusedStates = states..add(MaterialState.focused);
    final Color effectiveFocusOverlayColor =
        widget.overlayColor?.resolve(focusedStates) ??
            widget.focusColor ??
            switchTheme.overlayColor?.resolve(focusedStates) ??
            defaults.overlayColor!.resolve(focusedStates)!;

    final Set<MaterialState> hoveredStates = states..add(MaterialState.hovered);
    //TODO WARNA LINGKARAN LUAR SAAT DI HOVER
    final Color effectiveHoverOverlayColor =
        widget.overlayColor?.resolve(hoveredStates) ??
            widget.hoverColor ??
            switchTheme.overlayColor?.resolve(hoveredStates) ??
            // adrColor.textError;
            defaults.overlayColor!.resolve(hoveredStates)!;

    // final Set<MaterialState> activePressedStates = activeStates
    //   ..add(MaterialState.pressed);
    // final Color effectiveActivePressedThumbColor =
    //     widget.overlayColor?.resolve(activePressedStates) ??
    //         _widgetThumbColor.resolve(activePressedStates) ??
    //         switchTheme.overlayColor?.resolve(activePressedStates) ??
    //         defaults.thumbColor!.resolve(activePressedStates)!;
    // final Color effectiveActivePressedOverlayColor =
    //     widget.overlayColor?.resolve(activePressedStates) ??
    //         switchTheme.overlayColor?.resolve(activePressedStates) ??
    //         activeThumbColor?.withAlpha(kRadialReactionAlpha) ??
    //         defaults.overlayColor!.resolve(activePressedStates)!;
    final Set<MaterialState> activePressedStates = activeStates
      ..add(MaterialState.pressed);
    //TODO INI WARNA KALAU DI PENCET SAAT ACTIVE
    final Color effectiveActivePressedThumbColor =
        widget.thumbColor?.resolve(activePressedStates) ??
            _widgetThumbColor.resolve(activePressedStates) ??
            switchTheme.thumbColor?.resolve(activePressedStates) ??
            const Color(0xffffffff);
    //defaults.thumbColor!.resolve(activePressedStates)!;
    final Color effectiveActivePressedOverlayColor =
        widget.overlayColor?.resolve(activePressedStates) ??
            switchTheme.overlayColor?.resolve(activePressedStates) ??
            activeThumbColor?.withAlpha(kRadialReactionAlpha) ??
            defaults.overlayColor!.resolve(activePressedStates)!;

    // final Set<MaterialState> inactivePressedStates = inactiveStates
    //   ..add(MaterialState.pressed);
    // final Color effectiveInactivePressedThumbColor =
    //     widget.thumbColor?.resolve(inactivePressedStates) ??
    //         _widgetThumbColor.resolve(inactivePressedStates) ??
    //         switchTheme.thumbColor?.resolve(inactivePressedStates) ??
    //         defaults.thumbColor!.resolve(inactivePressedStates)!;
    // final Color effectiveInactivePressedOverlayColor =
    //     widget.overlayColor?.resolve(inactivePressedStates) ??
    //         switchTheme.overlayColor?.resolve(inactivePressedStates) ??
    //         effectiveActiveThumbColor.withAlpha(kRadialReactionAlpha);
    final Set<MaterialState> inactivePressedStates = inactiveStates
      ..add(MaterialState.pressed);
    //TODO INI WARNA KALAU DI PENCET SAAT INACTIVE
    final Color effectiveInactivePressedThumbColor =
        widget.thumbColor?.resolve(inactivePressedStates) ??
            _widgetThumbColor.resolve(inactivePressedStates) ??
            switchTheme.thumbColor?.resolve(inactivePressedStates) ??
            const Color(0xffffffff);
    //defaults.thumbColor!.resolve(inactivePressedStates)!;
    final Color effectiveInactivePressedOverlayColor =
        widget.overlayColor?.resolve(inactivePressedStates) ??
            switchTheme.overlayColor?.resolve(inactivePressedStates) ??
            inactiveThumbColor?.withAlpha(kRadialReactionAlpha) ??
            defaults.overlayColor!.resolve(inactivePressedStates)!;

    final MaterialStateProperty<MouseCursor> effectiveMouseCursor =
        MaterialStateProperty.resolveWith<MouseCursor>(
            (Set<MaterialState> states) {
      return MaterialStateProperty.resolveAs<MouseCursor?>(
              widget.mouseCursor, states) ??
          switchTheme.mouseCursor?.resolve(states) ??
          MaterialStateProperty.resolveAs<MouseCursor>(
              MaterialStateMouseCursor.clickable, states);
    });

    final double effectiveActiveThumbRadius = effectiveActiveIcon == null
        ? switchConfig.activeThumbRadius
        : switchConfig.thumbRadiusWithIcon;
    final double effectiveInactiveThumbRadius =
        effectiveInactiveIcon == null && widget.inactiveThumbImage == null
            ? switchConfig.inactiveThumbRadius
            : switchConfig.thumbRadiusWithIcon;
    final double effectiveSplashRadius = widget.splashRadius ??
        switchTheme.splashRadius ??
        defaults.splashRadius!;

    return Semantics(
      toggled: widget.value,
      child: GestureDetector(
        excludeFromSemantics: true,
        onHorizontalDragStart: _handleDragStart,
        onHorizontalDragUpdate: _handleDragUpdate,
        onHorizontalDragEnd: _handleDragEnd,
        dragStartBehavior: widget.dragStartBehavior,
        child: buildToggleable(
          mouseCursor: effectiveMouseCursor,
          focusNode: widget.focusNode,
          onFocusChange: widget.onFocusChange,
          autofocus: widget.autofocus,
          size: widget.size,
          painter: _painter
            ..position = position
            ..reaction = reaction
            ..reactionFocusFade = reactionFocusFade
            ..reactionHoverFade = reactionHoverFade
            ..inactiveReactionColor = effectiveInactivePressedOverlayColor
            ..reactionColor = effectiveActivePressedOverlayColor
            ..hoverColor = effectiveHoverOverlayColor
            ..focusColor = effectiveFocusOverlayColor
            ..splashRadius = effectiveSplashRadius
            ..downPosition = downPosition
            ..isFocused = states.contains(MaterialState.focused)
            ..isHovered = states.contains(MaterialState.hovered)
            ..activeColor = effectiveActiveThumbColor
            ..inactiveColor = effectiveInactiveThumbColor
            ..activePressedColor = effectiveActivePressedThumbColor
            ..inactivePressedColor = effectiveInactivePressedThumbColor
            ..activeThumbImage = widget.activeThumbImage
            ..onActiveThumbImageError = widget.onActiveThumbImageError
            ..inactiveThumbImage = widget.inactiveThumbImage
            ..onInactiveThumbImageError = widget.onInactiveThumbImageError
            ..activeTrackColor = effectiveActiveTrackColor
            ..inactiveTrackColor = effectiveInactiveTrackColor
            ..inactiveTrackOutlineColor = effectiveInactiveTrackOutlineColor
            ..configuration = createLocalImageConfiguration(context)
            ..isInteractive = isInteractive
            ..trackInnerLength = _trackInnerLength
            ..textDirection = Directionality.of(context)
            ..surfaceColor = theme.colorScheme.surface
            ..inactiveThumbRadius = effectiveInactiveThumbRadius
            ..activeThumbRadius = effectiveActiveThumbRadius
            ..pressedThumbRadius = switchConfig.pressedThumbRadius
            ..thumbOffset = switchConfig.thumbOffset
            ..trackHeight = switchConfig.trackHeight
            ..trackWidth = switchConfig.trackWidth
            ..activeIconColor = effectiveActiveIconColor
            ..inactiveIconColor = effectiveInactiveIconColor
            ..activeIcon = effectiveActiveIcon
            ..inactiveIcon = effectiveInactiveIcon
            ..iconTheme = IconTheme.of(context)
            ..thumbShadow = switchConfig.thumbShadow
            ..transitionalThumbSize = switchConfig.transitionalThumbSize
            ..positionController = positionController,
        ),
      ),
    );
  }
}

class _SwitchPainter extends ToggleablePainter {
  AnimationController get positionController => _positionController!;
  AnimationController? _positionController;
  set positionController(AnimationController? value) {
    assert(value != null);
    if (value == _positionController) {
      return;
    }
    _positionController = value;
    notifyListeners();
  }

  Icon? get activeIcon => _activeIcon;
  Icon? _activeIcon;
  set activeIcon(Icon? value) {
    if (value == _activeIcon) {
      return;
    }
    _activeIcon = value;
    notifyListeners();
  }

  Icon? get inactiveIcon => _inactiveIcon;
  Icon? _inactiveIcon;
  set inactiveIcon(Icon? value) {
    if (value == _inactiveIcon) {
      return;
    }
    _inactiveIcon = value;
    notifyListeners();
  }

  IconThemeData? get iconTheme => _iconTheme;
  IconThemeData? _iconTheme;
  set iconTheme(IconThemeData? value) {
    if (value == _iconTheme) {
      return;
    }
    _iconTheme = value;
    notifyListeners();
  }

  Color get activeIconColor => _activeIconColor!;
  Color? _activeIconColor;
  set activeIconColor(Color value) {
    //assert(value != null);
    if (value == _activeIconColor) {
      return;
    }
    _activeIconColor = value;
    notifyListeners();
  }

  Color get inactiveIconColor => _inactiveIconColor!;
  Color? _inactiveIconColor;
  set inactiveIconColor(Color value) {
    //assert(value != null);
    if (value == _inactiveIconColor) {
      return;
    }
    _inactiveIconColor = value;
    notifyListeners();
  }

  Color get activePressedColor => _activePressedColor!;
  Color? _activePressedColor;
  set activePressedColor(Color? value) {
    assert(value != null);
    if (value == _activePressedColor) {
      return;
    }
    _activePressedColor = value;
    notifyListeners();
  }

  Color get inactivePressedColor => _inactivePressedColor!;
  Color? _inactivePressedColor;
  set inactivePressedColor(Color? value) {
    assert(value != null);
    if (value == _inactivePressedColor) {
      return;
    }
    _inactivePressedColor = value;
    notifyListeners();
  }

  double get activeThumbRadius => _activeThumbRadius!;
  double? _activeThumbRadius;
  set activeThumbRadius(double value) {
    //assert(value != null);
    if (value == _activeThumbRadius) {
      return;
    }
    _activeThumbRadius = value;
    notifyListeners();
  }

  double get inactiveThumbRadius => _inactiveThumbRadius!;
  double? _inactiveThumbRadius;
  set inactiveThumbRadius(double value) {
    //assert(value != null);
    if (value == _inactiveThumbRadius) {
      return;
    }
    _inactiveThumbRadius = value;
    notifyListeners();
  }

  double get pressedThumbRadius => _pressedThumbRadius!;
  double? _pressedThumbRadius;
  set pressedThumbRadius(double value) {
    //assert(value != null);
    if (value == _pressedThumbRadius) {
      return;
    }
    _pressedThumbRadius = value;
    notifyListeners();
  }

  double? get thumbOffset => _thumbOffset;
  double? _thumbOffset;
  set thumbOffset(double? value) {
    if (value == _thumbOffset) {
      return;
    }
    _thumbOffset = value;
    notifyListeners();
  }

  Size get transitionalThumbSize => _transitionalThumbSize!;
  Size? _transitionalThumbSize;
  set transitionalThumbSize(Size value) {
    //assert(value != null);
    if (value == _transitionalThumbSize) {
      return;
    }
    _transitionalThumbSize = value;
    notifyListeners();
  }

  double get trackHeight => _trackHeight!;
  double? _trackHeight;
  set trackHeight(double value) {
    //assert(value != null);
    if (value == _trackHeight) {
      return;
    }
    _trackHeight = value;
    notifyListeners();
  }

  double get trackWidth => _trackWidth!;
  double? _trackWidth;
  set trackWidth(double value) {
    //assert(value != null);
    if (value == _trackWidth) {
      return;
    }
    _trackWidth = value;
    notifyListeners();
  }

  ImageProvider? get activeThumbImage => _activeThumbImage;
  ImageProvider? _activeThumbImage;
  set activeThumbImage(ImageProvider? value) {
    if (value == _activeThumbImage) {
      return;
    }
    _activeThumbImage = value;
    notifyListeners();
  }

  ImageErrorListener? get onActiveThumbImageError => _onActiveThumbImageError;
  ImageErrorListener? _onActiveThumbImageError;
  set onActiveThumbImageError(ImageErrorListener? value) {
    if (value == _onActiveThumbImageError) {
      return;
    }
    _onActiveThumbImageError = value;
    notifyListeners();
  }

  ImageProvider? get inactiveThumbImage => _inactiveThumbImage;
  ImageProvider? _inactiveThumbImage;
  set inactiveThumbImage(ImageProvider? value) {
    if (value == _inactiveThumbImage) {
      return;
    }
    _inactiveThumbImage = value;
    notifyListeners();
  }

  ImageErrorListener? get onInactiveThumbImageError =>
      _onInactiveThumbImageError;
  ImageErrorListener? _onInactiveThumbImageError;
  set onInactiveThumbImageError(ImageErrorListener? value) {
    if (value == _onInactiveThumbImageError) {
      return;
    }
    _onInactiveThumbImageError = value;
    notifyListeners();
  }

  Color get activeTrackColor => _activeTrackColor!;
  Color? _activeTrackColor;
  set activeTrackColor(Color value) {
    //assert(value != null);
    if (value == _activeTrackColor) {
      return;
    }
    _activeTrackColor = value;
    notifyListeners();
  }

  Color? get inactiveTrackOutlineColor => _inactiveTrackOutlineColor;
  Color? _inactiveTrackOutlineColor;
  set inactiveTrackOutlineColor(Color? value) {
    if (value == _inactiveTrackOutlineColor) {
      return;
    }
    _inactiveTrackOutlineColor = value;
    notifyListeners();
  }

  Color get inactiveTrackColor => _inactiveTrackColor!;
  Color? _inactiveTrackColor;
  set inactiveTrackColor(Color value) {
    //assert(value != null);
    if (value == _inactiveTrackColor) {
      return;
    }
    _inactiveTrackColor = value;
    notifyListeners();
  }

  ImageConfiguration get configuration => _configuration!;
  ImageConfiguration? _configuration;
  set configuration(ImageConfiguration value) {
    //assert(value != null);
    if (value == _configuration) {
      return;
    }
    _configuration = value;
    notifyListeners();
  }

  TextDirection get textDirection => _textDirection!;
  TextDirection? _textDirection;
  set textDirection(TextDirection value) {
    //assert(value != null);
    if (_textDirection == value) {
      return;
    }
    _textDirection = value;
    notifyListeners();
  }

  Color get surfaceColor => _surfaceColor!;
  Color? _surfaceColor;
  set surfaceColor(Color value) {
    //assert(value != null);
    if (value == _surfaceColor) {
      return;
    }
    _surfaceColor = value;
    notifyListeners();
  }

  bool get isInteractive => _isInteractive!;
  bool? _isInteractive;
  set isInteractive(bool value) {
    if (value == _isInteractive) {
      return;
    }
    _isInteractive = value;
    notifyListeners();
  }

  double get trackInnerLength => _trackInnerLength!;
  double? _trackInnerLength;
  set trackInnerLength(double value) {
    if (value == _trackInnerLength) {
      return;
    }
    _trackInnerLength = value;
    notifyListeners();
  }

  List<BoxShadow>? get thumbShadow => _thumbShadow;
  List<BoxShadow>? _thumbShadow;
  set thumbShadow(List<BoxShadow>? value) {
    if (value == _thumbShadow) {
      return;
    }
    _thumbShadow = value;
    notifyListeners();
  }

  Color? _cachedThumbColor;
  ImageProvider? _cachedThumbImage;
  ImageErrorListener? _cachedThumbErrorListener;
  BoxPainter? _cachedThumbPainter;

  BoxDecoration _createDefaultThumbDecoration(
      Color color, ImageProvider? image, ImageErrorListener? errorListener) {
    return BoxDecoration(
      color: color,
      image: image == null
          ? null
          : DecorationImage(image: image, onError: errorListener),
      shape: BoxShape.circle,
      boxShadow: kElevationToShadow[1],
    );
  }

  bool _isPainting = false;

  void _handleDecorationChanged() {
    // If the image decoration is available synchronously, we'll get called here
    // during paint. There's no reason to mark ourselves as needing paint if we
    // are already in the middle of painting. (In fact, doing so would trigger
    // an assert).
    if (!_isPainting) {
      notifyListeners();
    }
  }

  bool _stopPressAnimation = false;
  double? _pressedInactiveThumbRadius;
  double? _pressedActiveThumbRadius;

  @override
  void paint(Canvas canvas, Size size) {
    //final bool isEnabled = isInteractive;
    final double currentValue = position.value;

    final double visualPosition;
    switch (textDirection) {
      case TextDirection.rtl:
        visualPosition = 1.0 - currentValue;
        break;
      case TextDirection.ltr:
        visualPosition = currentValue;
        break;
    }

    if (reaction.status == AnimationStatus.reverse && !_stopPressAnimation) {
      _stopPressAnimation = true;
    } else {
      _stopPressAnimation = false;
    }

    // To get the thumb radius when the press ends, the value can be any number
    // between activeThumbRadius/inactiveThumbRadius and pressedThumbRadius.
    if (!_stopPressAnimation) {
      if (reaction.isCompleted) {
        // This happens when the thumb is dragged instead of being tapped.
        _pressedInactiveThumbRadius =
            lerpDouble(inactiveThumbRadius, pressedThumbRadius, reaction.value);
        _pressedActiveThumbRadius =
            lerpDouble(activeThumbRadius, pressedThumbRadius, reaction.value);
      }
      if (currentValue == 0) {
        _pressedInactiveThumbRadius =
            lerpDouble(inactiveThumbRadius, pressedThumbRadius, reaction.value);
        _pressedActiveThumbRadius = activeThumbRadius;
      }
      if (currentValue == 1) {
        _pressedActiveThumbRadius =
            lerpDouble(activeThumbRadius, pressedThumbRadius, reaction.value);
        _pressedInactiveThumbRadius = inactiveThumbRadius;
      }
    }

    final Size inactiveThumbSize =
        Size.fromRadius(_pressedInactiveThumbRadius ?? inactiveThumbRadius);
    final Size activeThumbSize =
        Size.fromRadius(_pressedActiveThumbRadius ?? activeThumbRadius);
    Animation<Size> thumbSizeAnimation(bool isForward) {
      List<TweenSequenceItem<Size>> thumbSizeSequence;
      if (isForward) {
        thumbSizeSequence = <TweenSequenceItem<Size>>[
          TweenSequenceItem<Size>(
            tween: Tween<Size>(
                    begin: inactiveThumbSize, end: transitionalThumbSize)
                .chain(CurveTween(curve: const Cubic(0.31, 0.00, 0.56, 1.00))),
            weight: 11,
          ),
          TweenSequenceItem<Size>(
            tween: Tween<Size>(
                    begin: transitionalThumbSize, end: activeThumbSize)
                .chain(CurveTween(curve: const Cubic(0.20, 0.00, 0.00, 1.00))),
            weight: 72,
          ),
          TweenSequenceItem<Size>(
            tween: ConstantTween<Size>(activeThumbSize),
            weight: 17,
          )
        ];
      } else {
        thumbSizeSequence = <TweenSequenceItem<Size>>[
          TweenSequenceItem<Size>(
            tween: ConstantTween<Size>(inactiveThumbSize),
            weight: 17,
          ),
          TweenSequenceItem<Size>(
            tween: Tween<Size>(
                    begin: inactiveThumbSize, end: transitionalThumbSize)
                .chain(CurveTween(
                    curve: const Cubic(0.20, 0.00, 0.00, 1.00).flipped)),
            weight: 72,
          ),
          TweenSequenceItem<Size>(
            tween:
                Tween<Size>(begin: transitionalThumbSize, end: activeThumbSize)
                    .chain(CurveTween(
                        curve: const Cubic(0.31, 0.00, 0.56, 1.00).flipped)),
            weight: 11,
          ),
        ];
      }

      return TweenSequence<Size>(thumbSizeSequence).animate(positionController);
    }

    Size thumbSize;
    if (reaction.isCompleted) {
      thumbSize = Size.fromRadius(pressedThumbRadius);
    } else {
      if (position.isDismissed || position.status == AnimationStatus.forward) {
        thumbSize = thumbSizeAnimation(true).value;
      } else {
        thumbSize = thumbSizeAnimation(false).value;
      }
    }

    // The thumb contracts slightly during the animation in Material 2.
    final double inset = thumbOffset == null
        ? 0
        : 1.0 - (currentValue - thumbOffset!).abs() * 2.0;
    thumbSize = Size(thumbSize.width - inset, thumbSize.height - inset);

    final double colorValue = CurvedAnimation(
            parent: positionController,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn)
        .value;
    final Color trackColor =
        Color.lerp(inactiveTrackColor, activeTrackColor, currentValue)!;
    final Color? trackOutlineColor = inactiveTrackOutlineColor == null
        ? null
        : Color.lerp(inactiveTrackOutlineColor, Colors.transparent, colorValue);
    // final Color lerpedThumbColor =
    //     Color.lerp(inactiveColor, activeColor, currentValue)!;
    Color lerpedThumbColor;
    if (!reaction.isDismissed) {
      lerpedThumbColor =
          Color.lerp(inactivePressedColor, activePressedColor, colorValue)!;
    } else if (positionController.status == AnimationStatus.forward) {
      lerpedThumbColor =
          Color.lerp(inactivePressedColor, activeColor, colorValue)!;
    } else if (positionController.status == AnimationStatus.reverse) {
      lerpedThumbColor =
          Color.lerp(inactiveColor, activePressedColor, colorValue)!;
    } else {
      lerpedThumbColor = Color.lerp(inactiveColor, activeColor, colorValue)!;
    }

    // Blend the thumb color against a `surfaceColor` background in case the
    // thumbColor is not opaque. This way we do not see through the thumb to the
    // track underneath.
    final Color thumbColor = Color.alphaBlend(lerpedThumbColor, surfaceColor);

    final Icon? thumbIcon = currentValue < 0.5 ? inactiveIcon : activeIcon;

    // final ImageProvider? thumbImage = isEnabled
    //     ? (currentValue < 0.5 ? inactiveThumbImage : activeThumbImage)
    //     : inactiveThumbImage;
    final ImageProvider? thumbImage =
        currentValue < 0.5 ? inactiveThumbImage : activeThumbImage;

    // final ImageErrorListener? thumbErrorListener = isEnabled
    //     ? (currentValue < 0.5
    //         ? onInactiveThumbImageError
    //         : onActiveThumbImageError)
    //     : onInactiveThumbImageError;
    final ImageErrorListener? thumbErrorListener = currentValue < 0.5
        ? onInactiveThumbImageError
        : onActiveThumbImageError;

    final Paint paint = Paint()..color = trackColor;

    final Offset trackPaintOffset =
        _computeTrackPaintOffset(size, trackWidth, trackHeight);
    final Offset thumbPaintOffset =
        _computeThumbPaintOffset(trackPaintOffset, thumbSize, visualPosition);
    final Offset radialReactionOrigin =
        Offset(thumbPaintOffset.dx + thumbSize.height / 2, size.height / 2);

    _paintTrackWith(canvas, paint, trackPaintOffset, trackOutlineColor);
    paintRadialReaction(canvas: canvas, origin: radialReactionOrigin);
    _paintThumbWith(
      thumbPaintOffset,
      canvas,
      currentValue,
      thumbColor,
      thumbImage,
      thumbErrorListener,
      thumbIcon,
      thumbSize,
      inset,
    );
  }

  Offset _computeTrackPaintOffset(
      Size canvasSize, double trackWidth, double trackHeight) {
    final double horizontalOffset = (canvasSize.width - trackWidth) / 2.0;
    final double verticalOffset = (canvasSize.height - trackHeight) / 2.0;

    return Offset(horizontalOffset, verticalOffset);
  }

  Offset _computeThumbPaintOffset(
      Offset trackPaintOffset, Size thumbSize, double visualPosition) {
    // How much thumb radius extends beyond the track
    final double trackRadius = trackHeight / 2;
    // const double additionalThumbRadius = _kThumbRadius - _kTrackRadius;
    final double additionalThumbRadius = thumbSize.height / 2 - trackRadius;
    final double additionalRectWidth = (thumbSize.width - thumbSize.height) / 2;

    final double horizontalProgress = visualPosition * trackInnerLength;
    final double thumbHorizontalOffset =
        trackPaintOffset.dx - additionalThumbRadius + horizontalProgress;
    final double thumbVerticalOffset =
        trackPaintOffset.dy - additionalThumbRadius;

    return Offset(thumbHorizontalOffset, thumbVerticalOffset);
  }

  void _paintTrackWith(Canvas canvas, Paint paint, Offset trackPaintOffset,
      Color? trackOutlineColor) {
    final Rect trackRect = Rect.fromLTWH(
      trackPaintOffset.dx,
      trackPaintOffset.dy,
      trackWidth,
      trackHeight,
    );
    final double trackRadius = trackHeight / 2;
    final RRect trackRRect = RRect.fromRectAndRadius(
      trackRect,
      Radius.circular(trackRadius),
    );

    canvas.drawRRect(trackRRect, paint);

    if (trackOutlineColor != null) {
      // paint track outline
      final Rect outlineTrackRect = Rect.fromLTWH(
        trackPaintOffset.dx + 1,
        trackPaintOffset.dy + 1,
        trackWidth - 2,
        trackHeight - 2,
      );
      final RRect outlineTrackRRect = RRect.fromRectAndRadius(
        outlineTrackRect,
        Radius.circular(trackRadius),
      );
      final Paint outlinePaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = trackOutlineColor;
      canvas.drawRRect(outlineTrackRRect, outlinePaint);
    }
  }

  void _paintThumbWith(
    Offset thumbPaintOffset,
    Canvas canvas,
    double currentValue,
    Color thumbColor,
    ImageProvider? thumbImage,
    ImageErrorListener? thumbErrorListener,
    Icon? thumbIcon,
    Size thumbSize,
    double inset,
  ) {
    try {
      _isPainting = true;
      if (_cachedThumbPainter == null ||
          thumbColor != _cachedThumbColor ||
          thumbImage != _cachedThumbImage ||
          thumbErrorListener != _cachedThumbErrorListener) {
        _cachedThumbColor = thumbColor;
        _cachedThumbImage = thumbImage;
        _cachedThumbErrorListener = thumbErrorListener;
        _cachedThumbPainter?.dispose();
        _cachedThumbPainter = _createDefaultThumbDecoration(
                thumbColor, thumbImage, thumbErrorListener)
            .createBoxPainter(_handleDecorationChanged);
      }
      final BoxPainter thumbPainter = _cachedThumbPainter!;

      // The thumb contracts slightly during the animation
      // final double inset = 1.0 - (currentValue - 0.5).abs() * 2.0;
      // final double radius = _kThumbRadius - inset;

      //   thumbPainter.paint(
      //     canvas,
      //     thumbPaintOffset + Offset(0, inset),
      //     configuration.copyWith(size: Size.fromRadius(radius)),
      //   );
      // } finally {
      //   _isPainting = false;
      // }

      thumbPainter.paint(
        canvas,
        thumbPaintOffset,
        configuration.copyWith(size: thumbSize),
      );

      if (thumbIcon != null && thumbIcon.icon != null) {
        final Color iconColor =
            Color.lerp(inactiveIconColor, activeIconColor, currentValue)!;
        final double iconSize = thumbIcon.size ?? _SwitchConfigM3.iconSize;
        final IconData iconData = thumbIcon.icon!;
        final double? iconWeight = thumbIcon.weight ?? iconTheme?.weight;
        final double? iconFill = thumbIcon.fill ?? iconTheme?.fill;
        final double? iconGrade = thumbIcon.grade ?? iconTheme?.grade;
        final double? iconOpticalSize =
            thumbIcon.opticalSize ?? iconTheme?.opticalSize;
        final List<Shadow>? iconShadows =
            thumbIcon.shadows ?? iconTheme?.shadows;

        final TextSpan textSpan = TextSpan(
          text: String.fromCharCode(iconData.codePoint),
          style: TextStyle(
            fontVariations: <FontVariation>[
              if (iconFill != null) FontVariation('FILL', iconFill),
              if (iconWeight != null) FontVariation('wght', iconWeight),
              if (iconGrade != null) FontVariation('GRAD', iconGrade),
              if (iconOpticalSize != null)
                FontVariation('opsz', iconOpticalSize),
            ],
            color: iconColor,
            fontSize: iconSize,
            inherit: false,
            fontFamily: iconData.fontFamily,
            package: iconData.fontPackage,
            shadows: iconShadows,
          ),
        );
        final TextPainter textPainter = TextPainter(
          textDirection: textDirection,
          text: textSpan,
        );
        textPainter.layout();
        final double additionalHorizontalOffset =
            (thumbSize.width - iconSize) / 2;
        final double additionalVerticalOffset =
            (thumbSize.height - iconSize) / 2;
        final Offset offset = thumbPaintOffset +
            Offset(additionalHorizontalOffset, additionalVerticalOffset);

        textPainter.paint(canvas, offset);
      }
    } finally {
      _isPainting = false;
    }
  }

  @override
  void dispose() {
    _cachedThumbPainter?.dispose();
    _cachedThumbPainter = null;
    _cachedThumbColor = null;
    _cachedThumbImage = null;
    _cachedThumbErrorListener = null;
    super.dispose();
  }
}

mixin _SwitchConfig {
  double get trackHeight;
  double get trackWidth;
  double get switchWidth;
  double get switchHeight;
  double get switchHeightCollapsed;
  double get activeThumbRadius;
  double get inactiveThumbRadius;
  double get pressedThumbRadius;
  double get thumbRadiusWithIcon;
  List<BoxShadow>? get thumbShadow;
  MaterialStateProperty<Color?>? get trackOutlineColor;
  MaterialStateProperty<Color> get iconColor;
  double? get thumbOffset;
  Size get transitionalThumbSize;
  int get toggleDuration;
}

// Hand coded defaults based on Material Design 2.
class _SwitchConfigM2 with _SwitchConfig {
  _SwitchConfigM2();

  @override
  double get activeThumbRadius => 10.0;

  @override
  MaterialStateProperty<Color> get iconColor =>
      MaterialStateProperty.all<Color>(Colors.transparent);

  @override
  double get inactiveThumbRadius => 10.0;

  @override
  double get pressedThumbRadius => 10.0;

  @override
  double get switchHeight => _kSwitchMinSize + 8.0;

  @override
  double get switchHeightCollapsed => _kSwitchMinSize;

  @override
  double get switchWidth =>
      trackWidth - 2 * (trackHeight / 2.0) + _kSwitchMinSize;

  @override
  double get thumbRadiusWithIcon => 10.0;

  @override
  List<BoxShadow>? get thumbShadow => kElevationToShadow[1];

  @override
  double get trackHeight => 14.0;

  @override
  MaterialStateProperty<Color?>? get trackOutlineColor => null;

  @override
  double get trackWidth => 33.0;

  @override
  double get thumbOffset => 0.5;

  @override
  Size get transitionalThumbSize => const Size(20, 20);

  @override
  int get toggleDuration => 200;
}

class _SwitchDefaultsM2 extends SwitchThemeData {
  _SwitchDefaultsM2(BuildContext context)
      : _theme = Theme.of(context),
        _colors = Theme.of(context).colorScheme;

  final ThemeData _theme;
  final ColorScheme _colors;

  @override
  MaterialStateProperty<Color> get thumbColor {
    final bool isDark = _theme.brightness == Brightness.dark;

    return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return isDark
            ? Colors.grey.shade800
            //const Color(0xffffffff)
            :
            //adrColor.textError;
            Colors.grey.shade400;
      }
      if (states.contains(MaterialState.selected)) {
        return _colors.secondary;
        //return adrColor.textError;
      }
      return isDark ? Colors.grey.shade400 : Colors.grey.shade50;
      //return isDark ? Colors.blue : Colors.green;
    });
  }

  @override
  MaterialStateProperty<Color> get trackColor {
    final bool isDark = _theme.brightness == Brightness.dark;
    const Color black32 = Color(0x52000000); // Black with 32% opacity

    return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return isDark ? Colors.white10 : Colors.black12;
      }
      if (states.contains(MaterialState.selected)) {
        final Color activeColor = _colors.secondary;
        return activeColor.withAlpha(0x80);
      }
      return isDark ? Colors.white30 : black32;
    });
  }

  @override
  MaterialTapTargetSize get materialTapTargetSize =>
      _theme.materialTapTargetSize;

  @override
  MaterialStateProperty<MouseCursor> get mouseCursor =>
      MaterialStateProperty.resolveWith((Set<MaterialState> states) =>
          MaterialStateMouseCursor.clickable.resolve(states));

  @override
  //TODO INI GK PAHAM APAAN
  MaterialStateProperty<Color?> get overlayColor {
    return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return thumbColor.resolve(states).withAlpha(kRadialReactionAlpha);
      }
      if (states.contains(MaterialState.focused)) {
        return _theme.focusColor;
      }
      if (states.contains(MaterialState.hovered)) {
        return _theme.hoverColor;
        // adrColor.textError;
      }
      return null;
    });
  }

  @override
  double get splashRadius => kRadialReactionRadius;
}

// BEGIN GENERATED TOKEN PROPERTIES - Switch

// Do not edit by hand. The code between the "BEGIN GENERATED" and
// "END GENERATED" comments are generated from data in the Material
// Design token database by the script:
//   dev/tools/gen_defaults/bin/gen_defaults.dart.

// Token database version: v0_143

class _SwitchDefaultsM3 extends SwitchThemeData {
  _SwitchDefaultsM3(BuildContext context)
      : _colors = Theme.of(context).colorScheme;

  final ColorScheme _colors;

  @override
  MaterialStateProperty<Color> get thumbColor {
    return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        if (states.contains(MaterialState.selected)) {
          return _colors.surface.withOpacity(1.0);
        }
        return _colors.onSurface.withOpacity(0.38);
      }
      if (states.contains(MaterialState.selected)) {
        if (states.contains(MaterialState.pressed)) {
          return _colors.primaryContainer;
        }
        if (states.contains(MaterialState.hovered)) {
          // return _colors.primaryContainer;
          //TODO WARNA THUMB AKTIF SAAT DI HOVER DISINI
          return const Color(0xffffffff);
        }
        if (states.contains(MaterialState.focused)) {
          return _colors.primaryContainer;
        }
        return _colors.onPrimary;
      }
      if (states.contains(MaterialState.pressed)) {
        return _colors.onSurfaceVariant;
      }
      if (states.contains(MaterialState.hovered)) {
        // return _colors.onSurfaceVariant;
        //TODO WARNA THUMB INAKTIF SAAT DI HOVER DISINI
        return const Color(0xffffffff);
      }
      if (states.contains(MaterialState.focused)) {
        return _colors.onSurfaceVariant;
      }
      return _colors.outline;
      //return adrColor.backgroundDisable;
    });
  }

  @override
  MaterialStateProperty<Color> get trackColor {
    return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        if (states.contains(MaterialState.selected)) {
          return _colors.onSurface.withOpacity(0.12);
        }
        return _colors.surfaceVariant.withOpacity(0.12);
      }
      if (states.contains(MaterialState.selected)) {
        if (states.contains(MaterialState.pressed)) {
          return _colors.primary;
        }
        if (states.contains(MaterialState.hovered)) {
          return _colors.primary;
        }
        if (states.contains(MaterialState.focused)) {
          return _colors.primary;
        }
        return _colors.primary;
      }
      if (states.contains(MaterialState.pressed)) {
        return _colors.surfaceVariant;
      }
      if (states.contains(MaterialState.hovered)) {
        return _colors.surfaceVariant;
      }
      if (states.contains(MaterialState.focused)) {
        return _colors.surfaceVariant;
      }
      return _colors.surfaceVariant;
    });
  }

  @override
  MaterialStateProperty<Color?> get overlayColor {
    return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        if (states.contains(MaterialState.pressed)) {
          return _colors.primary.withOpacity(0.12);
        }
        if (states.contains(MaterialState.hovered)) {
          return _colors.primary.withOpacity(0.08);
        }
        if (states.contains(MaterialState.focused)) {
          return _colors.primary.withOpacity(0.12);
        }
        return null;
      }
      if (states.contains(MaterialState.pressed)) {
        return _colors.onSurface.withOpacity(0.12);
      }
      if (states.contains(MaterialState.hovered)) {
        return _colors.onSurface.withOpacity(0.08);
      }
      if (states.contains(MaterialState.focused)) {
        return _colors.onSurface.withOpacity(0.12);
      }
      return null;
    });
  }

  @override
  double get splashRadius => 40.0 / 2;
}

class _SwitchConfigM3 with _SwitchConfig {
  _SwitchConfigM3(this.context) : _colors = Theme.of(context).colorScheme;

  BuildContext context;
  final ColorScheme _colors;

  static const double iconSize = 16.0;

  @override
  double get activeThumbRadius => 24.0 / 2;

  @override
  MaterialStateProperty<Color> get iconColor {
    return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        if (states.contains(MaterialState.selected)) {
          return _colors.onSurface.withOpacity(0.38);
        }
        return _colors.surfaceVariant.withOpacity(0.38);
      }
      if (states.contains(MaterialState.selected)) {
        if (states.contains(MaterialState.pressed)) {
          return _colors.onPrimaryContainer;
        }
        if (states.contains(MaterialState.hovered)) {
          return _colors.onPrimaryContainer;
          // return adrColor.textError;
        }
        if (states.contains(MaterialState.focused)) {
          return _colors.onPrimaryContainer;
        }
        return _colors.onPrimaryContainer;
      }
      if (states.contains(MaterialState.pressed)) {
        return _colors.surfaceVariant;
      }
      if (states.contains(MaterialState.hovered)) {
        return _colors.surfaceVariant;
        // return adrColor.textError;
      }
      if (states.contains(MaterialState.focused)) {
        return _colors.surfaceVariant;
      }
      return _colors.surfaceVariant;
    });
  }

  @override
  double get inactiveThumbRadius => 24.0 / 2;

  @override
  double get pressedThumbRadius => 28.0 / 2;

  @override
  double get switchHeight => _kSwitchMinSize + 8.0;

  @override
  double get switchHeightCollapsed => _kSwitchMinSize;

  @override
  double get switchWidth =>
      trackWidth - 2 * (trackHeight / 2.0) + _kSwitchMinSize;

  @override
  double get thumbRadiusWithIcon => 24.0 / 2;

  @override
  List<BoxShadow>? get thumbShadow => kElevationToShadow[0];

  @override
  double get trackHeight => 32.0;

  @override
  MaterialStateProperty<Color?> get trackOutlineColor {
    return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return null;
      }
      if (states.contains(MaterialState.disabled)) {
        return _colors.onSurface.withOpacity(0.12);
      }
      //TODO WARNA OUTLINE DISINI
      return null;
      // return adrColor.textError;
      // return _colors.outline;
    });
  }

  @override
  double get trackWidth => 52.0;

  // The thumb size at the middle of the track. Hand coded default based on the animation specs.
  @override
  Size get transitionalThumbSize => const Size(34, 22);

  // Hand coded default based on the animation specs.
  @override
  int get toggleDuration => 300;

  // Hand coded default based on the animation specs.
  @override
  double? get thumbOffset => null;
}

// END GENERATED TOKEN PROPERTIES - Switch

