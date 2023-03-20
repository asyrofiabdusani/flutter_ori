import 'package:flutter/material.dart';
import '../../dart/dart_color.dart';
import '../../dart/dart_font.dart';
import '../../dart/dart_size.dart';


class AdButtonPrimary extends StatefulWidget {
  const AdButtonPrimary({
    Key? key,
    required this.text,
    this.danger,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;
  final bool? danger;

  @override
  State<AdButtonPrimary> createState() => _AdButtonPrimaryState();
}

class _AdButtonPrimaryState extends State<AdButtonPrimary> {
  bool? _danger;
  VoidCallback? _onPressed;

  void initState() {
    super.initState();

    _danger = widget.danger;
    _onPressed = widget.onPressed;
  }

  @override
  Widget build(BuildContext context) {
    const nullButtonPrimaryFillColor = adrColor.backgroundDisable;
    const nullButtonTextColor = adrColor.textDisable;
    final notNullButtonPrimaryFillColor = (_danger == !false)
        ? adrColor.backgroundButtonErrorActive
        : adrColor.backgroundButtonPrimaryActive;
    final notNullButtonPrimaryTextColor =
        (_danger == !false) ? adrColor.textWhite : adrColor.textButtonPrimary;

    return Container(
      constraints: const BoxConstraints(minHeight: 40.0),
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(adrSize.buttonRadius)),
        onPressed: widget.onPressed,
        fillColor: (_onPressed == null)
            ? nullButtonPrimaryFillColor
            : notNullButtonPrimaryFillColor,
        hoverColor: (_danger == !false)
            ? adrColor.backgroundButtonErrorHover
            : adrColor.backgroundButtonPrimaryHover,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
          child: Text(
            widget.text,
            style: TextStyle(
                color: (_onPressed == null)
                    ? nullButtonTextColor
                    : notNullButtonPrimaryTextColor,
                fontFamily: adrFont.button1FontFamily,
                fontWeight: adrFont.weightSemibold,
                fontSize: adrFont.button1FontSize),
          ),
        ),
      ),
    );
  }
}

class AdButtonPrimaryIcon extends StatefulWidget {
  const AdButtonPrimaryIcon(
      {Key? key,
      required this.text,
      this.danger,
      required this.onPressed,
      required this.icon})
      : super(key: key);

  final String text;
  final Function() onPressed;
  final bool? danger;
  final IconData? icon;

  @override
  State<AdButtonPrimaryIcon> createState() => _AdButtonPrimaryStateIcon();
}

class _AdButtonPrimaryStateIcon extends State<AdButtonPrimaryIcon> {
  bool? _danger;
  VoidCallback? _onPressed;

  void initState() {
    super.initState();

    _danger = widget.danger;
    _onPressed = widget.onPressed;
  }

  @override
  Widget build(BuildContext context) {
    const nullButtonPrimaryFillColor = adrColor.backgroundDisable;
    const nullButtonTextColor = adrColor.textDisable;
    final notNullButtonPrimaryFillColor = (_danger == !false)
        ? adrColor.backgroundButtonErrorActive
        : adrColor.backgroundButtonPrimaryActive;
    final notNullButtonPrimaryTextColor =
        (_danger == !false) ? adrColor.textWhite : adrColor.textButtonPrimary;

    return Container(
      constraints: const BoxConstraints(minHeight: 40.0),
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        onPressed: widget.onPressed,
        fillColor: (_onPressed == null)
            ? nullButtonPrimaryFillColor
            : notNullButtonPrimaryFillColor,
        hoverColor: (_danger == !false)
            ? adrColor.backgroundButtonErrorHover
            : adrColor.backgroundButtonPrimaryHover,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(
              widget.icon,
              color: (_onPressed == null)
                  ? nullButtonTextColor
                  : notNullButtonPrimaryTextColor,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              widget.text,
              style: TextStyle(
                  color: (_onPressed == null)
                      ? nullButtonTextColor
                      : notNullButtonPrimaryTextColor,
                  fontFamily: adrFont.button1FontFamily,
                  fontWeight: adrFont.weightSemibold,
                  fontSize: adrFont.button1FontSize),
            ),
          ]),
        ),
      ),
    );
  }
}

class AdButtonSecondary extends StatefulWidget {
  const AdButtonSecondary(
      {Key? key, required this.text, this.danger, required this.onPressed})
      : super(key: key);

  final String text;
  final VoidCallback? onPressed;
  final bool? danger;

  @override
  State<AdButtonSecondary> createState() => _AdButtonSecondaryState();
}

