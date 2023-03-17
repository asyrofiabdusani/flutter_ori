import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'ad_switch.dart';

enum _SwitchListTileType { material, adaptive }

class AdSwitchListTile extends StatelessWidget {
  const AdSwitchListTile({
    super.key,
    required this.value,
    required this.onChanged,
    this.tileColor,
    this.activeColor,
    this.activeTrackColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
    this.activeThumbImage,
    this.inactiveThumbImage,
    this.title,
    this.subtitle,
    this.isThreeLine = false,
    this.dense,
    this.contentPadding,
    this.secondary,
    this.selected = false,
    this.autofocus = false,
    this.controlAffinity = ListTileControlAffinity.leading,
    this.shape,
    this.selectedTileColor,
    this.visualDensity,
    this.focusNode,
    this.onFocusChange,
    this.enableFeedback,
    this.hoverColor,
  }) : _switchListTileType = _SwitchListTileType.material;
  // assert(value != null),
  // assert(isThreeLine != null),
  // assert(!isThreeLine || subtitle != null),
  // assert(selected != null),
  // assert(autofocus != null);

  const AdSwitchListTile.adaptive({
    super.key,
    required this.value,
    required this.onChanged,
    this.tileColor,
    this.activeColor,
    this.activeTrackColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
    this.activeThumbImage,
    this.inactiveThumbImage,
    this.title,
    this.subtitle,
    this.isThreeLine = false,
    this.dense,
    this.contentPadding,
    this.secondary,
    this.selected = false,
    this.autofocus = false,
    this.controlAffinity = ListTileControlAffinity.leading,
    this.shape,
    this.selectedTileColor,
    this.visualDensity,
    this.focusNode,
    this.onFocusChange,
    this.enableFeedback,
    this.hoverColor,
  }) : _switchListTileType = _SwitchListTileType.adaptive;
  // assert(value != null),
  // assert(isThreeLine != null),
  // assert(!isThreeLine || subtitle != null),
  // assert(selected != null),
  // assert(autofocus != null);

  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color? activeColor;
  final Color? activeTrackColor;
  final Color? inactiveThumbColor;
  final Color? inactiveTrackColor;
  final Color? tileColor;
  final ImageProvider? activeThumbImage;
  //final ImageErrorListener? onActiveThumbImageError;
  final ImageProvider? inactiveThumbImage;
  final Widget? title;
  final Widget? subtitle;
  final Widget? secondary;
  final bool isThreeLine;
  final bool? dense;
  //final ImageErrorListener? onInactiveThumbImageError;
  //final MaterialStateProperty<Color?>? thumbColor;
  //final MaterialStateProperty<Color?>? trackColor;
  // final MaterialStateProperty<Icon?>? thumbIcon;
  //final MaterialTapTargetSize? materialTapTargetSize;
  //final MouseCursor? mouseCursor;
  //final Color? focusColor;
  final Color? hoverColor;
  //final MaterialStateProperty<Color?>? overlayColor;
  //final double? splashRadius;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? contentPadding;
  final bool selected;
  final bool autofocus;
  final _SwitchListTileType _switchListTileType;
  final ListTileControlAffinity controlAffinity;
  final ShapeBorder? shape;
  final Color? selectedTileColor;
  final VisualDensity? visualDensity;
  final ValueChanged<bool>? onFocusChange;
  final bool? enableFeedback;

  @override
  Widget build(BuildContext context) {
    final Widget control;
    switch (_switchListTileType) {
      case _SwitchListTileType.adaptive:
        control = AdSwitch.adaptive(
          value: value,
          onChanged: onChanged,
          activeColor: activeColor,
          activeThumbImage: activeThumbImage,
          inactiveThumbImage: inactiveThumbImage,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          activeTrackColor: activeTrackColor,
          inactiveTrackColor: inactiveTrackColor,
          inactiveThumbColor: inactiveThumbColor,
          autofocus: autofocus,
          onFocusChange: onFocusChange,
        );
        break;

      case _SwitchListTileType.material:
        control = AdSwitch(
          value: value,
          onChanged: onChanged,
          activeColor: activeColor,
          activeThumbImage: activeThumbImage,
          inactiveThumbImage: inactiveThumbImage,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          activeTrackColor: activeTrackColor,
          inactiveTrackColor: inactiveTrackColor,
          inactiveThumbColor: inactiveThumbColor,
          autofocus: autofocus,
          onFocusChange: onFocusChange,
        );
    }

    Widget? leading, trailing;
    switch (controlAffinity) {
      case ListTileControlAffinity.leading:
        leading = control;
        trailing = secondary;
        break;
      case ListTileControlAffinity.trailing:
      case ListTileControlAffinity.platform:
        leading = secondary;
        trailing = control;
        break;
    }

    final ThemeData theme = Theme.of(context);
    final SwitchThemeData switchTheme = SwitchTheme.of(context);
    final Set<MaterialState> states = <MaterialState>{
      if (selected) MaterialState.selected,
    };
    final Color effectiveActiveColor = activeColor ??
        switchTheme.thumbColor?.resolve(states) ??
        theme.colorScheme.secondary;
    return MergeSemantics(
      child: ListTile(
        selectedColor: effectiveActiveColor,
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: trailing,
        isThreeLine: isThreeLine,
        dense: dense,
        contentPadding: contentPadding,
        enabled: onChanged != null,
        onTap: onChanged != null
            ? () {
                onChanged!(!value);
              }
            : null,
        selected: selected,
        selectedTileColor: selectedTileColor,
        autofocus: autofocus,
        shape: shape,
        tileColor: tileColor,
        visualDensity: visualDensity,
        focusNode: focusNode,
        onFocusChange: onFocusChange,
        enableFeedback: enableFeedback,
        hoverColor: hoverColor,
      ),
    );
  }
}
