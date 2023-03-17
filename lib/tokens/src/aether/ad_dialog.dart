import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show clampDouble;
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../dart/dart_color.dart';
import '../../dart/dart_font.dart';

const EdgeInsets _defaultInsetPadding =
    EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0);

class AdDialog extends StatelessWidget {
  const AdDialog({
    super.key,
    this.backgroundColor,
    this.elevation,
    this.insetAnimationDuration = const Duration(milliseconds: 100),
    this.insetAnimationCurve = Curves.decelerate,
    this.insetPadding = _defaultInsetPadding,
    this.clipBehavior = Clip.none,
    this.shape,
    this.alignment,
    this.child,
  }) : assert(clipBehavior != null);

  final Color? backgroundColor;
  final double? elevation;
  final Duration insetAnimationDuration;
  final Curve insetAnimationCurve;
  final EdgeInsets? insetPadding;
  final Clip clipBehavior;
  final ShapeBorder? shape;
  final AlignmentGeometry? alignment;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final DialogTheme dialogTheme = DialogTheme.of(context);
    final DialogTheme defaults = theme.useMaterial3
        ? _DialogDefaultsM3(context)
        : _DialogDefaultsM2(context);

    final EdgeInsets effectivePadding =
        MediaQuery.of(context).viewInsets + (insetPadding ?? EdgeInsets.zero);