class _AdButtonSecondaryState extends State<AdButtonSecondary> {
  bool? _danger;
  VoidCallback? _onPressed;

  void initState() {
    super.initState();

    _danger = widget.danger;
    _onPressed = widget.onPressed;
  }

  @override
  Widget build(BuildContext context) {
    const nullButtonColor = adrColor.backgroundDisable;
    const nullButtonBorder = adrColor.borderDisable;
    const nullButtonTextColor = adrColor.textDisable;

    final notNullButtonFillColor = (_danger == !false)
        ? adrColor.backgroundButtonSecondaryActive
        : adrColor.backgroundButtonSecondaryActive;
    final notNullButtonBorder = (_danger == !false)
        ? adrColor.borderButtonError
        : adrColor.borderButtonLink;
    final notNullButtonTextColor =
        (_danger == !false) ? adrColor.textError : adrColor.textButtonSecondary;

    return Container(
      constraints: const BoxConstraints(minHeight: 40.0),
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(adrSize.buttonRadius)),
        onPressed: widget.onPressed,
        fillColor:
            (_onPressed == null) ? nullButtonColor : notNullButtonFillColor,
        hoverColor: (_danger == !false)
            ? adrColor.backgroundButtonErrorHover
            : adrColor.backgroundButtonSecondaryHover,
        child: Container(
          //constraints: BoxConstraints(minHeight: 40.0),
          decoration: BoxDecoration(
              border: Border.all(
                  color: (_onPressed == null)
                      ? nullButtonBorder
                      : notNullButtonBorder,
                  width: 2), //border color
              borderRadius: BorderRadius.circular(adrSize.buttonRadius)),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
          child: Container(
            constraints: const BoxConstraints(minHeight: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.text,
                  style: TextStyle(
                      color: (_onPressed == null)
                          ? nullButtonTextColor
                          : notNullButtonTextColor,
                      fontFamily: adrFont.button1FontFamily,
                      fontWeight: adrFont.weightSemibold,
                      fontSize: adrFont.button1FontSize),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AdButtonSecondaryIcon extends StatefulWidget {
  const AdButtonSecondaryIcon(
      {Key? key,
      required this.text,
      this.danger,
      required this.onPressed,
      required this.icon})
      : super(key: key);

  final String text;
  final VoidCallback? onPressed;
  final bool? danger;
  final IconData? icon;

  @override
  State<AdButtonSecondaryIcon> createState() => _AdButtonSecondaryStateIcon();
}

class _AdButtonSecondaryStateIcon extends State<AdButtonSecondaryIcon> {
  bool? _danger;
  VoidCallback? _onPressed;

  void initState() {
    super.initState();

    _danger = widget.danger;
    _onPressed = widget.onPressed;
  }

  @override
  Widget build(BuildContext context) {
    const nullButtonColor = adrColor.backgroundDisable;
    const nullButtonBorder = adrColor.borderDisable;
    const nullButtonTextColor = adrColor.textDisable;

    final notNullButtonFillColor = (_danger == !false)
        ? adrColor.backgroundButtonSecondaryActive
        : adrColor.backgroundButtonSecondaryActive;
    final notNullButtonBorder = (_danger == !false)
        ? adrColor.borderButtonError
        : adrColor.borderButtonLink;
    final notNullButtonTextColor =
        (_danger == !false) ? adrColor.textError : adrColor.textButtonSecondary;

    return Container(
      constraints: const BoxConstraints(minHeight: 40.0),
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(adrSize.buttonRadius)),
        onPressed: widget.onPressed,
        fillColor:
            (_onPressed == null) ? nullButtonColor : notNullButtonFillColor,
        hoverColor: (_danger == !false)
            ? adrColor.backgroundButtonErrorHover
            : adrColor.backgroundButtonSecondaryHover,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: (_onPressed == null)
                      ? nullButtonBorder
                      : notNullButtonBorder,
                  width: 2), //border color
              borderRadius: BorderRadius.circular(adrSize.buttonRadius)),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(
              widget.icon,
              color: (_onPressed == null)
                  ? nullButtonTextColor
                  : notNullButtonTextColor,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              widget.text,
              style: TextStyle(
                  color: (_onPressed == null)
                      ? nullButtonTextColor
                      : notNullButtonTextColor,
                  fontFamily: adrFont.button1FontFamily,
                  fontWeight: adrFont.weightSemibold,
                  fontSize: adrFont.button1FontSize),
            ),
          ]),
        ),
      ),
    );
  }
}

