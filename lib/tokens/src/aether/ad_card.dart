import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class AdCard extends StatelessWidget {
  const AdCard({
    super.key,
    this.color,
    this.shadowColor,
    this.surfaceTintColor,
    this.elevation,
    this.shape,
    this.borderOnForeground = true,
    this.margin,
    this.clipBehavior,
    this.child,
    this.semanticContainer = true,
  })  : assert(elevation == null || elevation >= 0.0),
        assert(borderOnForeground != null);

  final Color? color;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final double? elevation;
  final ShapeBorder? shape;
  final bool borderOnForeground;
  final Clip? clipBehavior;
  final EdgeInsetsGeometry? margin;
  final bool semanticContainer;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final CardTheme cardTheme = CardTheme.of(context);
    final CardTheme defaults = Theme.of(context).useMaterial3
        ? _CardDefaultsM3(context)
        : _CardDefaultsM2(context);

    return Semantics(
      container: semanticContainer,
      child: Container(
        margin: margin ?? cardTheme.margin ?? defaults.margin!,
        child: Material(
          type: MaterialType.card,
          color: color ?? cardTheme.color ?? defaults.color,
          shadowColor:
              shadowColor ?? cardTheme.shadowColor ?? defaults.shadowColor,
          surfaceTintColor: surfaceTintColor ??
              cardTheme.surfaceTintColor ??
              defaults.surfaceTintColor,
          elevation: elevation ?? cardTheme.elevation ?? defaults.elevation!,
          shape: shape ?? cardTheme.shape ?? defaults.shape,
          borderOnForeground: borderOnForeground,
          clipBehavior:
              clipBehavior ?? cardTheme.clipBehavior ?? defaults.clipBehavior!,
          child: Semantics(
            explicitChildNodes: !semanticContainer,
            child: child,
          ),
        ),
      ),
    );
  }
}

class _CardDefaultsM2 extends CardTheme {
  const _CardDefaultsM2(this.context)
      : super(
          clipBehavior: Clip.none,
          elevation: 1.0,
          margin: const EdgeInsets.all(4.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
        );
  final BuildContext context;

  @override
  Color? get color => Theme.of(context).cardColor;

  @override
  Color? get shadowColor => Theme.of(context).shadowColor;
}

class _CardDefaultsM3 extends CardTheme {
  const _CardDefaultsM3(this.context)
      : super(
          clipBehavior: Clip.none,
          elevation: 1.0,
          margin: const EdgeInsets.all(4.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
                bottomLeft: Radius.circular(12.0),
                bottomRight: Radius.circular(12.0)),
          ),
        );
  final BuildContext context;

  @override
  Color? get color => Theme.of(context).cardColor;

  @override
  Color? get shadowColor => Theme.of(context).shadowColor;

  @override
  Color? get surfaceTintColor => Theme.of(context).colorScheme.surfaceTint;
}