    return AnimatedPadding(
      padding: effectivePadding,
      duration: insetAnimationDuration,
      curve: insetAnimationCurve,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Align(
          alignment: alignment ?? dialogTheme.alignment ?? defaults.alignment!,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 280.0),
            child: Material(
              color: backgroundColor ??
                  dialogTheme.backgroundColor ??
                  Theme.of(context).dialogBackgroundColor,
              elevation:
                  elevation ?? dialogTheme.elevation ?? defaults.elevation!,
              shape: shape ?? dialogTheme.shape ?? defaults.shape!,
              type: MaterialType.card,
              clipBehavior: clipBehavior,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

class AdAlertDialog extends StatelessWidget {
  const AdAlertDialog({
    super.key,
    this.icon,
    this.iconPadding,
    this.iconColor,
    this.title,
    this.titlePadding,
    this.titleTextStyle,
    this.content,
    this.contentPadding,
    this.contentTextStyle,
    this.actions,
    this.actionsPadding,
    this.actionsAlignment,
    this.actionsOverflowAlignment,
    this.actionsOverflowDirection,
    this.actionsOverflowButtonSpacing,
    this.buttonPadding,
    this.backgroundColor,
    this.elevation,
    this.semanticLabel,
    this.insetPadding = _defaultInsetPadding,
    this.clipBehavior = Clip.none,
    this.shape,
    this.alignment,
    this.scrollable = false,
  }) : assert(clipBehavior != null);

  final Widget? icon;
  final Color? iconColor;
  final EdgeInsetsGeometry? iconPadding;
  final Widget? title;
  final EdgeInsetsGeometry? titlePadding;
  final TextStyle? titleTextStyle;
  final Widget? content;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? contentTextStyle;
  final List<Widget>? actions;
  final EdgeInsetsGeometry? actionsPadding;
  final MainAxisAlignment? actionsAlignment;
  final OverflowBarAlignment? actionsOverflowAlignment;
  final VerticalDirection? actionsOverflowDirection;
  final double? actionsOverflowButtonSpacing;
  final EdgeInsetsGeometry? buttonPadding;
  final Color? backgroundColor;
  final double? elevation;
  final String? semanticLabel;
  final EdgeInsets insetPadding;
  final Clip clipBehavior;
  final ShapeBorder? shape;
  final AlignmentGeometry? alignment;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    final ThemeData theme = Theme.of(context);
    final DialogTheme dialogTheme = DialogTheme.of(context);
    final DialogTheme defaults = theme.useMaterial3
        ? _DialogDefaultsM3(context)
        : _DialogDefaultsM2(context);

    String? label = semanticLabel;
    switch (theme.platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        label ??= MaterialLocalizations.of(context).alertDialogLabel;
    }

    // The paddingScaleFactor is used to adjust the padding of Dialog's
    // children.
    final double paddingScaleFactor =
        _paddingScaleFactor(MediaQuery.of(context).textScaleFactor);
    final TextDirection? textDirection = Directionality.maybeOf(context);

    Widget? iconWidget;
    Widget? titleWidget;
    Widget? contentWidget;
    Widget? actionsWidget;

    if (icon != null) {
      final bool belowIsTitle = title != null;
      final bool belowIsContent = !belowIsTitle && content != null;
      final EdgeInsets defaultIconPadding = EdgeInsets.only(
          left: 24.0,
          top: 24.0,
          right: 24.0,
          bottom: belowIsTitle
              ? 16.0
              : belowIsContent
                  ? 0.0
                  : 24.0);
      final EdgeInsets effectiveIconPadding =
          iconPadding?.resolve(textDirection) ?? defaultIconPadding;
      final Color adAlertDialogIconColor = Color(0xff667085);
      iconWidget = Padding(
        padding: EdgeInsets.only(
            left: effectiveIconPadding.left * paddingScaleFactor,
            right: effectiveIconPadding.right * paddingScaleFactor,
            top: effectiveIconPadding.top * paddingScaleFactor,
            bottom: effectiveIconPadding.bottom),
        child: IconTheme(
          data: IconThemeData(
              color: iconColor ??
                  dialogTheme.iconColor ??
                  //defaults.iconColor ??
                  adAlertDialogIconColor),
          child: icon!,
        ),
      );
    }

    if (title != null) {
      final EdgeInsets defaultTitlePadding = EdgeInsets.only(
        left: 24.0,
        top: icon == null ? 24.0 : 0.0,
        right: 24,
        bottom: content == null ? 20.0 : 0.0,
      );
      final EdgeInsets effectiveTitlePadding =
          titlePadding?.resolve(textDirection) ?? defaultTitlePadding;
      const TextStyle adDialogTitleTextStye = TextStyle(
          color: adrColor.textNormal,
          fontWeight: adrFont.weightSemibold,
          fontSize: adrFont.h4FontSize);
      titleWidget = Padding(
        padding: EdgeInsets.only(
          left: effectiveTitlePadding.left * paddingScaleFactor,
          right: effectiveTitlePadding.right * paddingScaleFactor,
          top: icon == null
              ? effectiveTitlePadding.top * paddingScaleFactor
              : effectiveTitlePadding.top,
          bottom: effectiveTitlePadding.bottom,
        ),
        child: DefaultTextStyle(
          style: titleTextStyle ??
              dialogTheme.titleTextStyle ??
              //defaults.titleTextStyle ??
              adDialogTitleTextStye,
          textAlign: icon == null ? TextAlign.start : TextAlign.center,
          child: Semantics(
            namesRoute: label == null && theme.platform != TargetPlatform.iOS,
            container: true,
            child: title,
          ),
        ),
      );
    }

    if (content != null) {
      final EdgeInsets defaultContentPadding = EdgeInsets.only(
        left: 24.0,
        //top: theme.useMaterial3 ? 16.0 : 20.0,
        top: theme.useMaterial3 ? 16.0 : 16.0,
        right: 24.0,
        //bottom: 24.0,
        bottom: 00.0,
      );
      final EdgeInsets effectiveContentPadding =
          contentPadding?.resolve(textDirection) ?? defaultContentPadding;
      const TextStyle adDialogContentTextStye = TextStyle(
          color: adrColor.textNormal,
          fontWeight: adrFont.weightRegular,
          fontSize: adrFont.body2FontSize);
      contentWidget = Padding(
        padding: EdgeInsets.only(
          left: effectiveContentPadding.left * paddingScaleFactor,
          right: effectiveContentPadding.right * paddingScaleFactor,
          top: title == null && icon == null
              ? (effectiveContentPadding.top * paddingScaleFactor) + 8
              : effectiveContentPadding.top,
          bottom: effectiveContentPadding.bottom,
        ),
        child: DefaultTextStyle(
          style: contentTextStyle ??
              dialogTheme.contentTextStyle ??
              //defaults.contentTextStyle! ??
              adDialogContentTextStye,
          child: Semantics(
            container: true,
            child: content,
          ),
        ),
      );
    }

    if (actions != null) {
      // final double spacing = (buttonPadding?.horizontal ?? 16) / 2;
      final double spacing = (buttonPadding?.horizontal ?? 24) / 2;
      actionsWidget = Padding(
        padding: actionsPadding ??
            dialogTheme.actionsPadding ??
            (theme.useMaterial3
                ? defaults.actionsPadding!
                : defaults.actionsPadding!.add(EdgeInsets.all(spacing))),
        child: OverflowBar(
          alignment: actionsAlignment ?? MainAxisAlignment.end,
          spacing: spacing,
          overflowAlignment:
              actionsOverflowAlignment ?? OverflowBarAlignment.end,
          overflowDirection: actionsOverflowDirection ?? VerticalDirection.down,
          overflowSpacing: actionsOverflowButtonSpacing ?? 0,
          children: actions!,
        ),
      );
    }

    List<Widget> columnChildren;
    if (scrollable) {
      columnChildren = <Widget>[
        if (title != null || content != null)
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  if (icon != null) iconWidget!,
                  if (title != null) titleWidget!,
                  if (content != null) contentWidget!,
                ],
              ),
            ),
          ),
        if (actions != null) actionsWidget!,
      ];
    } else {
      columnChildren = <Widget>[
        if (icon != null) iconWidget!,
        if (title != null) titleWidget!,
        if (content != null) Flexible(child: contentWidget!),
        if (actions != null) actionsWidget!,
      ];
    }

    Widget dialogChild = IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: columnChildren,
      ),
    );

    if (label != null) {
      dialogChild = Semantics(
        scopesRoute: true,
        explicitChildNodes: true,
        namesRoute: true,
        label: label,
        child: dialogChild,
      );
    }

    return AdDialog(
      backgroundColor: backgroundColor,
      elevation: elevation,
      insetPadding: insetPadding,
      clipBehavior: clipBehavior,
      shape: shape,
      alignment: alignment,
      child: dialogChild,
    );
  }
}