class AdButtonText extends StatefulWidget {
  const AdButtonText(
      {Key? key, required this.text, this.danger, required this.onPressed})
      : super(key: key);

  final String text;
  final VoidCallback? onPressed;
  final bool? danger;

  @override
  State<AdButtonText> createState() => _AdButtonTextState();
}

class _AdButtonTextState extends State<AdButtonText> {
  bool? _danger;
  VoidCallback? _onPressed;

  void initState() {
    super.initState();

    _danger = widget.danger;
    _onPressed = widget.onPressed;
  }

  @override
  Widget build(BuildContext context) {
    const nullButtonTextColor = adrColor.textDisable;

    final notNullButtonTextColor =
        (_danger == !false) ? adrColor.textError : adrColor.textButtonSecondary;

    return Container(
      constraints: const BoxConstraints(minHeight: 40.0),
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(adrSize.buttonRadius)),
        onPressed: widget.onPressed,
        hoverColor: (_danger == !false)
            ? adrColor.backgroundButtonErrorHover
            : adrColor.backgroundButtonSecondaryHover,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Text(
              widget.text,
              style: TextStyle(
                  color: (_onPressed == null)
                      ? nullButtonTextColor
                      : notNullButtonTextColor,
                  fontFamily: adrFont.button1FontFamily,
                  fontWeight: adrFont.weightSemibold,
                  fontSize: adrFont.button1FontSize),
            ),
          ]),
        ),
      ),
    );
  }
}

class AdButtonTextIcon extends StatefulWidget {
  const AdButtonTextIcon(
      {Key? key,
      required this.text,
      this.danger,
      required this.onPressed,
      required this.icon})
      : super(key: key);

  final String text;
  final VoidCallback? onPressed;
  final bool? danger;
  final IconData? icon;

  @override
  State<AdButtonTextIcon> createState() => _AdButtonTextIconState();
}

class _AdButtonTextIconState extends State<AdButtonTextIcon> {
  bool? _danger;
  VoidCallback? _onPressed;

  void initState() {
    super.initState();

    _danger = widget.danger;
    _onPressed = widget.onPressed;
  }

  @override
  Widget build(BuildContext context) {
    const nullButtonTextColor = adrColor.textDisable;

    final notNullButtonTextColor =
        (_danger == !false) ? adrColor.textError : adrColor.textButtonSecondary;

    return Container(
      constraints: const BoxConstraints(minHeight: 40.0),
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(adrSize.buttonRadius)),
        onPressed: widget.onPressed,
        hoverColor: (_danger == !false)
            ? adrColor.backgroundButtonErrorHover
            : adrColor.backgroundButtonSecondaryHover,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(
              widget.icon,
              color: (_onPressed == null)
                  ? nullButtonTextColor
                  : notNullButtonTextColor,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              widget.text,
              style: TextStyle(
                  color: (_onPressed == null)
                      ? nullButtonTextColor
                      : notNullButtonTextColor,
                  fontFamily: adrFont.button1FontFamily,
                  fontWeight: adrFont.weightSemibold,
                  fontSize: adrFont.button1FontSize),
            ),
          ]),
        ),
      ),
    );
  }
}

class AdButtonIcon extends StatefulWidget {
  const AdButtonIcon(
      {Key? key, required this.icon, this.danger, required this.onPressed})
      : super(key: key);

  final IconData icon;
  final bool? danger;
  final VoidCallback? onPressed;

  @override
  State<AdButtonIcon> createState() => _AdButtonIconState();
}

class _AdButtonIconState extends State<AdButtonIcon> {
  bool? _danger;
  VoidCallback? _onPressed;

  void initState() {
    super.initState();

    _danger = widget.danger;
    _onPressed = widget.onPressed;
  }

  @override
  Widget build(BuildContext context) {
    const nullButtonTextColor = adrColor.textDisable;

    final notNullButtonTextColor =
        (_danger == !false) ? adrColor.textError : adrColor.textButtonSecondary;

    return RawMaterialButton(
      constraints: const BoxConstraints(minWidth: 40.0, minHeight: 40.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(adrSize.buttonRadius)),
      onPressed: widget.onPressed,
      hoverColor: (_danger == !false)
          ? adrColor.backgroundButtonErrorHover
          : adrColor.backgroundButtonSecondaryHover,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(
            widget.icon,
            color: (_onPressed == null)
                ? nullButtonTextColor
                : notNullButtonTextColor,
          ),
        ]),
      ),
    );
  }
}