class AdSimpleDialogOption extends StatelessWidget {
  const AdSimpleDialogOption({
    super.key,
    this.onPressed,
    this.padding,
    this.child,
  });

  final VoidCallback? onPressed;
  final Widget? child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: padding ??
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        child: child,
      ),
    );
  }
}

class AdSimpleDialog extends StatelessWidget {
  const AdSimpleDialog({
    super.key,
    this.title,
    this.titlePadding = const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
    this.titleTextStyle,
    this.children,
    this.contentPadding = const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 16.0),
    this.backgroundColor,
    this.elevation,
    this.semanticLabel,
    this.insetPadding = _defaultInsetPadding,
    this.clipBehavior = Clip.none,
    this.shape,
    this.alignment,
  })  : assert(titlePadding != null),
        assert(contentPadding != null);

  final Widget? title;
  final EdgeInsetsGeometry titlePadding;
  final TextStyle? titleTextStyle;
  final List<Widget>? children;
  final EdgeInsetsGeometry contentPadding;
  final Color? backgroundColor;
  final double? elevation;
  final String? semanticLabel;
  final EdgeInsets insetPadding;
  final Clip clipBehavior;
  final ShapeBorder? shape;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    final ThemeData theme = Theme.of(context);

    String? label = semanticLabel;
    switch (theme.platform) {
      case TargetPlatform.macOS:
      case TargetPlatform.iOS:
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        label ??= MaterialLocalizations.of(context).dialogLabel;
    }

    final double paddingScaleFactor =
        _paddingScaleFactor(MediaQuery.of(context).textScaleFactor);
    final TextDirection? textDirection = Directionality.maybeOf(context);

    Widget? titleWidget;
    if (title != null) {
      final EdgeInsets effectiveTitlePadding =
          titlePadding.resolve(textDirection);
      titleWidget = Padding(
        padding: EdgeInsets.only(
          left: effectiveTitlePadding.left * paddingScaleFactor,
          right: effectiveTitlePadding.right * paddingScaleFactor,
          top: effectiveTitlePadding.top * paddingScaleFactor,
          bottom: children == null
              ? effectiveTitlePadding.bottom * paddingScaleFactor
              : effectiveTitlePadding.bottom,
        ),
        child: DefaultTextStyle(
          style: titleTextStyle ??
              DialogTheme.of(context).titleTextStyle ??
              theme.textTheme.headline6!,
          child: Semantics(
            // For iOS platform, the focus always lands on the title.
            // Set nameRoute to false to avoid title being announce twice.
            namesRoute: label == null && theme.platform != TargetPlatform.iOS,
            container: true,
            child: title,
          ),
        ),
      );
    }

    Widget? contentWidget;
    if (children != null) {
      final EdgeInsets effectiveContentPadding =
          contentPadding.resolve(textDirection);
      contentWidget = Flexible(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: effectiveContentPadding.left * paddingScaleFactor,
            right: effectiveContentPadding.right * paddingScaleFactor,
            top: title == null
                ? effectiveContentPadding.top * paddingScaleFactor
                : effectiveContentPadding.top,
            bottom: effectiveContentPadding.bottom * paddingScaleFactor,
          ),
          child: ListBody(children: children!),
        ),
      );
    }

    Widget dialogChild = IntrinsicWidth(
      stepWidth: 56.0,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 280.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (title != null) titleWidget!,
            if (children != null) contentWidget!,
          ],
        ),
      ),
    );

    if (label != null) {
      dialogChild = Semantics(
        scopesRoute: true,
        explicitChildNodes: true,
        namesRoute: true,
        label: label,
        child: dialogChild,
      );
    }

    return AdDialog(
      backgroundColor: backgroundColor,
      elevation: elevation,
      insetPadding: insetPadding,
      clipBehavior: clipBehavior,
      shape: shape,
      alignment: alignment,
      child: dialogChild,
    );
  }
}

Widget _buildMaterialDialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return FadeTransition(
    opacity: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ),
    child: child,
  );
}

// Future<T?> showDialog<T>({
//   required BuildContext context,
//   required WidgetBuilder builder,
//   bool barrierDismissible = true,
//   Color? barrierColor = Colors.black54,
//   String? barrierLabel,
//   bool useSafeArea = true,
//   bool useRootNavigator = true,
//   RouteSettings? routeSettings,
//   Offset? anchorPoint,
// }) {
//   assert(builder != null);
//   assert(barrierDismissible != null);
//   assert(useSafeArea != null);
//   assert(useRootNavigator != null);
//   assert(_debugIsActive(context));
//   assert(debugCheckHasMaterialLocalizations(context));

//   final CapturedThemes themes = InheritedTheme.capture(
//     from: context,
//     to: Navigator.of(
//       context,
//       rootNavigator: useRootNavigator,
//     ).context,
//   );

//   return Navigator.of(context, rootNavigator: useRootNavigator)
//       .push<T>(DialogRoute<T>(
//     context: context,
//     builder: builder,
//     barrierColor: barrierColor,
//     barrierDismissible: barrierDismissible,
//     barrierLabel: barrierLabel,
//     useSafeArea: useSafeArea,
//     settings: routeSettings,
//     themes: themes,
//     anchorPoint: anchorPoint,
//   ));
// }

bool _debugIsActive(BuildContext context) {
  if (context is Element && !context.debugIsActive) {
    throw FlutterError.fromParts(<DiagnosticsNode>[
      ErrorSummary('This BuilldContext is no longer valid.'),
      ErrorDescription(
        'This can commonly occur when the showDialog function is called after awaiting a Future. '
        'In this situation the BuildContext might refer to a widget that has already been disposed during the await. '
        'Consider using a parent context instead.',
      ),
    ]);
  }
  return true;
}

class DialogRoute<T> extends RawDialogRoute<T> {
  DialogRoute({
    required BuildContext context,
    required WidgetBuilder builder,
    CapturedThemes? themes,
    super.barrierColor = Colors.black54,
    super.barrierDismissible,
    String? barrierLabel,
    bool useSafeArea = true,
    super.settings,
    super.anchorPoint,
  })  : assert(barrierDismissible != null),
        super(
          pageBuilder: (BuildContext buildContext, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            final Widget pageChild = Builder(builder: builder);
            Widget dialog = themes?.wrap(pageChild) ?? pageChild;
            if (useSafeArea) {
              dialog = SafeArea(child: dialog);
            }
            return dialog;
          },
          barrierLabel: barrierLabel ??
              MaterialLocalizations.of(context).modalBarrierDismissLabel,
          transitionDuration: const Duration(milliseconds: 150),
          transitionBuilder: _buildMaterialDialogTransitions,
        );
}

double _paddingScaleFactor(double textScaleFactor) {
  final double clampedTextScaleFactor = clampDouble(textScaleFactor, 1.0, 2.0);

  return lerpDouble(1.0, 1.0 / 3.0, clampedTextScaleFactor - 1.0)!;
}

class _DialogDefaultsM2 extends DialogTheme {
  _DialogDefaultsM2(this.context)
      : _textTheme = Theme.of(context).textTheme,
        _iconTheme = Theme.of(context).iconTheme,
        super(
          alignment: Alignment.center,
          elevation: 24.0,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
        );

  final BuildContext context;
  final TextTheme _textTheme;
  final IconThemeData _iconTheme;

  @override
  Color? get iconColor => _iconTheme.color;

  @override
  Color? get backgroundColor => Theme.of(context).dialogBackgroundColor;

  @override
  TextStyle? get titleTextStyle => _textTheme.headline6;

  @override
  TextStyle? get contentTextStyle => _textTheme.subtitle1;

  @override
  EdgeInsetsGeometry? get actionsPadding => EdgeInsets.zero;
}

class _DialogDefaultsM3 extends DialogTheme {
  _DialogDefaultsM3(this.context)
      : super(
          alignment: Alignment.center,
          elevation: 6.0,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28.0),
                  topRight: Radius.circular(28.0),
                  bottomLeft: Radius.circular(28.0),
                  bottomRight: Radius.circular(28.0))),
        );

  final BuildContext context;
  late final ColorScheme _colors = Theme.of(context).colorScheme;
  late final TextTheme _textTheme = Theme.of(context).textTheme;

  @override
  Color? get iconColor => _colors.secondary;

  // TODO(darrenaustin): overlay should be handled by Material widget: https://github.com/flutter/flutter/issues/9160
  @override
  Color? get backgroundColor =>
      ElevationOverlay.colorWithOverlay(_colors.surface, _colors.primary, 6.0);

  @override
  TextStyle? get titleTextStyle => _textTheme.headlineSmall;

  @override
  TextStyle? get contentTextStyle => _textTheme.bodyMedium;

  @override
  EdgeInsetsGeometry? get actionsPadding =>
      const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0);
}

// END GENERATED TOKEN PROPERTIES - Dialog