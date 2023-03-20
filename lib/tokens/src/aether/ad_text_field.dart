import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle, lerpDouble;
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../dart/dart_color.dart';
import '../../dart/dart_font.dart';

// import 'package:latihan_text_field/tokens/dart/dart_color.dart';
// import 'package:latihan_text_field/tokens/dart/dart_font.dart';

const Duration _kTransitionDuration = Duration(milliseconds: 200);
const Curve _kTransitionCurve = Curves.fastOutSlowIn;
// const double _kFinalLabelScale = 0.75;
const double _kFinalLabelScale = 0.8;

typedef InputCounterWidgetBuilder = Widget? Function(
  BuildContext context, {
  required int currentLength,
  required int? maxLength,
  required bool isFocused,
});

class _TextFieldSelectionGestureDetectorBuilder
    extends TextSelectionGestureDetectorBuilder {
  _TextFieldSelectionGestureDetectorBuilder({
    required _AdTextFieldState state,
  })  : _state = state,
        super(delegate: state);

  final _AdTextFieldState _state;

  @override
  void onForcePressStart(ForcePressDetails details) {
    super.onForcePressStart(details);
    if (delegate.selectionEnabled && shouldShowSelectionToolbar) {
      editableText.showToolbar();
    }
  }

  @override
  void onForcePressEnd(ForcePressDetails details) {
    // Not required.
  }

  @override
  void onSingleTapUp(TapUpDetails details) {
    super.onSingleTapUp(details);
    _state._requestKeyboard();
    _state.widget.onTap?.call();
  }

  @override
  void onSingleLongTapStart(LongPressStartDetails details) {
    super.onSingleLongTapStart(details);
    if (delegate.selectionEnabled) {
      switch (Theme.of(_state.context).platform) {
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
          break;
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
        case TargetPlatform.linux:
        case TargetPlatform.windows:
          Feedback.forLongPress(_state.context);
          break;
      }
    }
  }
}

class AdTextField extends StatefulWidget {
  const AdTextField({
    super.key,
    this.controller,
    this.focusNode,
    // this.decoration = const adInDecor.InputDecoration(),

    this.decoration = const InputDecoration(),
    TextInputType? keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.readOnly = false,
    @Deprecated(
      'Use `contextMenuBuilder` instead. '
      'This feature was deprecated after v3.3.0-0.5.pre.',
    )
        this.toolbarOptions,
    this.showCursor,
    this.autofocus = false,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = true,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.enabled,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.dragStartBehavior = DragStartBehavior.start,
    bool? enableInteractiveSelection,
    this.selectionControls,
    this.onTap,
    this.onTapOutside,
    this.mouseCursor,
    this.buildCounter,
    this.scrollController,
    this.scrollPhysics,
    this.autofillHints = const <String>[],
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.scribbleEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.contextMenuBuilder = _defaultContextMenuBuilder,
    this.spellCheckConfiguration,
    this.magnifierConfiguration,
  })  :
        // assert(textAlign != null),
        // assert(readOnly != null),
        // assert(autofocus != null),
        // assert(obscuringCharacter != null && obscuringCharacter.length == 1),
        assert(obscuringCharacter.length == 1),
        // assert(obscureText != null),
        // assert(autocorrect != null),
        smartDashesType = smartDashesType ??
            (obscureText ? SmartDashesType.disabled : SmartDashesType.enabled),
        smartQuotesType = smartQuotesType ??
            (obscureText ? SmartQuotesType.disabled : SmartQuotesType.enabled),
        // assert(enableSuggestions != null),
        // assert(scrollPadding != null),
        // assert(dragStartBehavior != null),
        // assert(selectionHeightStyle != null),
        // assert(selectionWidthStyle != null),
        assert(maxLines == null || maxLines > 0),
        assert(minLines == null || minLines > 0),
        assert(
          (maxLines == null) || (minLines == null) || (maxLines >= minLines),
          "minLines can't be greater than maxLines",
        ),
        // assert(expands != null),
        assert(
          !expands || (maxLines == null && minLines == null),
          'minLines and maxLines must be null when expands is true.',
        ),
        assert(!obscureText || maxLines == 1,
            'Obscured fields cannot be multiline.'),
        assert(maxLength == null ||
            maxLength == TextField.noMaxLength ||
            maxLength > 0),
        // Assert the following instead of setting it directly to avoid surprising the user by silently changing the value they set.
        assert(
          !identical(textInputAction, TextInputAction.newline) ||
              maxLines == 1 ||
              !identical(keyboardType, TextInputType.text),
          'Use keyboardType TextInputType.multiline when using TextInputAction.newline on a multiline TextField.',
        ),
        // assert(clipBehavior != null),
        // assert(enableIMEPersonalizedLearning != null),
        keyboardType = keyboardType ??
            (maxLines == 1 ? TextInputType.text : TextInputType.multiline),
        enableInteractiveSelection =
            enableInteractiveSelection ?? (!readOnly || !obscureText);

  final TextMagnifierConfiguration? magnifierConfiguration;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  // final adInDecor.InputDecoration? decoration;
  final InputDecoration? decoration;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final bool autofocus;
  final String obscuringCharacter;
  final bool obscureText;
  final bool autocorrect;
  final SmartDashesType smartDashesType;
  final SmartQuotesType smartQuotesType;
  final bool enableSuggestions;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final bool readOnly;
  final ToolbarOptions? toolbarOptions;
  final bool? showCursor;
  static const int noMaxLength = -1;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final AppPrivateCommandCallback? onAppPrivateCommand;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final ui.BoxHeightStyle selectionHeightStyle;
  final ui.BoxWidthStyle selectionWidthStyle;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  final DragStartBehavior dragStartBehavior;
  bool get selectionEnabled => enableInteractiveSelection;
  final GestureTapCallback? onTap;
  final TapRegionCallback? onTapOutside;
  final MouseCursor? mouseCursor;
  final InputCounterWidgetBuilder? buildCounter;
  final ScrollPhysics? scrollPhysics;
  final ScrollController? scrollController;
  final Iterable<String>? autofillHints;
  final Clip clipBehavior;
  final String? restorationId;
  final bool scribbleEnabled;
  final bool enableIMEPersonalizedLearning;
  final EditableTextContextMenuBuilder? contextMenuBuilder;

  static Widget _defaultContextMenuBuilder(
      BuildContext context, EditableTextState editableTextState) {
    return AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState,
    );
  }

  final SpellCheckConfiguration? spellCheckConfiguration;
  static const TextStyle materialMisspelledTextStyle = TextStyle(
    decoration: TextDecoration.underline,
    decorationColor: Colors.red,
    decorationStyle: TextDecorationStyle.wavy,
  );

  @override
  State<AdTextField> createState() => _AdTextFieldState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextEditingController>(
        'controller', controller,
        defaultValue: null));
    properties.add(DiagnosticsProperty<FocusNode>('focusNode', focusNode,
        defaultValue: null));
    properties
        .add(DiagnosticsProperty<bool>('enabled', enabled, defaultValue: null));
    // properties.add(DiagnosticsProperty<adInDecor.InputDecoration>(
    //     'decoration', decoration,
    //     defaultValue: const adInDecor.InputDecoration()));
    properties.add(DiagnosticsProperty<InputDecoration>(
        'decoration', decoration,
        defaultValue: const InputDecoration()));
    properties.add(DiagnosticsProperty<TextInputType>(
        'keyboardType', keyboardType,
        defaultValue: TextInputType.text));
    properties.add(
        DiagnosticsProperty<TextStyle>('style', style, defaultValue: null));
    properties.add(
        DiagnosticsProperty<bool>('autofocus', autofocus, defaultValue: false));
    properties.add(DiagnosticsProperty<String>(
        'obscuringCharacter', obscuringCharacter,
        defaultValue: '•'));
    properties.add(DiagnosticsProperty<bool>('obscureText', obscureText,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('autocorrect', autocorrect,
        defaultValue: true));
    properties.add(EnumProperty<SmartDashesType>(
        'smartDashesType', smartDashesType,
        defaultValue:
            obscureText ? SmartDashesType.disabled : SmartDashesType.enabled));
    properties.add(EnumProperty<SmartQuotesType>(
        'smartQuotesType', smartQuotesType,
        defaultValue:
            obscureText ? SmartQuotesType.disabled : SmartQuotesType.enabled));
    properties.add(DiagnosticsProperty<bool>(
        'enableSuggestions', enableSuggestions,
        defaultValue: true));
    properties.add(IntProperty('maxLines', maxLines, defaultValue: 1));
    properties.add(IntProperty('minLines', minLines, defaultValue: null));
    properties.add(
        DiagnosticsProperty<bool>('expands', expands, defaultValue: false));
    properties.add(IntProperty('maxLength', maxLength, defaultValue: null));
    properties.add(EnumProperty<MaxLengthEnforcement>(
        'maxLengthEnforcement', maxLengthEnforcement,
        defaultValue: null));
    properties.add(EnumProperty<TextInputAction>(
        'textInputAction', textInputAction,
        defaultValue: null));
    properties.add(EnumProperty<TextCapitalization>(
        'textCapitalization', textCapitalization,
        defaultValue: TextCapitalization.none));
    properties.add(EnumProperty<TextAlign>('textAlign', textAlign,
        defaultValue: TextAlign.start));
    properties.add(DiagnosticsProperty<TextAlignVertical>(
        'textAlignVertical', textAlignVertical,
        defaultValue: null));
    properties.add(EnumProperty<TextDirection>('textDirection', textDirection,
        defaultValue: null));
    properties
        .add(DoubleProperty('cursorWidth', cursorWidth, defaultValue: 2.0));
    properties
        .add(DoubleProperty('cursorHeight', cursorHeight, defaultValue: null));
    properties.add(DiagnosticsProperty<Radius>('cursorRadius', cursorRadius,
        defaultValue: null));
    properties
        .add(ColorProperty('cursorColor', cursorColor, defaultValue: null));
    properties.add(DiagnosticsProperty<Brightness>(
        'keyboardAppearance', keyboardAppearance,
        defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>(
        'scrollPadding', scrollPadding,
        defaultValue: const EdgeInsets.all(20.0)));
    properties.add(FlagProperty('selectionEnabled',
        value: selectionEnabled,
        defaultValue: true,
        ifFalse: 'selection disabled'));
    properties.add(DiagnosticsProperty<TextSelectionControls>(
        'selectionControls', selectionControls,
        defaultValue: null));
    properties.add(DiagnosticsProperty<ScrollController>(
        'scrollController', scrollController,
        defaultValue: null));
    properties.add(DiagnosticsProperty<ScrollPhysics>(
        'scrollPhysics', scrollPhysics,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Clip>('clipBehavior', clipBehavior,
        defaultValue: Clip.hardEdge));
    properties.add(DiagnosticsProperty<bool>('scribbleEnabled', scribbleEnabled,
        defaultValue: true));
    properties.add(DiagnosticsProperty<bool>(
        'enableIMEPersonalizedLearning', enableIMEPersonalizedLearning,
        defaultValue: true));
    properties.add(DiagnosticsProperty<SpellCheckConfiguration>(
        'spellCheckConfiguration', spellCheckConfiguration,
        defaultValue: null));
  }
}

class _AdTextFieldState extends State<AdTextField>
    with RestorationMixin
    implements TextSelectionGestureDetectorBuilderDelegate, AutofillClient {
  RestorableTextEditingController? _controller;
  TextEditingController get _effectiveController =>
      widget.controller ?? _controller!.value;

  FocusNode? _focusNode;
  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= FocusNode());

  MaxLengthEnforcement get _effectiveMaxLengthEnforcement =>
      widget.maxLengthEnforcement ??
      LengthLimitingTextInputFormatter.getDefaultMaxLengthEnforcement(
          Theme.of(context).platform);

  bool _isHovering = false;

  bool get needsCounter =>
      widget.maxLength != null &&
      widget.decoration != null &&
      widget.decoration!.counterText == null;

  bool _showSelectionHandles = false;

  late _TextFieldSelectionGestureDetectorBuilder
      _selectionGestureDetectorBuilder;

  // API for TextSelectionGestureDetectorBuilderDelegate.
  @override
  late bool forcePressEnabled;

  @override
  final GlobalKey<EditableTextState> editableTextKey =
      GlobalKey<EditableTextState>();

  @override
  bool get selectionEnabled => widget.selectionEnabled;
  // End of API for TextSelectionGestureDetectorBuilderDelegate.

  bool get _isEnabled => widget.enabled ?? widget.decoration?.enabled ?? true;

  int get _currentLength => _effectiveController.value.text.characters.length;

  bool get _hasIntrinsicError =>
      widget.maxLength != null &&
      widget.maxLength! > 0 &&
      _effectiveController.value.text.characters.length > widget.maxLength!;

  bool get _hasError =>
      widget.decoration?.errorText != null || _hasIntrinsicError;

  InputDecoration _getEffectiveDecoration() {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    final ThemeData themeData = Theme.of(context);
    final InputDecoration effectiveDecoration =
        (widget.decoration ?? const InputDecoration())
            .applyDefaults(themeData.inputDecorationTheme)
            .copyWith(
              enabled: _isEnabled,
              hintMaxLines: widget.decoration?.hintMaxLines ?? widget.maxLines,
            );

    if (effectiveDecoration.counter != null ||
        effectiveDecoration.counterText != null) {
      return effectiveDecoration;
    }

    Widget? counter;
    final int currentLength = _currentLength;
    if (effectiveDecoration.counter == null &&
        effectiveDecoration.counterText == null &&
        widget.buildCounter != null) {
      final bool isFocused = _effectiveFocusNode.hasFocus;
      final Widget? builtCounter = widget.buildCounter!(
        context,
        currentLength: currentLength,
        maxLength: widget.maxLength,
        isFocused: isFocused,
      );
      // If buildCounter returns null, don't add a counter widget to the field.
      if (builtCounter != null) {
        counter = Semantics(
          container: true,
          liveRegion: isFocused,
          child: builtCounter,
        );
      }
      return effectiveDecoration.copyWith(counter: counter);
    }

    if (widget.maxLength == null) {
      return effectiveDecoration;
    }

    String counterText = '$currentLength';
    String semanticCounterText = '';

    if (widget.maxLength! > 0) {
      // Show the maxLength in the counter
      counterText += '/${widget.maxLength}';
      final int remaining = (widget.maxLength! - currentLength)
          .clamp(0, widget.maxLength!); // ignore_clamp_double_lint
      semanticCounterText =
          localizations.remainingTextFieldCharacterCount(remaining);
    }

    if (_hasIntrinsicError) {
      return effectiveDecoration.copyWith(
        errorText: effectiveDecoration.errorText ?? '',
        counterStyle: effectiveDecoration.errorStyle ??
            (themeData.useMaterial3
                ? _m3CounterErrorStyle(context)
                : _m2CounterErrorStyle(context)),
        counterText: counterText,
        semanticCounterText: semanticCounterText,
      );
    }

    return effectiveDecoration.copyWith(
      counterText: counterText,
      semanticCounterText: semanticCounterText,
    );
  }

  @override
  void initState() {
    super.initState();
    _selectionGestureDetectorBuilder =
        _TextFieldSelectionGestureDetectorBuilder(state: this);
    if (widget.controller == null) {
      _createLocalController();
    }
    _effectiveFocusNode.canRequestFocus = _isEnabled;
    _effectiveFocusNode.addListener(_handleFocusChanged);
  }

  bool get _canRequestFocus {
    final NavigationMode mode = MediaQuery.maybeOf(context)?.navigationMode ??
        NavigationMode.traditional;
    switch (mode) {
      case NavigationMode.traditional:
        return _isEnabled;
      case NavigationMode.directional:
        return true;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _effectiveFocusNode.canRequestFocus = _canRequestFocus;
  }

  @override
  void didUpdateWidget(AdTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller == null && oldWidget.controller != null) {
      _createLocalController(oldWidget.controller!.value);
    } else if (widget.controller != null && oldWidget.controller == null) {
      unregisterFromRestoration(_controller!);
      _controller!.dispose();
      _controller = null;
    }

    if (widget.focusNode != oldWidget.focusNode) {
      (oldWidget.focusNode ?? _focusNode)?.removeListener(_handleFocusChanged);
      (widget.focusNode ?? _focusNode)?.addListener(_handleFocusChanged);
    }

    _effectiveFocusNode.canRequestFocus = _canRequestFocus;

    if (_effectiveFocusNode.hasFocus &&
        widget.readOnly != oldWidget.readOnly &&
        _isEnabled) {
      if (_effectiveController.selection.isCollapsed) {
        _showSelectionHandles = !widget.readOnly;
      }
    }
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    if (_controller != null) {
      _registerController();
    }
  }

  void _registerController() {
    assert(_controller != null);
    registerForRestoration(_controller!, 'controller');
  }

  void _createLocalController([TextEditingValue? value]) {
    assert(_controller == null);
    _controller = value == null
        ? RestorableTextEditingController()
        : RestorableTextEditingController.fromValue(value);
    if (!restorePending) {
      _registerController();
    }
  }

  @override
  String? get restorationId => widget.restorationId;

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_handleFocusChanged);
    _focusNode?.dispose();
    _controller?.dispose();
    super.dispose();
  }

  EditableTextState? get _editableText => editableTextKey.currentState;

  void _requestKeyboard() {
    _editableText?.requestKeyboard();
  }

  bool _shouldShowSelectionHandles(SelectionChangedCause? cause) {
    // When the text field is activated by something that doesn't trigger the
    // selection overlay, we shouldn't show the handles either.
    if (!_selectionGestureDetectorBuilder.shouldShowSelectionToolbar) {
      return false;
    }

    if (cause == SelectionChangedCause.keyboard) {
      return false;
    }

    if (widget.readOnly && _effectiveController.selection.isCollapsed) {
      return false;
    }

    if (!_isEnabled) {
      return false;
    }

    if (cause == SelectionChangedCause.longPress ||
        cause == SelectionChangedCause.scribble) {
      return true;
    }

    if (_effectiveController.text.isNotEmpty) {
      return true;
    }

    return false;
  }

  void _handleFocusChanged() {
    setState(() {
      // Rebuild the widget on focus change to show/hide the text selection
      // highlight.
    });
  }

  void _handleSelectionChanged(
      TextSelection selection, SelectionChangedCause? cause) {
    final bool willShowSelectionHandles = _shouldShowSelectionHandles(cause);
    if (willShowSelectionHandles != _showSelectionHandles) {
      setState(() {
        _showSelectionHandles = willShowSelectionHandles;
      });
    }

    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
      case TargetPlatform.fuchsia:
      case TargetPlatform.android:
        if (cause == SelectionChangedCause.longPress ||
            cause == SelectionChangedCause.drag) {
          _editableText?.bringIntoView(selection.extent);
        }
        break;
    }

    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
      case TargetPlatform.android:
        break;
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        if (cause == SelectionChangedCause.drag) {
          _editableText?.hideToolbar();
        }
        break;
    }
  }

  /// Toggle the toolbar when a selection handle is tapped.
  void _handleSelectionHandleTapped() {
    if (_effectiveController.selection.isCollapsed) {
      _editableText!.toggleToolbar();
    }
  }

  void _handleHover(bool hovering) {
    if (hovering != _isHovering) {
      setState(() {
        _isHovering = hovering;
      });
    }
  }

  // AutofillClient implementation start.
  @override
  String get autofillId => _editableText!.autofillId;

  @override
  void autofill(TextEditingValue newEditingValue) =>
      _editableText!.autofill(newEditingValue);

  @override
  TextInputConfiguration get textInputConfiguration {
    final List<String>? autofillHints =
        widget.autofillHints?.toList(growable: false);
    final AutofillConfiguration autofillConfiguration = autofillHints != null
        ? AutofillConfiguration(
            uniqueIdentifier: autofillId,
            autofillHints: autofillHints,
            currentEditingValue: _effectiveController.value,
            hintText: (widget.decoration ?? const InputDecoration()).hintText,
          )
        : AutofillConfiguration.disabled;

    return _editableText!.textInputConfiguration
        .copyWith(autofillConfiguration: autofillConfiguration);
  }
  // AutofillClient implementation end.

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    assert(debugCheckHasMaterialLocalizations(context));
    assert(debugCheckHasDirectionality(context));
    assert(
      !(widget.style != null &&
          widget.style!.inherit == false &&
          (widget.style!.fontSize == null ||
              widget.style!.textBaseline == null)),
      'inherit false style must supply fontSize and textBaseline',
    );

    final ThemeData theme = Theme.of(context);
    final DefaultSelectionStyle selectionStyle =
        DefaultSelectionStyle.of(context);
    const TextStyle adTextFieldStyle = TextStyle(
      color: adrColor.textNormal,
      fontSize: adrFont.body2FontSize,
    );
    // final TextStyle style = (theme.useMaterial3
    //         ? _m3InputStyle(context)
    //         : theme.textTheme.titleMedium!)
    //     .merge(widget.style);
    final TextStyle style =
        (theme.useMaterial3 ? _m3InputStyle(context) : adTextFieldStyle)
            .merge(widget.style);
    final Brightness keyboardAppearance =
        widget.keyboardAppearance ?? theme.brightness;
    final TextEditingController controller = _effectiveController;
    final FocusNode focusNode = _effectiveFocusNode;
    final List<TextInputFormatter> formatters = <TextInputFormatter>[
      ...?widget.inputFormatters,
      if (widget.maxLength != null)
        LengthLimitingTextInputFormatter(
          widget.maxLength,
          maxLengthEnforcement: _effectiveMaxLengthEnforcement,
        ),
    ];

    final SpellCheckConfiguration spellCheckConfiguration =
        widget.spellCheckConfiguration != null &&
                widget.spellCheckConfiguration !=
                    const SpellCheckConfiguration.disabled()
            ? widget.spellCheckConfiguration!.copyWith(
                misspelledTextStyle:
                    widget.spellCheckConfiguration!.misspelledTextStyle ??
                        TextField.materialMisspelledTextStyle)
            : const SpellCheckConfiguration.disabled();

    TextSelectionControls? textSelectionControls = widget.selectionControls;
    final bool paintCursorAboveText;
    final bool cursorOpacityAnimates;
    Offset? cursorOffset;
    final Color cursorColor;
    final Color selectionColor;
    Color? autocorrectionTextRectColor;
    Radius? cursorRadius = widget.cursorRadius;
    VoidCallback? handleDidGainAccessibilityFocus;

    switch (theme.platform) {
      case TargetPlatform.iOS:
        final CupertinoThemeData cupertinoTheme = CupertinoTheme.of(context);
        forcePressEnabled = true;
        textSelectionControls ??= cupertinoTextSelectionHandleControls;
        paintCursorAboveText = true;
        cursorOpacityAnimates = true;
        cursorColor = widget.cursorColor ??
            selectionStyle.cursorColor ??
            cupertinoTheme.primaryColor;
        selectionColor = selectionStyle.selectionColor ??
            cupertinoTheme.primaryColor.withOpacity(0.40);
        cursorRadius ??= const Radius.circular(2.0);
        cursorOffset = Offset(
            iOSHorizontalOffset / MediaQuery.of(context).devicePixelRatio, 0);
        autocorrectionTextRectColor = selectionColor;
        break;

      case TargetPlatform.macOS:
        final CupertinoThemeData cupertinoTheme = CupertinoTheme.of(context);
        forcePressEnabled = false;
        textSelectionControls ??= cupertinoDesktopTextSelectionHandleControls;
        paintCursorAboveText = true;
        cursorOpacityAnimates = false;
        cursorColor = widget.cursorColor ??
            selectionStyle.cursorColor ??
            cupertinoTheme.primaryColor;
        selectionColor = selectionStyle.selectionColor ??
            cupertinoTheme.primaryColor.withOpacity(0.40);
        cursorRadius ??= const Radius.circular(2.0);
        cursorOffset = Offset(
            iOSHorizontalOffset / MediaQuery.of(context).devicePixelRatio, 0);
        handleDidGainAccessibilityFocus = () {
          // Automatically activate the TextField when it receives accessibility focus.
          if (!_effectiveFocusNode.hasFocus &&
              _effectiveFocusNode.canRequestFocus) {
            _effectiveFocusNode.requestFocus();
          }
        };
        break;

      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        forcePressEnabled = false;
        textSelectionControls ??= materialTextSelectionHandleControls;
        paintCursorAboveText = false;
        cursorOpacityAnimates = false;
        cursorColor = widget.cursorColor ??
            selectionStyle.cursorColor ??
            theme.colorScheme.primary;
        selectionColor = selectionStyle.selectionColor ??
            theme.colorScheme.primary.withOpacity(0.40);
        break;

      case TargetPlatform.linux:
        forcePressEnabled = false;
        textSelectionControls ??= desktopTextSelectionHandleControls;
        paintCursorAboveText = false;
        cursorOpacityAnimates = false;
        cursorColor = widget.cursorColor ??
            selectionStyle.cursorColor ??
            theme.colorScheme.primary;
        selectionColor = selectionStyle.selectionColor ??
            theme.colorScheme.primary.withOpacity(0.40);
        break;

      case TargetPlatform.windows:
        forcePressEnabled = false;
        textSelectionControls ??= desktopTextSelectionHandleControls;
        paintCursorAboveText = false;
        cursorOpacityAnimates = false;
        cursorColor = widget.cursorColor ??
            selectionStyle.cursorColor ??
            theme.colorScheme.primary;
        selectionColor = selectionStyle.selectionColor ??
            theme.colorScheme.primary.withOpacity(0.40);
        handleDidGainAccessibilityFocus = () {
          // Automatically activate the TextField when it receives accessibility focus.
          if (!_effectiveFocusNode.hasFocus &&
              _effectiveFocusNode.canRequestFocus) {
            _effectiveFocusNode.requestFocus();
          }
        };
        break;
    }

    bool adaPrefix = widget.decoration?.prefixIcon != null ||
        widget.decoration?.prefix != null ||
        widget.decoration?.prefixText != null;

    bool dariKanan = widget.textAlign == TextAlign.end;

    Widget child = RepaintBoundary(
      child: UnmanagedRestorationScope(
        bucket: bucket,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: adaPrefix ? (dariKanan ? 16 : 6) : 16),
          child: EditableText(
            key: editableTextKey,
            readOnly: widget.readOnly || !_isEnabled,
            toolbarOptions: widget.toolbarOptions,
            showCursor: widget.showCursor,
            showSelectionHandles: _showSelectionHandles,
            controller: controller,
            focusNode: focusNode,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            textCapitalization: widget.textCapitalization,
            style: style,
            strutStyle: widget.strutStyle,
            textAlign: widget.textAlign,
            textDirection: widget.textDirection,
            autofocus: widget.autofocus,
            obscuringCharacter: widget.obscuringCharacter,
            obscureText: widget.obscureText,
            autocorrect: widget.autocorrect,
            smartDashesType: widget.smartDashesType,
            smartQuotesType: widget.smartQuotesType,
            enableSuggestions: widget.enableSuggestions,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            expands: widget.expands,
            // Only show the selection highlight when the text field is focused.
            selectionColor: focusNode.hasFocus ? selectionColor : null,
            selectionControls:
                widget.selectionEnabled ? textSelectionControls : null,
            onChanged: widget.onChanged,
            onSelectionChanged: _handleSelectionChanged,
            onEditingComplete: widget.onEditingComplete,
            onSubmitted: widget.onSubmitted,
            onAppPrivateCommand: widget.onAppPrivateCommand,
            onSelectionHandleTapped: _handleSelectionHandleTapped,
            onTapOutside: widget.onTapOutside,
            inputFormatters: formatters,
            rendererIgnoresPointer: true,
            mouseCursor: MouseCursor.defer, // TextField will handle the cursor
            cursorWidth: widget.cursorWidth,
            cursorHeight: widget.cursorHeight,
            cursorRadius: cursorRadius,
            cursorColor: cursorColor,
            selectionHeightStyle: widget.selectionHeightStyle,
            selectionWidthStyle: widget.selectionWidthStyle,
            cursorOpacityAnimates: cursorOpacityAnimates,
            cursorOffset: cursorOffset,
            paintCursorAboveText: paintCursorAboveText,
            backgroundCursorColor: CupertinoColors.inactiveGray,
            scrollPadding: widget.scrollPadding,
            keyboardAppearance: keyboardAppearance,
            enableInteractiveSelection: widget.enableInteractiveSelection,
            dragStartBehavior: widget.dragStartBehavior,
            scrollController: widget.scrollController,
            scrollPhysics: widget.scrollPhysics,
            autofillClient: this,
            autocorrectionTextRectColor: autocorrectionTextRectColor,
            clipBehavior: widget.clipBehavior,
            restorationId: 'editable',
            scribbleEnabled: widget.scribbleEnabled,
            enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
            contextMenuBuilder: widget.contextMenuBuilder,
            spellCheckConfiguration: spellCheckConfiguration,
            magnifierConfiguration: widget.magnifierConfiguration ??
                TextMagnifier.adaptiveMagnifierConfiguration,
          ),
        ),
      ),
    );

    if (widget.decoration != null) {
      child = AnimatedBuilder(
        animation: Listenable.merge(<Listenable>[focusNode, controller]),
        builder: (BuildContext context, Widget? child) {
          // return InputDecorator(
          return NoFloating(
            decoration: _getEffectiveDecoration(),
            baseStyle: widget.style,
            textAlign: widget.textAlign,
            textAlignVertical: widget.textAlignVertical,
            isHovering: _isHovering,
            isFocused: focusNode.hasFocus,
            isEmpty: controller.value.text.isEmpty,
            expands: widget.expands,
            child: child,
          );
        },
        child: child,
      );
    }

    final MouseCursor effectiveMouseCursor =
        MaterialStateProperty.resolveAs<MouseCursor>(
      widget.mouseCursor ?? MaterialStateMouseCursor.textable,
      <MaterialState>{
        if (!_isEnabled) MaterialState.disabled,
        if (_isHovering) MaterialState.hovered,
        if (focusNode.hasFocus) MaterialState.focused,
        if (_hasError) MaterialState.error,
      },
    );

    final int? semanticsMaxValueLength;
    if (_effectiveMaxLengthEnforcement != MaxLengthEnforcement.none &&
        widget.maxLength != null &&
        widget.maxLength! > 0) {
      semanticsMaxValueLength = widget.maxLength;
    } else {
      semanticsMaxValueLength = null;
    }

    return MouseRegion(
      cursor: effectiveMouseCursor,
      onEnter: (PointerEnterEvent event) => _handleHover(true),
      onExit: (PointerExitEvent event) => _handleHover(false),
      child: TextFieldTapRegion(
        child: IgnorePointer(
          ignoring: !_isEnabled,
          child: AnimatedBuilder(
            animation: controller, // changes the _currentLength
            builder: (BuildContext context, Widget? child) {
              return Semantics(
                maxValueLength: semanticsMaxValueLength,
                currentValueLength: _currentLength,
                onTap: widget.readOnly
                    ? null
                    : () {
                        if (!_effectiveController.selection.isValid) {
                          _effectiveController.selection =
                              TextSelection.collapsed(
                                  offset: _effectiveController.text.length);
                        }
                        _requestKeyboard();
                      },
                onDidGainAccessibilityFocus: handleDidGainAccessibilityFocus,
                child: child,
              );
            },
            child: _selectionGestureDetectorBuilder.buildGestureDetector(
              behavior: HitTestBehavior.translucent,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

TextStyle _m2CounterErrorStyle(BuildContext context) => Theme.of(context)
    .textTheme
    .bodySmall!
    .copyWith(color: Theme.of(context).colorScheme.error);

// BEGIN GENERATED TOKEN PROPERTIES - TextField

// Do not edit by hand. The code between the "BEGIN GENERATED" and
// "END GENERATED" comments are generated from data in the Material
// Design token database by the script:
//   dev/tools/gen_defaults/bin/gen_defaults.dart.

// Token database version: v0_143

TextStyle _m3InputStyle(BuildContext context) =>
    Theme.of(context).textTheme.bodyLarge!;

TextStyle _m3CounterErrorStyle(BuildContext context) => Theme.of(context)
    .textTheme
    .bodySmall!
    .copyWith(color: Theme.of(context).colorScheme.error);

// END GENERATED TOKEN PROPERTIES - TextField

class NoFloating extends InputDecorator {
  // late bool prefixMuncul;
  NoFloating({
    decoration,
    baseStyle,
    textAlign,
    textAlignVertical,
    isFocused,
    isHovering,
    expands,
    isEmpty,
    child,
  }) : super(
          decoration: decoration,
          baseStyle: baseStyle,
          textAlign: textAlign,
          textAlignVertical: textAlignVertical,
          // isFocused: true,
          isFocused: isFocused,
          isHovering: isHovering,
          expands: expands,
          isEmpty: isEmpty,
          child: child,
        );

  final bool _labelShouldWithdraw = true;

  @override
  State<NoFloating> createState() => _NoFloatingState();
}

class _NoFloatingState extends State<NoFloating> with TickerProviderStateMixin {
  late AnimationController _floatingLabelController;
  late AnimationController _shakingLabelController;
  final _InputBorderGap _borderGap = _InputBorderGap();

  @override
  void initState() {
    super.initState();

    final bool labelIsInitiallyFloating =
        widget.decoration.floatingLabelBehavior ==
                FloatingLabelBehavior.always ||
            (widget.decoration.floatingLabelBehavior !=
                    FloatingLabelBehavior.never &&
                widget._labelShouldWithdraw);

    _floatingLabelController = AnimationController(
      duration: _kTransitionDuration,
      vsync: this,
      value: labelIsInitiallyFloating ? 1.0 : 0.0,
    );
    _floatingLabelController.addListener(_handleChange);

    _shakingLabelController = AnimationController(
      duration: _kTransitionDuration,
      vsync: this,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _effectiveDecoration = null;
  }

  @override
  void dispose() {
    _floatingLabelController.dispose();
    _shakingLabelController.dispose();
    super.dispose();
  }

  void _handleChange() {
    setState(() {
      // The _floatingLabelController's value has changed.
    });
  }

  InputDecoration? _effectiveDecoration;
  InputDecoration get decoration => _effectiveDecoration ??=
      widget.decoration.applyDefaults(Theme.of(context).inputDecorationTheme);

  TextAlign? get textAlign => widget.textAlign;
  bool get isFocused => widget.isFocused;
  bool get isHovering => widget.isHovering && decoration.enabled;
  bool get isEmpty => widget.isEmpty;
  bool get _floatingLabelEnabled {
    return decoration.floatingLabelBehavior != FloatingLabelBehavior.never;
  }

  @override
  void didUpdateWidget(NoFloating old) {
    super.didUpdateWidget(old);
    if (widget.decoration != old.decoration) {
      _effectiveDecoration = null;
    }

    final bool floatBehaviorChanged = widget.decoration.floatingLabelBehavior !=
        old.decoration.floatingLabelBehavior;

    if (widget._labelShouldWithdraw != old._labelShouldWithdraw ||
        floatBehaviorChanged) {
      if (_floatingLabelEnabled &&
          (widget._labelShouldWithdraw ||
              widget.decoration.floatingLabelBehavior ==
                  FloatingLabelBehavior.always)) {
        _floatingLabelController.forward();
      } else {
        _floatingLabelController.reverse();
      }
    }

    final String? errorText = decoration.errorText;
    final String? oldErrorText = old.decoration.errorText;

    if (_floatingLabelController.isCompleted &&
        errorText != null &&
        errorText != oldErrorText) {
      _shakingLabelController
        ..value = 0.0
        ..forward();
    }
  }

  Color _getDefaultM2BorderColor(ThemeData themeData) {
    if (!decoration.enabled && !isFocused) {
      return ((decoration.filled ?? false) &&
              !(decoration.border?.isOutline ?? false))
          ? Colors.transparent
          : themeData.disabledColor;
      // : adrColor.textLink;
    }
    if (decoration.errorText != null) {
      return themeData.colorScheme.error;
    }
    if (isFocused) {
      return themeData.colorScheme.primary;
    }
    if (decoration.filled!) {
      return themeData.hintColor;
    }
    final Color enabledColor =
        themeData.colorScheme.onSurface.withOpacity(0.38);
    if (isHovering) {
      final Color hoverColor = decoration.hoverColor ??
          themeData.inputDecorationTheme.hoverColor ??
          themeData.hoverColor;
      return Color.alphaBlend(hoverColor.withOpacity(0.12), enabledColor);
    }
    return enabledColor;
  }

  Color _getFillColor(ThemeData themeData, InputDecorationTheme defaults) {
    if (decoration.filled != true) {
      // filled == null same as filled == false
      return Colors.transparent;
    }
    if (decoration.fillColor != null) {
      return MaterialStateProperty.resolveAs(
          decoration.fillColor!, materialState);
    }
    return MaterialStateProperty.resolveAs(defaults.fillColor!, materialState);
  }

  Color _getHoverColor(ThemeData themeData) {
    if (decoration.filled == null ||
        !decoration.filled! ||
        isFocused ||
        !decoration.enabled) {
      return Colors.transparent;
    }
    return decoration.hoverColor ??
        themeData.inputDecorationTheme.hoverColor ??
        themeData.hoverColor;
  }

  Color _getIconColor(ThemeData themeData, InputDecorationTheme defaults) {
    return MaterialStateProperty.resolveAs(
            decoration.iconColor, materialState) ??
        MaterialStateProperty.resolveAs(
            themeData.inputDecorationTheme.iconColor, materialState) ??
        MaterialStateProperty.resolveAs(defaults.iconColor!, materialState);
  }

  Color _getPrefixIconColor(
      ThemeData themeData, InputDecorationTheme defaults) {
    return MaterialStateProperty.resolveAs(
            decoration.prefixIconColor, materialState) ??
        MaterialStateProperty.resolveAs(
            themeData.inputDecorationTheme.prefixIconColor, materialState) ??
        MaterialStateProperty.resolveAs(
            defaults.prefixIconColor!, materialState) ??
        adrColor.backgroundBaseDark;
  }

  Color _getSuffixIconColor(
      ThemeData themeData, InputDecorationTheme defaults) {
    return MaterialStateProperty.resolveAs(
            decoration.suffixIconColor, materialState) ??
        MaterialStateProperty.resolveAs(
            themeData.inputDecorationTheme.suffixIconColor, materialState) ??
        MaterialStateProperty.resolveAs(
            defaults.suffixIconColor!, materialState) ??
        adrColor.backgroundBaseDark;
  }

  Color _getErrorIconColor(ThemeData themeData, InputDecorationTheme defaults) {
    return MaterialStateProperty.resolveAs(adrColor.textError, materialState);
    //  ??
    // MaterialStateProperty.resolveAs(
    //     themeData.inputDecorationTheme.suffixIconColor, materialState) ??
    // MaterialStateProperty.resolveAs(
    //     defaults.suffixIconColor!, materialState) ??
    // adrColor.backgroundBaseDark;
  }

  bool get _hasInlineLabel {
    return !widget._labelShouldWithdraw &&
        (decoration.labelText != null || decoration.label != null) &&
        decoration.floatingLabelBehavior != FloatingLabelBehavior.always;
  }

  // If the label is a floating placeholder, it's always shown.
  bool get _shouldShowLabel => _hasInlineLabel || _floatingLabelEnabled;

  // The base style for the inline label when they're displayed "inline",
  // i.e. when they appear in place of the empty text field.
  TextStyle _getInlineLabelStyle(
      ThemeData themeData, InputDecorationTheme defaults) {
    final TextStyle defaultStyle =
        MaterialStateProperty.resolveAs(defaults.labelStyle!, materialState);

    final TextStyle? style =
        MaterialStateProperty.resolveAs(decoration.labelStyle, materialState) ??
            MaterialStateProperty.resolveAs(
                themeData.inputDecorationTheme.labelStyle, materialState);

    return themeData.textTheme.titleMedium!
        .merge(widget.baseStyle)
        .merge(defaultStyle)
        .merge(style)
        .copyWith(height: 1);
  }

  // The base style for the inline hint when they're displayed "inline",
  // i.e. when they appear in place of the empty text field.
  bool get _labelEnabled => _effectiveDecoration?.enabled != false;

  TextStyle _getInlineHintStyle(
      ThemeData themeData, InputDecorationTheme defaults) {
    const TextStyle adHintStyle = TextStyle(
      //TODO JADI TEXTDISABLED KALAU DISABLED
      color: adrColor.textGray,
      // color: adrColor.textDisable,
      // color: _labelEnabled ? adrColor.textSuccess : adrColor.textGray,
      fontSize: adrFont.body2FontSize,
      fontWeight: adrFont.weightRegular,
    );
    final TextStyle defaultStyle =
        MaterialStateProperty.resolveAs(defaults.hintStyle!, materialState);

    final TextStyle style =
        MaterialStateProperty.resolveAs(decoration.hintStyle, materialState) ??
            MaterialStateProperty.resolveAs(
                themeData.inputDecorationTheme.hintStyle, materialState) ??
            adHintStyle;

    return themeData.textTheme.titleMedium!
        .merge(widget.baseStyle)
        .merge(defaultStyle)
        .merge(style);
  }

  TextStyle _getFloatingLabelStyle(
      ThemeData themeData, InputDecorationTheme defaults) {
    TextStyle defaultTextStyle = MaterialStateProperty.resolveAs(
        defaults.floatingLabelStyle!, materialState);
    if (decoration.errorText != null && decoration.errorStyle?.color != null) {
      defaultTextStyle =
          defaultTextStyle.copyWith(color: decoration.errorStyle?.color);
    }
    defaultTextStyle = defaultTextStyle
        .merge(decoration.floatingLabelStyle ?? decoration.labelStyle);

    final TextStyle? style = MaterialStateProperty.resolveAs(
            decoration.floatingLabelStyle, materialState) ??
        MaterialStateProperty.resolveAs(
            themeData.inputDecorationTheme.floatingLabelStyle, materialState);

    return themeData.textTheme.titleMedium!
        .merge(widget.baseStyle)
        .copyWith(height: 1)
        .merge(defaultTextStyle)
        .merge(style);
  }

  TextStyle _getHelperStyle(
      ThemeData themeData, InputDecorationTheme defaults) {
    return MaterialStateProperty.resolveAs(defaults.helperStyle!, materialState)
        .merge(MaterialStateProperty.resolveAs(
            decoration.helperStyle, materialState));
  }

  TextStyle _getErrorStyle(ThemeData themeData, InputDecorationTheme defaults) {
    return MaterialStateProperty.resolveAs(defaults.errorStyle!, materialState)
        .merge(decoration.errorStyle);
  }

  Set<MaterialState> get materialState {
    return <MaterialState>{
      if (!decoration.enabled) MaterialState.disabled,
      if (isFocused) MaterialState.focused,
      if (isHovering) MaterialState.hovered,
      if (decoration.errorText != null) MaterialState.error,
    };
  }

  InputBorder _getDefaultBorder(
      ThemeData themeData, InputDecorationTheme defaults) {
    final InputBorder border =
        MaterialStateProperty.resolveAs(decoration.border, materialState) ??
            // const OutlineInputBorder() ??
            const UnderlineInputBorder();

    if (decoration.border is MaterialStateProperty<InputBorder>) {
      return border;
    }

    if (border.borderSide == BorderSide.none) {
      return border;
    }

    if (themeData.useMaterial3) {
      if (decoration.filled!) {
        return border.copyWith(
          borderSide: MaterialStateProperty.resolveAs(
              defaults.activeIndicatorBorder, materialState),
        );
      } else {
        return border.copyWith(
          borderSide: MaterialStateProperty.resolveAs(
              defaults.outlineBorder, materialState),
        );
      }
    } else {
      return border.copyWith(
        borderSide: BorderSide(
          color: _getDefaultM2BorderColor(themeData),
          width: (decoration.isCollapsed ||
                  decoration.border == InputBorder.none ||
                  !decoration.enabled)
              ? 0.0
              : isFocused
                  ? 2.0
                  : 1.0,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final InputDecorationTheme defaults = Theme.of(context).useMaterial3
        ? _InputDecoratorDefaultsM3(context)
        : _InputDecoratorDefaultsM2(context);

    final TextStyle labelStyle = _getInlineLabelStyle(themeData, defaults);
    final TextBaseline textBaseline = labelStyle.textBaseline!;

    final TextStyle hintStyle = _getInlineHintStyle(themeData, defaults);
    final String? hintText = decoration.hintText;
    bool adaPrefix = widget.decoration.prefixIcon != null ||
        widget.decoration.prefix != null ||
        widget.decoration.prefixText != null;

    bool dariKanan = widget.textAlign == TextAlign.end;

    final Widget? hint = hintText == null
        ? null
        : AnimatedOpacity(
            opacity: (isEmpty && !_hasInlineLabel) ? 1.0 : 0.0,
            duration: _kTransitionDuration,
            curve: _kTransitionCurve,
            alwaysIncludeSemantics: isEmpty ||
                (decoration.labelText == null && decoration.label == null),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: adaPrefix ? (dariKanan ? 16 : 6.0) : 16,
              ),
              child: Text(
                hintText,
                style: hintStyle,
                textDirection: decoration.hintTextDirection,
                overflow: hintStyle.overflow ?? TextOverflow.ellipsis,
                textAlign: textAlign,
                maxLines: decoration.hintMaxLines,
              ),
            ),
          );

    final bool isError = decoration.errorText != null;
    InputBorder? border;
    if (!decoration.enabled) {
      border = isError ? decoration.errorBorder : decoration.disabledBorder;
    } else if (isFocused) {
      border =
          isError ? decoration.focusedErrorBorder : decoration.focusedBorder;
    } else {
      border = isError ? decoration.errorBorder : decoration.enabledBorder;
    }
    border ??= _getDefaultBorder(themeData, defaults);

    final Widget container = _BorderContainer(
      border: border,
      gap: _borderGap,
      gapAnimation: _floatingLabelController.view,
      fillColor: _getFillColor(themeData, defaults),
      hoverColor: _getHoverColor(themeData),
      isHovering: isHovering,
    );

    final Widget? label =
        decoration.labelText == null && decoration.label == null
            ? null
            : _Shaker(
                animation: _shakingLabelController.view,
                child: AnimatedOpacity(
                  duration: _kTransitionDuration,
                  curve: _kTransitionCurve,
                  opacity: _shouldShowLabel ? 1.0 : 0.0,
                  child: AnimatedDefaultTextStyle(
                    duration: _kTransitionDuration,
                    curve: _kTransitionCurve,
                    style: widget._labelShouldWithdraw
                        ? _getFloatingLabelStyle(themeData, defaults)
                        : labelStyle,
                    child: decoration.label ??
                        Text(
                          decoration.labelText!,
                          overflow: TextOverflow.ellipsis,
                          textAlign: textAlign,
                        ),
                  ),
                ),
              );
    bool adaPrefixIcon = decoration.prefixIcon != null;
    final Widget? prefix =
        decoration.prefix == null && decoration.prefixText == null
            ? null
            : Padding(
                padding: EdgeInsets.only(left: adaPrefixIcon ? 4 : 16.0),
                child: _AffixText(
                  labelIsFloating: widget._labelShouldWithdraw,
                  // labelIsFloating: true,
                  text: decoration.prefixText,
                  style: MaterialStateProperty.resolveAs(
                          decoration.prefixStyle, materialState) ??
                      hintStyle,
                  child: decoration.prefix,
                ),
              );

    bool adaSufixIcon = decoration.suffixIcon != null;
    bool adaError = decoration.errorText != null;

    final Widget? suffix =
        decoration.suffix == null && decoration.suffixText == null
            ? null
            : Padding(
                padding: EdgeInsets.only(
                    right: adaSufixIcon ? 4 : (adaError ? 4 : 16.0), left: 4),
                child: _AffixText(
                  labelIsFloating: widget._labelShouldWithdraw,
                  text: decoration.suffixText,
                  style: MaterialStateProperty.resolveAs(
                          decoration.suffixStyle, materialState) ??
                      hintStyle,
                  child: decoration.suffix,
                ),
              );

    final bool decorationIsDense = decoration.isDense ?? false;
    final double iconSize = decorationIsDense ? 18.0 : 24.0;

    final Widget? icon = decoration.icon == null
        ? null
        : MouseRegion(
            cursor: SystemMouseCursors.basic,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(end: 16.0),
              child: IconTheme.merge(
                data: IconThemeData(
                  color: _getIconColor(themeData, defaults),
                  size: iconSize,
                ),
                child: decoration.icon!,
              ),
            ),
          );

    final Widget? prefixIcon = decoration.prefixIcon == null
        ? null
        : Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Center(
              widthFactor: 1.0,
              heightFactor: 1.0,
              child: MouseRegion(
                cursor: SystemMouseCursors.basic,
                child: ConstrainedBox(
                  constraints: decoration.prefixIconConstraints ??
                      themeData.visualDensity.effectiveConstraints(
                        const BoxConstraints(
                          minWidth: kMinInteractiveDimension,
                          minHeight: kMinInteractiveDimension,
                        ),
                      ),
                  child: IconTheme.merge(
                    data: IconThemeData(
                      color: _getPrefixIconColor(themeData, defaults),
                      size: iconSize,
                    ),
                    child: decoration.prefixIcon!,
                  ),
                ),
              ),
            ),
          );

    // bool adaError = decoration.errorText != null;
    final Widget? suffixIcon = decoration.suffixIcon == null
        ? null
        : Padding(
            padding: EdgeInsets.only(right: adaError ? 0 : 8.0),
            child: Center(
              widthFactor: 1.0,
              heightFactor: 1.0,
              child: MouseRegion(
                cursor: SystemMouseCursors.basic,
                child: ConstrainedBox(
                  constraints: decoration.suffixIconConstraints ??
                      themeData.visualDensity.effectiveConstraints(
                        const BoxConstraints(
                          minWidth: kMinInteractiveDimension,
                          minHeight: kMinInteractiveDimension,
                        ),
                      ),
                  child: IconTheme.merge(
                    data: IconThemeData(
                      color: _getSuffixIconColor(themeData, defaults),
                      size: iconSize,
                    ),
                    child: decoration.suffixIcon!,
                  ),
                ),
              ),
            ),
          );

    final Widget? errorIcon = decoration.errorText == null
        ? null
        : Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Center(
              widthFactor: 1.0,
              heightFactor: 1.0,
              child: MouseRegion(
                cursor: SystemMouseCursors.basic,
                child: ConstrainedBox(
                  constraints: decoration.suffixIconConstraints ??
                      themeData.visualDensity.effectiveConstraints(
                        const BoxConstraints(
                          minWidth: kMinInteractiveDimension,
                          minHeight: kMinInteractiveDimension,
                        ),
                      ),
                  child: IconTheme.merge(
                    data: IconThemeData(
                      color: adrColor.textError,
                      size: iconSize,
                    ),
                    child: const Icon(Icons.info_outline),
                  ),
                ),
              ),
            ),
          );

    final Widget helperError = _HelperError(
      textAlign: textAlign,
      helperText: decoration.helperText,
      helperStyle: _getHelperStyle(themeData, defaults),
      helperMaxLines: decoration.helperMaxLines,
      errorText: decoration.errorText,
      errorStyle: _getErrorStyle(themeData, defaults),
      errorMaxLines: decoration.errorMaxLines,
    );

    Widget? counter;
    if (decoration.counter != null) {
      counter = decoration.counter;
    } else if (decoration.counterText != null && decoration.counterText != '') {
      counter = Semantics(
        container: true,
        liveRegion: isFocused,
        child: Text(
          decoration.counterText!,
          style: _getHelperStyle(themeData, defaults).merge(
              MaterialStateProperty.resolveAs(
                  decoration.counterStyle, materialState)),
          overflow: TextOverflow.ellipsis,
          semanticsLabel: decoration.semanticCounterText,
        ),
      );
    }

    // The _Decoration widget and _RenderDecoration assume that contentPadding
    // has been resolved to EdgeInsets.
    final TextDirection textDirection = Directionality.of(context);
    final EdgeInsets? decorationContentPadding =
        decoration.contentPadding?.resolve(textDirection);

    final EdgeInsets contentPadding;
    final double floatingLabelHeight;
    if (decoration.isCollapsed) {
      floatingLabelHeight = 0.0;
      contentPadding = decorationContentPadding ?? EdgeInsets.zero;
    } else if (!border.isOutline) {
      // print('border is not outline');
      // 4.0: the vertical gap between the inline elements and the floating label.
      //TODO: MAKE THIS WORK WITH OUTLINEINPUTBORDER
      floatingLabelHeight = (14.0 + 0.75 * labelStyle.fontSize!) *
          MediaQuery.textScaleFactorOf(context);
      // floatingLabelHeight = 0;
      if (decoration.filled ?? false) {
        contentPadding = decorationContentPadding ??
            (decorationIsDense
                ? const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0)
                : const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0));
      } else {
        // print('border is outline');
        // Not left or right padding for underline borders that aren't filled
        // is a small concession to backwards compatibility. This eliminates
        // the most noticeable layout change introduced by #13734.
        contentPadding = decorationContentPadding ??
            (decorationIsDense
                ? const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0)
                : const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 12.0));
      }
    } else {
      // print('border is outline');
      // floatingLabelHeight = 0.0;
      floatingLabelHeight = (14.0 + 0.75 * labelStyle.fontSize!) *
          MediaQuery.textScaleFactorOf(context);
      // floatingLabelHeight = 8;
      contentPadding = decorationContentPadding ??
          (decorationIsDense
              ? const EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 12.0)
              : const EdgeInsets.fromLTRB(12.0, 24.0, 12.0, 16.0));
    }

    final Widget positionedHelperError = helperError;

    // final _Decorator decorator = _Decorator(
    final Widget decorator = _Decorator(
      decoration: _Decoration(
          contentPadding: contentPadding,
          isCollapsed: decoration.isCollapsed,
          floatingLabelHeight: floatingLabelHeight,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          // floatingLabelAlignment: decoration.floatingLabelAlignment!,
          floatingLabelProgress: _floatingLabelController.value,
          border: border,
          borderGap: _borderGap,
          alignLabelWithHint: decoration.alignLabelWithHint ?? false,
          isDense: decoration.isDense,
          visualDensity: themeData.visualDensity,
          icon: icon,
          input: widget.child,
          label: label,
          hint: hint,
          prefix: prefix,
          suffix: suffix,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          errorIcon: errorIcon,
          // helperError: helperError,
          helperError: positionedHelperError,
          counter: counter,
          container: container),
      textDirection: textDirection,
      textBaseline: textBaseline,
      textAlignVertical: widget.textAlignVertical,
      isFocused: isFocused,
      expands: widget.expands,
    );

    final BoxConstraints? constraints =
        decoration.constraints ?? themeData.inputDecorationTheme.constraints;
    if (constraints != null) {
      return ConstrainedBox(
        constraints: constraints,
        child: decorator,
      );
    }
    return decorator;
  }
}

class _Decorator extends RenderObjectWidget
    with SlottedMultiChildRenderObjectWidgetMixin<_DecorationSlot> {
  const _Decorator({
    required this.textAlignVertical,
    required this.decoration,
    required this.textDirection,
    required this.textBaseline,
    required this.isFocused,
    required this.expands,
  })  : assert(decoration != null),
        assert(textDirection != null),
        assert(textBaseline != null),
        assert(expands != null);

  final _Decoration decoration;
  final TextDirection textDirection;
  final TextBaseline textBaseline;
  final TextAlignVertical? textAlignVertical;
  final bool isFocused;
  final bool expands;

  @override
  Iterable<_DecorationSlot> get slots => _DecorationSlot.values;

  @override
  Widget? childForSlot(_DecorationSlot slot) {
    switch (slot) {
      case _DecorationSlot.icon:
        return decoration.icon;
      case _DecorationSlot.input:
        return decoration.input;
      case _DecorationSlot.label:
        return decoration.label;
      case _DecorationSlot.hint:
        return decoration.hint;
      case _DecorationSlot.prefix:
        return decoration.prefix;
      case _DecorationSlot.suffix:
        return decoration.suffix;
      case _DecorationSlot.prefixIcon:
        return decoration.prefixIcon;
      case _DecorationSlot.suffixIcon:
        return decoration.suffixIcon;
      case _DecorationSlot.errorIcon:
        return decoration.errorIcon;
      case _DecorationSlot.helperError:
        return decoration.helperError;
      case _DecorationSlot.counter:
        return decoration.counter;
      case _DecorationSlot.container:
        return decoration.container;
    }
  }

  @override
  _RenderDecoration createRenderObject(BuildContext context) {
    return _RenderDecoration(
      decoration: decoration,
      textDirection: textDirection,
      textBaseline: textBaseline,
      textAlignVertical: textAlignVertical,
      isFocused: isFocused,
      expands: expands,
      material3: Theme.of(context).useMaterial3,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, _RenderDecoration renderObject) {
    renderObject
      ..decoration = decoration
      ..expands = expands
      ..isFocused = isFocused
      ..textAlignVertical = textAlignVertical
      ..textBaseline = textBaseline
      ..textDirection = textDirection;
  }
}

class _RenderDecoration extends RenderBox
    with SlottedContainerRenderObjectMixin<_DecorationSlot> {
  _RenderDecoration({
    required _Decoration decoration,
    required TextDirection textDirection,
    required TextBaseline textBaseline,
    required bool isFocused,
    required bool expands,
    required bool material3,
    TextAlignVertical? textAlignVertical,
  })  :
        // assert(decoration != null),
        //       assert(textDirection != null),
        //       assert(textBaseline != null),
        //       assert(expands != null),
        _decoration = decoration,
        _textDirection = textDirection,
        _textBaseline = textBaseline,
        _textAlignVertical = textAlignVertical,
        _isFocused = isFocused,
        _expands = expands,
        _material3 = material3;

  static const double subtextGap = 8.0;

  RenderBox? get icon => childForSlot(_DecorationSlot.icon);
  RenderBox? get input => childForSlot(_DecorationSlot.input);
  RenderBox? get label => childForSlot(_DecorationSlot.label);
  RenderBox? get hint => childForSlot(_DecorationSlot.hint);
  RenderBox? get prefix => childForSlot(_DecorationSlot.prefix);
  RenderBox? get suffix => childForSlot(_DecorationSlot.suffix);
  RenderBox? get prefixIcon => childForSlot(_DecorationSlot.prefixIcon);
  RenderBox? get suffixIcon => childForSlot(_DecorationSlot.suffixIcon);
  RenderBox? get errorIcon => childForSlot(_DecorationSlot.errorIcon);
  RenderBox? get helperError => childForSlot(_DecorationSlot.helperError);
  RenderBox? get counter => childForSlot(_DecorationSlot.counter);
  RenderBox? get container => childForSlot(_DecorationSlot.container);

  // The returned list is ordered for hit testing.
  @override
  Iterable<RenderBox> get children {
    return <RenderBox>[
      if (icon != null) icon!,
      if (input != null) input!,
      if (prefixIcon != null) prefixIcon!,
      if (suffixIcon != null) suffixIcon!,
      if (errorIcon != null) errorIcon!,
      if (prefix != null) prefix!,
      if (suffix != null) suffix!,
      if (label != null) label!,
      if (hint != null) hint!,
      if (helperError != null) helperError!,
      if (counter != null) counter!,
      if (container != null) container!,
    ];
  }

  _Decoration get decoration => _decoration;
  _Decoration _decoration;
  set decoration(_Decoration value) {
    assert(value != null);
    if (_decoration == value) {
      return;
    }
    _decoration = value;
    markNeedsLayout();
  }

  TextDirection get textDirection => _textDirection;
  TextDirection _textDirection;
  set textDirection(TextDirection value) {
    assert(value != null);
    if (_textDirection == value) {
      return;
    }
    _textDirection = value;
    markNeedsLayout();
  }

  TextBaseline get textBaseline => _textBaseline;
  TextBaseline _textBaseline;
  set textBaseline(TextBaseline value) {
    assert(value != null);
    if (_textBaseline == value) {
      return;
    }
    _textBaseline = value;
    markNeedsLayout();
  }

  TextAlignVertical get _defaultTextAlignVertical =>
      _isOutlineAligned ? TextAlignVertical.center : TextAlignVertical.top;
  TextAlignVertical get textAlignVertical =>
      _textAlignVertical ?? _defaultTextAlignVertical;
  TextAlignVertical? _textAlignVertical;
  set textAlignVertical(TextAlignVertical? value) {
    if (_textAlignVertical == value) {
      return;
    }
    // No need to relayout if the effective value is still the same.
    if (textAlignVertical.y == (value?.y ?? _defaultTextAlignVertical.y)) {
      _textAlignVertical = value;
      return;
    }
    _textAlignVertical = value;
    markNeedsLayout();
  }

  bool get isFocused => _isFocused;
  bool _isFocused;
  set isFocused(bool value) {
    assert(value != null);
    if (_isFocused == value) {
      return;
    }
    _isFocused = value;
    markNeedsSemanticsUpdate();
  }

  bool get expands => _expands;
  bool _expands = false;
  set expands(bool value) {
    assert(value != null);
    if (_expands == value) {
      return;
    }
    _expands = value;
    markNeedsLayout();
  }

  bool get material3 => _material3;
  bool _material3 = false;
  set material3(bool value) {
    if (_material3 == value) {
      return;
    }
    _material3 = value;
    markNeedsLayout();
  }

  // Indicates that the decoration should be aligned to accommodate an outline
  // border.
  bool get _isOutlineAligned {
    return !decoration.isCollapsed && decoration.border.isOutline;
  }

  @override
  void visitChildrenForSemantics(RenderObjectVisitor visitor) {
    if (icon != null) {
      visitor(icon!);
    }
    if (prefix != null) {
      visitor(prefix!);
    }
    if (prefixIcon != null) {
      visitor(prefixIcon!);
    }

    if (label != null) {
      visitor(label!);
    }
    if (hint != null) {
      if (isFocused) {
        visitor(hint!);
      } else if (label == null) {
        visitor(hint!);
      }
    }

    if (input != null) {
      visitor(input!);
    }
    if (suffixIcon != null) {
      visitor(suffixIcon!);
    }
    if (errorIcon != null) {
      visitor(errorIcon!);
    }
    if (suffix != null) {
      visitor(suffix!);
    }
    if (container != null) {
      visitor(container!);
    }
    if (helperError != null) {
      visitor(helperError!);
    }
    if (counter != null) {
      visitor(counter!);
    }
  }

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

  static BoxParentData _boxParentData(RenderBox box) =>
      box.parentData! as BoxParentData;

  EdgeInsets get contentPadding => decoration.contentPadding as EdgeInsets;

  // Lay out the given box if needed, and return its baseline.
  double _layoutLineBox(RenderBox? box, BoxConstraints constraints) {
    if (box == null) {
      return 0.0;
    }
    box.layout(constraints, parentUsesSize: true);
    // Since internally, all layout is performed against the alphabetic baseline,
    // (eg, ascents/descents are all relative to alphabetic, even if the font is
    // an ideographic or hanging font), we should always obtain the reference
    // baseline from the alphabetic baseline. The ideographic baseline is for
    // use post-layout and is derived from the alphabetic baseline combined with
    // the font metrics.
    final double baseline = box.getDistanceToBaseline(TextBaseline.alphabetic)!;

    assert(() {
      if (baseline >= 0) {
        return true;
      }
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary(
            "One of InputDecorator's children reported a negative baseline offset."),
        ErrorDescription(
          '${box.runtimeType}, of size ${box.size}, reported a negative '
          'alphabetic baseline of $baseline.',
        ),
      ]);
    }());
    return baseline;
  }

  // Returns a value used by performLayout to position all of the renderers.
  // This method applies layout to all of the renderers except the container.
  // For convenience, the container is laid out in performLayout().
  _RenderDecorationLayout _layout(BoxConstraints layoutConstraints) {
    assert(
      layoutConstraints.maxWidth < double.infinity,
      'An InputDecorator, which is typically created by a TextField, cannot '
      'have an unbounded width.\n'
      'This happens when the parent widget does not provide a finite width '
      'constraint. For example, if the InputDecorator is contained by a Row, '
      'then its width must be constrained. An Expanded widget or a SizedBox '
      'can be used to constrain the width of the InputDecorator or the '
      'TextField that contains it.',
    );

    // Margin on each side of subtext (counter and helperError)
    final Map<RenderBox?, double> boxToBaseline = <RenderBox?, double>{};
    final BoxConstraints boxConstraints = layoutConstraints.loosen();

    // Layout all the widgets used by InputDecorator
    boxToBaseline[icon] = _layoutLineBox(icon, boxConstraints);
    final BoxConstraints containerConstraints = boxConstraints.copyWith(
      maxWidth: boxConstraints.maxWidth - _boxSize(icon).width,
    );
    boxToBaseline[prefixIcon] =
        _layoutLineBox(prefixIcon, containerConstraints);
    boxToBaseline[suffixIcon] =
        _layoutLineBox(suffixIcon, containerConstraints);
    boxToBaseline[errorIcon] = _layoutLineBox(errorIcon, containerConstraints);
    final BoxConstraints contentConstraints = containerConstraints.copyWith(
      maxWidth: containerConstraints.maxWidth - contentPadding.horizontal,
    );
    boxToBaseline[prefix] = _layoutLineBox(prefix, contentConstraints);
    boxToBaseline[suffix] = _layoutLineBox(suffix, contentConstraints);
    // boxToBaseline[errorIcon] = _layoutLineBox(errorIcon, contentConstraints);

    final double inputWidth = math.max(
      0.0,
      constraints.maxWidth -
          (_boxSize(icon).width +
              contentPadding.left +
              _boxSize(prefixIcon).width +
              _boxSize(prefix).width +
              _boxSize(suffix).width +
              _boxSize(suffixIcon).width +
              _boxSize(errorIcon).width +
              contentPadding.right),
    );
    // Increase the available width for the label when it is scaled down.
    final double invertedLabelScale = ui.lerpDouble(
        1.00, 1 / _kFinalLabelScale, decoration.floatingLabelProgress)!;
    double suffixIconWidth = _boxSize(suffixIcon).width;
    double errorIconWidth = _boxSize(errorIcon).width;
    if (decoration.border.isOutline) {
      suffixIconWidth = ui.lerpDouble(
          suffixIconWidth, 0.0, decoration.floatingLabelProgress)!;
      errorIconWidth =
          ui.lerpDouble(errorIconWidth, 0.0, decoration.floatingLabelProgress)!;
    }
    final double labelWidth = math.max(
      0.0,
      constraints.maxWidth -
          (_boxSize(icon).width +
              contentPadding.left +
              _boxSize(prefixIcon).width +
              suffixIconWidth +
              errorIconWidth +
              contentPadding.right),
    );
    boxToBaseline[label] = _layoutLineBox(
      label,
      boxConstraints.copyWith(maxWidth: labelWidth * invertedLabelScale),
    );
    boxToBaseline[hint] = _layoutLineBox(
      hint,
      boxConstraints.copyWith(minWidth: inputWidth, maxWidth: inputWidth),
    );
    boxToBaseline[counter] = _layoutLineBox(counter, contentConstraints);

    // The helper or error text can occupy the full width less the space
    // occupied by the icon and counter.
    boxToBaseline[helperError] = _layoutLineBox(
      helperError,
      contentConstraints.copyWith(
        maxWidth: math.max(
            0.0, contentConstraints.maxWidth - _boxSize(counter).width),
      ),
    );

    // The height of the input needs to accommodate label above and counter and
    // helperError below, when they exist.
    final double labelHeight =
        label == null ? 0 : decoration.floatingLabelHeight;
    final double topHeight = decoration.border.isOutline
        ? math.max(labelHeight - boxToBaseline[label]!, 0)
        : labelHeight;
    final double counterHeight =
        counter == null ? 100 : boxToBaseline[counter]! + subtextGap;
    final bool helperErrorExists =
        helperError?.size != null && helperError!.size.height > 0;
    final double helperErrorHeight =
        !helperErrorExists ? 0 : helperError!.size.height + subtextGap;
    final double bottomHeight = math.max(
      counterHeight,
      helperErrorHeight,
    );
    final Offset densityOffset = decoration.visualDensity.baseSizeAdjustment;
    boxToBaseline[input] = _layoutLineBox(
      input,
      boxConstraints
          .deflate(EdgeInsets.only(
            top: contentPadding.top + topHeight + densityOffset.dy / 2,
            bottom: contentPadding.bottom + bottomHeight + densityOffset.dy / 2,
          ))
          .copyWith(
            minWidth: inputWidth,
            maxWidth: inputWidth,
          ),
    );

    // The field can be occupied by a hint or by the input itself
    final double hintHeight = hint?.size.height ?? 0;
    final double inputDirectHeight = input?.size.height ?? 0;
    final double inputHeight = math.max(hintHeight, inputDirectHeight);
    final double inputInternalBaseline = math.max(
      boxToBaseline[input]!,
      boxToBaseline[hint]!,
    );

    // Calculate the amount that prefix/suffix affects height above and below
    // the input.
    final double prefixHeight = prefix?.size.height ?? 0;
    final double suffixHeight = suffix?.size.height ?? 0;
    final double fixHeight = math.max(
      boxToBaseline[prefix]!,
      boxToBaseline[suffix]!,
    );
    final double fixAboveInput = math.max(0, fixHeight - inputInternalBaseline);
    final double fixBelowBaseline = math.max(
      prefixHeight - boxToBaseline[prefix]!,
      suffixHeight - boxToBaseline[suffix]!,
    );
    // TODO(justinmc): fixBelowInput should have no effect when there is no
    // prefix/suffix below the input.
    // https://github.com/flutter/flutter/issues/66050
    final double fixBelowInput = math.max(
      0,
      fixBelowBaseline - (inputHeight - inputInternalBaseline),
    );

    // Calculate the height of the input text container.
    final double prefixIconHeight = prefixIcon?.size.height ?? 0;
    final double suffixIconHeight = suffixIcon?.size.height ?? 0;
    final double errorIconHeight = errorIcon?.size.height ?? 0;
    final double fixIconHeight = math.max(
      prefixIconHeight,
      suffixIconHeight,
    );
    // final double fixIconHeight = math.max(
    //   prefixIconHeight,
    //   errorIconHeight,
    // );
    final double contentHeight = math.max(
      fixIconHeight,
      topHeight +
          contentPadding.top +
          fixAboveInput +
          inputHeight +
          fixBelowInput +
          contentPadding.bottom +
          densityOffset.dy,
    );
    final double minContainerHeight =
        decoration.isDense! || decoration.isCollapsed || expands
            ? 0.0
            : kMinInteractiveDimension;
    final double maxContainerHeight = boxConstraints.maxHeight - bottomHeight;
    final double containerHeight = expands
        ? maxContainerHeight
        : math.min(
            math.max(contentHeight, minContainerHeight), maxContainerHeight);

    // Ensure the text is vertically centered in cases where the content is
    // shorter than kMinInteractiveDimension.
    final double interactiveAdjustment = minContainerHeight > contentHeight
        ? (minContainerHeight - contentHeight) / 2.0
        : 0.0;

    // Try to consider the prefix/suffix as part of the text when aligning it.
    // If the prefix/suffix overflows however, allow it to extend outside of the
    // input and align the remaining part of the text and prefix/suffix.
    final double overflow = math.max(0, contentHeight - maxContainerHeight);
    // Map textAlignVertical from -1:1 to 0:1 so that it can be used to scale
    // the baseline from its minimum to maximum values.
    final double textAlignVerticalFactor = (textAlignVertical.y + 1.0) / 2.0;
    // Adjust to try to fit top overflow inside the input on an inverse scale of
    // textAlignVertical, so that top aligned text adjusts the most and bottom
    // aligned text doesn't adjust at all.
    final double baselineAdjustment =
        fixAboveInput - overflow * (1 - textAlignVerticalFactor);

    // The baselines that will be used to draw the actual input text content.
    final double topInputBaseline = contentPadding.top +
        topHeight +
        inputInternalBaseline +
        baselineAdjustment +
        interactiveAdjustment +
        densityOffset.dy / 2.0;
    final double maxContentHeight = containerHeight -
        contentPadding.vertical -
        topHeight -
        densityOffset.dy;
    final double alignableHeight = fixAboveInput + inputHeight + fixBelowInput;
    final double maxVerticalOffset = maxContentHeight - alignableHeight;
    final double textAlignVerticalOffset =
        maxVerticalOffset * textAlignVerticalFactor;
    final double inputBaseline = topInputBaseline + textAlignVerticalOffset;

    // The three main alignments for the baseline when an outline is present are
    //
    //  * top (-1.0): topmost point considering padding.
    //  * center (0.0): the absolute center of the input ignoring padding but
    //      accommodating the border and floating label.
    //  * bottom (1.0): bottommost point considering padding.
    //
    // That means that if the padding is uneven, center is not the exact
    // midpoint of top and bottom. To account for this, the above center and
    // below center alignments are interpolated independently.
    final double outlineCenterBaseline = inputInternalBaseline +
        baselineAdjustment / 2.0 +
        (containerHeight - (2.0 + inputHeight)) / 2.0;
    final double outlineTopBaseline = topInputBaseline;
    final double outlineBottomBaseline = topInputBaseline + maxVerticalOffset;
    final double outlineBaseline = _interpolateThree(
      outlineTopBaseline,
      outlineCenterBaseline,
      outlineBottomBaseline,
      textAlignVertical,
    );

    // Find the positions of the text below the input when it exists.
    double subtextCounterBaseline = 0;
    double subtextHelperBaseline = 0;
    double subtextCounterHeight = 0;
    double subtextHelperHeight = 0;
    if (counter != null) {
      subtextCounterBaseline =
          containerHeight + subtextGap + boxToBaseline[counter]!;
      subtextCounterHeight = counter!.size.height + subtextGap;
    }
    if (helperErrorExists) {
      subtextHelperBaseline =
          containerHeight + subtextGap + boxToBaseline[helperError]!;
      subtextHelperHeight = helperErrorHeight;
    }
    final double subtextBaseline = math.max(
      subtextCounterBaseline,
      subtextHelperBaseline,
    );
    final double subtextHeight = math.max(
      subtextCounterHeight,
      subtextHelperHeight,
    );

    return _RenderDecorationLayout(
      boxToBaseline: boxToBaseline,
      containerHeight: containerHeight,
      inputBaseline: inputBaseline,
      outlineBaseline: outlineBaseline,
      subtextBaseline: subtextBaseline,
      subtextHeight: subtextHeight,
    );
  }

  // Interpolate between three stops using textAlignVertical. This is used to
  // calculate the outline baseline, which ignores padding when the alignment is
  // middle. When the alignment is less than zero, it interpolates between the
  // centered text box's top and the top of the content padding. When the
  // alignment is greater than zero, it interpolates between the centered box's
  // top and the position that would align the bottom of the box with the bottom
  // padding.
  double _interpolateThree(double begin, double middle, double end,
      TextAlignVertical textAlignVertical) {
    if (textAlignVertical.y <= 0) {
      // It's possible for begin, middle, and end to not be in order because of
      // excessive padding. Those cases are handled by using middle.
      if (begin >= middle) {
        return middle;
      }
      // Do a standard linear interpolation on the first half, between begin and
      // middle.
      final double t = textAlignVertical.y + 1;
      return begin + (middle - begin) * t;
    }

    if (middle >= end) {
      return middle;
    }
    // Do a standard linear interpolation on the second half, between middle and
    // end.
    final double t = textAlignVertical.y;
    return middle + (end - middle) * t;
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    return _minWidth(icon, height) +
        contentPadding.left +
        _minWidth(prefixIcon, height) +
        _minWidth(prefix, height) +
        math.max(_minWidth(input, height), _minWidth(hint, height)) +
        _minWidth(suffix, height) +
        _minWidth(suffixIcon, height) +
        // _minWidth(errorIcon, height) +
        contentPadding.right;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return _maxWidth(icon, height) +
        contentPadding.left +
        _maxWidth(prefixIcon, height) +
        _maxWidth(prefix, height) +
        math.max(_maxWidth(input, height), _maxWidth(hint, height)) +
        _maxWidth(suffix, height) +
        _maxWidth(suffixIcon, height) +
        // _maxWidth(errorIcon, height) +
        contentPadding.right;
  }

  double _lineHeight(double width, List<RenderBox?> boxes) {
    double height = 0.0;
    for (final RenderBox? box in boxes) {
      if (box == null) {
        continue;
      }
      height = math.max(_minHeight(box, width), height);
    }
    return height;
    // TODO(hansmuller): this should compute the overall line height for the
    // boxes when they've been baseline-aligned.
    // See https://github.com/flutter/flutter/issues/13715
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    final double iconHeight = _minHeight(icon, width);
    final double iconWidth = _minWidth(icon, iconHeight);

    width = math.max(width - iconWidth, 0.0);

    final double prefixIconHeight = _minHeight(prefixIcon, width);
    final double prefixIconWidth = _minWidth(prefixIcon, prefixIconHeight);

    final double suffixIconHeight = _minHeight(suffixIcon, width);
    final double suffixIconWidth = _minWidth(suffixIcon, suffixIconHeight);

    // final double errorIconHeight = _minHeight(errorIcon, width);
    // final double errorIconWidth = _minWidth(errorIcon, errorIconHeight);

    width = math.max(width - contentPadding.horizontal, 0.0);

    final double counterHeight = _minHeight(counter, width);
    final double counterWidth = _minWidth(counter, counterHeight);

    final double helperErrorAvailableWidth =
        math.max(width - counterWidth, 0.0);
    final double helperErrorHeight =
        _minHeight(helperError, helperErrorAvailableWidth);
    double subtextHeight = math.max(counterHeight, helperErrorHeight);
    if (subtextHeight > 0.0) {
      subtextHeight += subtextGap;
    }

    final double prefixHeight = _minHeight(prefix, width);
    final double prefixWidth = _minWidth(prefix, prefixHeight);

    final double suffixHeight = _minHeight(suffix, width);
    final double suffixWidth = _minWidth(suffix, suffixHeight);

    final double availableInputWidth = math.max(
        width - prefixWidth - suffixWidth - prefixIconWidth - suffixIconWidth,
        // errorIconWidth,
        0.0);
    final double inputHeight =
        _lineHeight(availableInputWidth, <RenderBox?>[input, hint]);
    final double inputMaxHeight =
        <double>[inputHeight, prefixHeight, suffixHeight].reduce(math.max);

    final Offset densityOffset = decoration.visualDensity.baseSizeAdjustment;
    final double contentHeight = contentPadding.top +
        (label == null ? 0.0 : decoration.floatingLabelHeight) +
        inputMaxHeight +
        contentPadding.bottom +
        densityOffset.dy;
    final double containerHeight = <double>[
      iconHeight,
      contentHeight,
      prefixIconHeight,
      suffixIconHeight,
      // errorIconWidth
    ].reduce(math.max);
    final double minContainerHeight =
        decoration.isDense! || expands ? 0.0 : kMinInteractiveDimension;
    return math.max(containerHeight, minContainerHeight) + subtextHeight;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return computeMinIntrinsicHeight(width);
  }

  @override
  double computeDistanceToActualBaseline(TextBaseline baseline) {
    return _boxParentData(input!).offset.dy +
        (input?.computeDistanceToActualBaseline(baseline) ?? 0.0);
  }

  // Records where the label was painted.
  Matrix4? _labelTransform;

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    assert(debugCannotComputeDryLayout(
      reason:
          'Layout requires baseline metrics, which are only available after a full layout.',
    ));
    return Size.zero;
  }

  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;
    _labelTransform = null;
    final _RenderDecorationLayout layout = _layout(constraints);

    final double overallWidth = constraints.maxWidth;
    final double overallHeight = layout.containerHeight + layout.subtextHeight;

    final RenderBox? container = this.container;
    if (container != null) {
      final BoxConstraints containerConstraints = BoxConstraints.tightFor(
        height: layout.containerHeight,
        width: overallWidth - _boxSize(icon).width,
      );
      container.layout(containerConstraints, parentUsesSize: true);
      final double x;
      switch (textDirection) {
        case TextDirection.rtl:
          x = 0.0;
          break;
        case TextDirection.ltr:
          x = _boxSize(icon).width;
          break;
      }
      _boxParentData(container).offset = Offset(x, 0.0);
    }

    late double height;
    double centerLayout(RenderBox box, double x) {
      _boxParentData(box).offset = Offset(x, (height - box.size.height) / 2.0);
      return box.size.width;
    }

    late double baseline;
    double baselineLayout(RenderBox box, double x) {
      _boxParentData(box).offset =
          Offset(x, baseline - layout.boxToBaseline[box]!);
      return box.size.width;
    }

    final double left = contentPadding.left;
    final double right = overallWidth - contentPadding.right;

    height = layout.containerHeight;
    baseline =
        _isOutlineAligned ? layout.outlineBaseline : layout.inputBaseline;

    if (icon != null) {
      final double x;
      switch (textDirection) {
        case TextDirection.rtl:
          x = overallWidth - icon!.size.width;
          break;
        case TextDirection.ltr:
          x = 0.0;
          break;
      }
      centerLayout(icon!, x);
    }

    switch (textDirection) {
      case TextDirection.rtl:
        {
          double start = right - _boxSize(icon).width;
          double end = left;
          if (prefixIcon != null) {
            start += contentPadding.left;
            start -= centerLayout(prefixIcon!, start - prefixIcon!.size.width);
          }
          if (label != null) {
            if (decoration.alignLabelWithHint) {
              baselineLayout(label!, start - label!.size.width);
            } else {
              centerLayout(label!, start - label!.size.width);
            }
          }
          if (prefix != null) {
            start -= baselineLayout(prefix!, start - prefix!.size.width);
          }
          if (input != null) {
            baselineLayout(input!, start - input!.size.width);
          }
          if (hint != null) {
            baselineLayout(hint!, start - hint!.size.width);
          }
          if (suffixIcon != null) {
            end -= contentPadding.left;
            end += centerLayout(suffixIcon!, end);
          }
          if (errorIcon != null) {
            //   end -= contentPadding.left;
            end += centerLayout(errorIcon!, end);
          }
          if (suffix != null) {
            end += baselineLayout(suffix!, end);
          }
          break;
        }
      case TextDirection.ltr:
        bool adaPrefixIcon = decoration.prefixIcon != null;
        {
          double start = left + _boxSize(icon).width;
          double end = right;
          if (prefixIcon != null) {
            start -= contentPadding.left;
            start += centerLayout(prefixIcon!, start);
          }
          if (label != null) {
            if (decoration.alignLabelWithHint) {
              baselineLayout(label!, start);
            } else {
              // centerLayout(label!, start);
              // baselineLayout(label!, start - label!.size.width);
              baselineLayout(label!,
                  (adaPrefixIcon ? start - prefix!.size.width - 13 : start));
            }
          }
          if (prefix != null) {
            start += baselineLayout(prefix!, start);
          }
          if (input != null) {
            baselineLayout(input!, start);
          }
          if (hint != null) {
            baselineLayout(hint!, start);
          }
          if (errorIcon != null) {
            // end += contentPadding.right;
            end -= centerLayout(errorIcon!, end - errorIcon!.size.width);
          }
          if (suffixIcon != null) {
            end += contentPadding.right;
            end -= centerLayout(suffixIcon!, end - suffixIcon!.size.width);
            // start += baselineLayout(suffix!, start);
          }

          if (suffix != null) {
            end -= baselineLayout(suffix!, end - suffix!.size.width);
          }

          break;
        }
    }

    if (helperError != null || counter != null) {
      height = layout.subtextHeight;
      baseline = layout.subtextBaseline;

      switch (textDirection) {
        case TextDirection.rtl:
          if (helperError != null) {
            baselineLayout(helperError!,
                right - helperError!.size.width - _boxSize(icon).width);
          }
          if (counter != null) {
            baselineLayout(counter!, left);
          }
          break;
        case TextDirection.ltr:
          if (helperError != null) {
            baselineLayout(helperError!, left + _boxSize(icon).width);
          }
          if (counter != null) {
            baselineLayout(counter!, right - counter!.size.width);
          }
          break;
      }
    }

    if (label != null) {
      final double labelX = _boxParentData(label!).offset.dx;
      // +1 shifts the range of x from (-1.0, 1.0) to (0.0, 2.0).
      final double floatAlign = decoration.floatingLabelAlignment._x + 1;
      final double floatWidth = _boxSize(label).width * _kFinalLabelScale;
      // When floating label is centered, its x is relative to
      // _BorderContainer's x and is independent of label's x.
      switch (textDirection) {
        case TextDirection.rtl:
          double offsetToPrefixIcon = 0.0;
          if (prefixIcon != null && !decoration.alignLabelWithHint) {
            offsetToPrefixIcon =
                material3 ? _boxSize(prefixIcon).width - left : 0;
          }
          decoration.borderGap.start = ui.lerpDouble(
              labelX + _boxSize(label).width + offsetToPrefixIcon,
              _boxSize(container).width / 2.0 + floatWidth / 2.0,
              floatAlign);

          break;
        case TextDirection.ltr:
          // The value of _InputBorderGap.start is relative to the origin of the
          // _BorderContainer which is inset by the icon's width. Although, when
          // floating label is centered, it's already relative to _BorderContainer.
          double offsetToPrefixIcon = 0.0;
          if (prefixIcon != null && !decoration.alignLabelWithHint) {
            offsetToPrefixIcon =
                material3 ? (-_boxSize(prefixIcon).width + left) : 0;
          }
          decoration.borderGap.start = ui.lerpDouble(
              labelX - _boxSize(icon).width + offsetToPrefixIcon,
              _boxSize(container).width / 2.0 - floatWidth / 2.0,
              floatAlign);
          break;
      }
      decoration.borderGap.extent = label!.size.width * _kFinalLabelScale;
    } else {
      decoration.borderGap.start = null;
      decoration.borderGap.extent = 0.0;
    }

    size = constraints.constrain(Size(overallWidth, overallHeight));
    assert(size.width == constraints.constrainWidth(overallWidth));
    assert(size.height == constraints.constrainHeight(overallHeight));
  }

  void _paintLabel(PaintingContext context, Offset offset) {
    context.paintChild(label!, offset);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    void doPaint(RenderBox? child) {
      if (child != null) {
        context.paintChild(child, _boxParentData(child).offset + offset);
      }
    }

    doPaint(container);

    if (label != null) {
      final Offset labelOffset = _boxParentData(label!).offset;
      final double labelHeight = _boxSize(label).height;
      final double labelWidth = _boxSize(label).width;
      // +1 shifts the range of x from (-1.0, 1.0) to (0.0, 2.0).
      final double floatAlign = decoration.floatingLabelAlignment._x + 1;
      final double floatWidth = labelWidth * _kFinalLabelScale;
      final double borderWeight = decoration.border.borderSide.width;
      final double t = decoration.floatingLabelProgress;
      // The center of the outline border label ends up a little below the
      // center of the top border line.
      final bool isOutlineBorder =
          decoration.border != null && decoration.border.isOutline;
      // Temporary opt-in fix for https://github.com/flutter/flutter/issues/54028
      // Center the scaled label relative to the border.
      final double floatingY = isOutlineBorder
          // ? (-labelHeight * _kFinalLabelScale) / 1.0 + borderWeight / 2.0
          /// POSISI LABEL DI NAIKIN
          ? ((-labelHeight - 8) * _kFinalLabelScale) + borderWeight
          : contentPadding.top;

      final double scale = ui.lerpDouble(1.0, _kFinalLabelScale, t)!;
      final double centeredFloatX = _boxParentData(container!).offset.dx +
          _boxSize(container).width / 2.0 -
          floatWidth / 2.0;
      final double startX;
      double floatStartX;
      switch (textDirection) {
        case TextDirection.rtl: // origin is on the right
          startX = labelOffset.dx + labelWidth * (1.0 - scale);
          floatStartX = startX;
          if (prefixIcon != null &&
              !decoration.alignLabelWithHint &&
              isOutlineBorder) {
            floatStartX += material3
                ? _boxSize(prefixIcon).width - contentPadding.left
                : 0.0;
          }
          break;
        case TextDirection.ltr: // origin on the left
          startX = labelOffset.dx;
          floatStartX = startX;
          if (prefixIcon != null &&
              !decoration.alignLabelWithHint &&
              isOutlineBorder) {
            floatStartX += material3
                ? -_boxSize(prefixIcon).width + contentPadding.left
                : 0.0;
          }
          break;
      }
      final double floatEndX =
          ui.lerpDouble(floatStartX, centeredFloatX, floatAlign)!;
      final double dx = ui.lerpDouble(startX, floatEndX, t)!;
      final double dy = ui.lerpDouble(0.0, floatingY - labelOffset.dy, t)!;
      _labelTransform = Matrix4.identity()
        ..translate(dx, labelOffset.dy + dy)
        ..scale(scale);
      layer = context.pushTransform(
        needsCompositing,
        offset,
        _labelTransform!,
        _paintLabel,
        oldLayer: layer as TransformLayer?,
      );
    } else {
      layer = null;
    }

    doPaint(icon);
    doPaint(prefix);
    doPaint(suffix);
    doPaint(prefixIcon);
    doPaint(suffixIcon);
    doPaint(errorIcon);
    doPaint(hint);
    doPaint(input);
    doPaint(helperError);
    doPaint(counter);
  }

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    assert(position != null);
    for (final RenderBox child in children) {
      // The label must be handled specially since we've transformed it.
      final Offset offset = _boxParentData(child).offset;
      final bool isHit = result.addWithPaintOffset(
        offset: offset,
        position: position,
        hitTest: (BoxHitTestResult result, Offset transformed) {
          assert(transformed == position - offset);
          return child.hitTest(result, position: transformed);
        },
      );
      if (isHit) {
        return true;
      }
    }
    return false;
  }

  @override
  void applyPaintTransform(RenderObject child, Matrix4 transform) {
    if (child == label && _labelTransform != null) {
      final Offset labelOffset = _boxParentData(label!).offset;
      transform
        ..multiply(_labelTransform!)
        ..translate(-labelOffset.dx, -labelOffset.dy);
    }
    super.applyPaintTransform(child, transform);
  }
}

class _AffixText extends StatelessWidget {
  const _AffixText({
    required this.labelIsFloating,
    this.text,
    this.style,
    this.child,
  });

  final bool labelIsFloating;
  final String? text;
  final TextStyle? style;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: style,
      child: AnimatedOpacity(
        // duration: _kTransitionDuration,
        duration: const Duration(milliseconds: 200),
        // curve: _kTransitionCurve,
        curve: Curves.fastOutSlowIn,
        opacity: labelIsFloating ? 1.0 : 0.0,
        child: child ?? (text == null ? null : Text(text!, style: style)),
      ),
    );
  }
}

class _RenderDecorationLayout {
  const _RenderDecorationLayout({
    required this.boxToBaseline,
    required this.inputBaseline, // for InputBorderType.underline
    required this.outlineBaseline, // for InputBorderType.outline
    required this.subtextBaseline,
    required this.containerHeight,
    required this.subtextHeight,
  });

  final Map<RenderBox?, double> boxToBaseline;
  final double inputBaseline;
  final double outlineBaseline;
  final double subtextBaseline; // helper/error counter
  final double containerHeight;
  final double subtextHeight;
}

@immutable
class FloatingLabelAlignment {
  const FloatingLabelAlignment._(this._x)
      : assert(_x != null),
        assert(_x >= -1.0 && _x <= 1.0);

  // -1 denotes start, 0 denotes center, and 1 denotes end.
  final double _x;

  /// Align the floating label on the leading edge of the [InputDecorator].
  ///
  /// For left-to-right text ([TextDirection.ltr]), this is the left edge.
  ///
  /// For right-to-left text ([TextDirection.rtl]), this is the right edge.
  static const FloatingLabelAlignment start = FloatingLabelAlignment._(-1.0);

  /// Aligns the floating label to the center of an [InputDecorator].
  static const FloatingLabelAlignment center = FloatingLabelAlignment._(0.0);

  @override
  int get hashCode => _x.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is FloatingLabelAlignment && _x == other._x;
  }

  static String _stringify(double x) {
    if (x == -1.0) {
      return 'FloatingLabelAlignment.start';
    }
    if (x == 0.0) {
      return 'FloatingLabelAlignment.center';
    }
    return 'FloatingLabelAlignment(x: ${x.toStringAsFixed(1)})';
  }

  @override
  String toString() => _stringify(_x);
}

enum _DecorationSlot {
  icon,
  input,
  label,
  hint,
  prefix,
  suffix,
  prefixIcon,
  suffixIcon,
  errorIcon,
  helperError,
  counter,
  container,
}

@immutable
class _Decoration {
  _Decoration({
    required this.contentPadding,
    required this.isCollapsed,
    required this.floatingLabelHeight,
    required this.floatingLabelProgress,
    required this.floatingLabelAlignment,
    required this.border,
    required this.borderGap,
    required this.alignLabelWithHint,
    required this.isDense,
    required this.visualDensity,
    this.icon,
    this.input,
    this.label,
    this.hint,
    this.prefix,
    this.suffix,
    this.prefixIcon,
    this.suffixIcon,
    this.errorIcon,
    this.helperError,
    this.counter,
    this.container,
  })
  // : assert(contentPadding != null),
  //       assert(isCollapsed != null),
  //       assert(floatingLabelHeight != null),
  //       assert(floatingLabelProgress != null),
  //       assert(floatingLabelAlignment != null);
  ;

  final EdgeInsetsGeometry contentPadding;
  final bool isCollapsed;
  final double floatingLabelHeight;
  final double floatingLabelProgress;
  final FloatingLabelAlignment floatingLabelAlignment;
  final InputBorder border;
  final _InputBorderGap borderGap;
  final bool alignLabelWithHint;
  final bool? isDense;
  final VisualDensity visualDensity;
  final Widget? icon;
  final Widget? input;
  final Widget? label;
  final Widget? hint;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  // Widget errorIcon = const Icon(Icons.info_outline);
  Widget? errorIcon = const Icon(Icons.info_outline);
  final Widget? helperError;
  final Widget? counter;
  final Widget? container;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is _Decoration &&
        other.contentPadding == contentPadding &&
        other.isCollapsed == isCollapsed &&
        other.floatingLabelHeight == floatingLabelHeight &&
        other.floatingLabelProgress == floatingLabelProgress &&
        other.floatingLabelAlignment == floatingLabelAlignment &&
        other.border == border &&
        other.borderGap == borderGap &&
        other.alignLabelWithHint == alignLabelWithHint &&
        other.isDense == isDense &&
        other.visualDensity == visualDensity &&
        other.icon == icon &&
        other.input == input &&
        other.label == label &&
        other.hint == hint &&
        other.prefix == prefix &&
        other.suffix == suffix &&
        other.prefixIcon == prefixIcon &&
        other.suffixIcon == suffixIcon &&
        other.errorIcon == errorIcon &&
        other.helperError == helperError &&
        other.counter == counter &&
        other.container == container;
  }

  @override
  int get hashCode => Object.hash(
        contentPadding,
        floatingLabelHeight,
        floatingLabelProgress,
        floatingLabelAlignment,
        border,
        borderGap,
        alignLabelWithHint,
        isDense,
        visualDensity,
        icon,
        input,
        label,
        hint,
        prefix,
        suffix,
        prefixIcon,
        suffixIcon,
        // errorIcon,
        helperError,
        counter,
        container,
      );
}

class _InputBorderGap extends ChangeNotifier {
  double? _start;
  double? get start => _start;
  set start(double? value) {
    if (value != _start) {
      _start = value;
      notifyListeners();
    }
  }

  double _extent = 0.0;
  double get extent => _extent;
  set extent(double value) {
    if (value != _extent) {
      _extent = value;
      notifyListeners();
    }
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes, this class is not used in collection
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is _InputBorderGap &&
        other.start == start &&
        other.extent == extent;
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes, this class is not used in collection
  int get hashCode => Object.hash(start, extent);

  @override
  String toString() => describeIdentity(this);
}

class _HelperError extends StatefulWidget {
  const _HelperError({
    this.textAlign,
    this.helperText,
    this.helperStyle,
    this.helperMaxLines,
    this.errorText,
    this.errorStyle,
    this.errorMaxLines,
  });

  final TextAlign? textAlign;
  final String? helperText;
  final TextStyle? helperStyle;
  final int? helperMaxLines;
  final String? errorText;
  final TextStyle? errorStyle;
  final int? errorMaxLines;

  @override
  _HelperErrorState createState() => _HelperErrorState();
}

class _HelperErrorState extends State<_HelperError>
    with SingleTickerProviderStateMixin {
  // If the height of this widget and the counter are zero ("empty") at
  // layout time, no space is allocated for the subtext.
  static const Widget empty = SizedBox.shrink();

  late AnimationController _controller;
  Widget? _helper;
  Widget? _error;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: _kTransitionDuration,
      vsync: this,
    );
    if (widget.errorText != null) {
      _error = _buildError();
      _controller.value = 1.0;
    } else if (widget.helperText != null) {
      _helper = _buildHelper();
    }
    _controller.addListener(_handleChange);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleChange() {
    setState(() {
      // The _controller's value has changed.
    });
  }

  @override
  void didUpdateWidget(_HelperError old) {
    super.didUpdateWidget(old);

    final String? newErrorText = widget.errorText;
    final String? newHelperText = widget.helperText;
    final String? oldErrorText = old.errorText;
    final String? oldHelperText = old.helperText;

    final bool errorTextStateChanged =
        (newErrorText != null) != (oldErrorText != null);
    final bool helperTextStateChanged = newErrorText == null &&
        (newHelperText != null) != (oldHelperText != null);

    if (errorTextStateChanged || helperTextStateChanged) {
      if (newErrorText != null) {
        _error = _buildError();
        _controller.forward();
      } else if (newHelperText != null) {
        _helper = _buildHelper();
        _controller.reverse();
      } else {
        _controller.reverse();
      }
    }
  }

  Widget _buildHelper() {
    assert(widget.helperText != null);
    return Semantics(
      container: true,
      child: FadeTransition(
        opacity: Tween<double>(begin: 1.0, end: 0.0).animate(_controller),
        child: Text(
          widget.helperText!,
          style: widget.helperStyle,
          textAlign: widget.textAlign,
          overflow: TextOverflow.ellipsis,
          maxLines: widget.helperMaxLines,
        ),
      ),
    );
  }

  Widget _buildError() {
    assert(widget.errorText != null);
    return Semantics(
      container: true,
      liveRegion: true,
      child: FadeTransition(
        opacity: _controller,
        child: FractionalTranslation(
          translation: Tween<Offset>(
            begin: const Offset(0.0, -0.25),
            end: Offset.zero,
          ).evaluate(_controller.view),
          child: Text(
            widget.errorText!,
            style: widget.errorStyle,
            textAlign: widget.textAlign,
            overflow: TextOverflow.ellipsis,
            maxLines: widget.errorMaxLines,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_controller.isDismissed) {
      _error = null;
      if (widget.helperText != null) {
        return _helper = _buildHelper();
      } else {
        _helper = null;
        return empty;
      }
    }

    if (_controller.isCompleted) {
      _helper = null;
      if (widget.errorText != null) {
        return _error = _buildError();
      } else {
        _error = null;
        return empty;
      }
    }

    if (_helper == null && widget.errorText != null) {
      return _buildError();
    }

    if (_error == null && widget.helperText != null) {
      return _buildHelper();
    }

    if (widget.errorText != null) {
      return Stack(
        children: <Widget>[
          FadeTransition(
            opacity: Tween<double>(begin: 1.0, end: 0.0).animate(_controller),
            child: _helper,
          ),
          _buildError(),
        ],
      );
    }

    if (widget.helperText != null) {
      return Stack(
        children: <Widget>[
          _buildHelper(),
          FadeTransition(
            opacity: _controller,
            child: _error,
          ),
        ],
      );
    }

    return empty;
  }
}

class _BorderContainer extends StatefulWidget {
  const _BorderContainer({
    required this.border,
    required this.gap,
    required this.gapAnimation,
    required this.fillColor,
    required this.hoverColor,
    required this.isHovering,
  })  : assert(border != null),
        assert(gap != null),
        assert(fillColor != null);

  final InputBorder border;
  final _InputBorderGap gap;
  final Animation<double> gapAnimation;
  final Color fillColor;
  final Color hoverColor;
  final bool isHovering;

  @override
  _BorderContainerState createState() => _BorderContainerState();
}

class _BorderContainerState extends State<_BorderContainer>
    with TickerProviderStateMixin {
  static const Duration _kHoverDuration = Duration(milliseconds: 15);

  late AnimationController _controller;
  late AnimationController _hoverColorController;
  late Animation<double> _borderAnimation;
  late _InputBorderTween _border;
  late Animation<double> _hoverAnimation;
  late ColorTween _hoverColorTween;

  @override
  void initState() {
    super.initState();
    _hoverColorController = AnimationController(
      duration: _kHoverDuration,
      value: widget.isHovering ? 1.0 : 0.0,
      vsync: this,
    );
    _controller = AnimationController(
      duration: _kTransitionDuration,
      vsync: this,
    );
    _borderAnimation = CurvedAnimation(
      parent: _controller,
      curve: _kTransitionCurve,
    );
    _border = _InputBorderTween(
      begin: widget.border,
      end: widget.border,
    );
    _hoverAnimation = CurvedAnimation(
      parent: _hoverColorController,
      curve: Curves.linear,
    );
    _hoverColorTween =
        ColorTween(begin: Colors.transparent, end: widget.hoverColor);
  }

  @override
  void dispose() {
    _controller.dispose();
    _hoverColorController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(_BorderContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.border != oldWidget.border) {
      _border = _InputBorderTween(
        begin: oldWidget.border,
        end: widget.border,
      );
      _controller
        ..value = 0.0
        ..forward();
    }
    if (widget.hoverColor != oldWidget.hoverColor) {
      _hoverColorTween =
          ColorTween(begin: Colors.transparent, end: widget.hoverColor);
    }
    if (widget.isHovering != oldWidget.isHovering) {
      if (widget.isHovering) {
        _hoverColorController.forward();
      } else {
        _hoverColorController.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: _InputBorderPainter(
        repaint: Listenable.merge(<Listenable>[
          _borderAnimation,
          widget.gap,
          _hoverColorController,
        ]),
        borderAnimation: _borderAnimation,
        border: _border,
        gapAnimation: widget.gapAnimation,
        gap: widget.gap,
        textDirection: Directionality.of(context),
        fillColor: widget.fillColor,
        hoverColorTween: _hoverColorTween,
        hoverAnimation: _hoverAnimation,
      ),
    );
  }
}

class _Shaker extends AnimatedWidget {
  const _Shaker({
    required Animation<double> animation,
    this.child,
  }) : super(listenable: animation);

  final Widget? child;

  Animation<double> get animation => listenable as Animation<double>;

  double get translateX {
    const double shakeDelta = 4.0;
    final double t = animation.value;
    if (t <= 0.25) {
      return -t * shakeDelta;
    } else if (t < 0.75) {
      return (t - 0.5) * shakeDelta;
    } else {
      return (1.0 - t) * 4.0 * shakeDelta;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.translationValues(translateX, 0.0, 0.0),
      child: child,
    );
  }
}

class _InputBorderTween extends Tween<InputBorder> {
  _InputBorderTween({super.begin, super.end});

  @override
  InputBorder lerp(double t) => ShapeBorder.lerp(begin, end, t)! as InputBorder;
}

class _InputBorderPainter extends CustomPainter {
  _InputBorderPainter({
    required Listenable repaint,
    required this.borderAnimation,
    required this.border,
    required this.gapAnimation,
    required this.gap,
    required this.textDirection,
    required this.fillColor,
    required this.hoverAnimation,
    required this.hoverColorTween,
  }) : super(repaint: repaint);

  final Animation<double> borderAnimation;
  final _InputBorderTween border;
  final Animation<double> gapAnimation;
  final _InputBorderGap gap;
  final TextDirection textDirection;
  final Color fillColor;
  final ColorTween hoverColorTween;
  final Animation<double> hoverAnimation;

  Color get blendedColor =>
      Color.alphaBlend(hoverColorTween.evaluate(hoverAnimation)!, fillColor);

  @override
  void paint(Canvas canvas, Size size) {
    final InputBorder borderValue = border.evaluate(borderAnimation);
    final Rect canvasRect = Offset.zero & size;
    final Color blendedFillColor = blendedColor;
    if (blendedFillColor.alpha > 0) {
      canvas.drawPath(
        borderValue.getOuterPath(canvasRect, textDirection: textDirection),
        Paint()
          ..color = blendedFillColor
          ..style = PaintingStyle.fill,
      );
    }

    borderValue.paint(
      canvas,
      canvasRect,
      gapStart: gap.start,

      ///gapExtent dimatikan agar tidak ada space di bawah label
      // gapExtent: gap.extent,
      gapPercentage: gapAnimation.value,
      textDirection: textDirection,
    );
  }

  @override
  bool shouldRepaint(_InputBorderPainter oldPainter) {
    return borderAnimation != oldPainter.borderAnimation ||
        hoverAnimation != oldPainter.hoverAnimation ||
        gapAnimation != oldPainter.gapAnimation ||
        border != oldPainter.border ||
        gap != oldPainter.gap ||
        textDirection != oldPainter.textDirection;
  }

  @override
  String toString() => describeIdentity(this);
}

class _InputDecoratorDefaultsM2 extends InputDecorationTheme {
  const _InputDecoratorDefaultsM2(this.context) : super();

  final BuildContext context;

  @override
  TextStyle? get hintStyle =>
      MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return TextStyle(color: Theme.of(context).disabledColor);
        }
        return TextStyle(color: Theme.of(context).hintColor);
      });

  @override
  TextStyle? get labelStyle =>
      MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return TextStyle(color: Theme.of(context).disabledColor);
        }
        return TextStyle(color: Theme.of(context).hintColor);
      });

  @override
  TextStyle? get floatingLabelStyle =>
      MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return TextStyle(color: Theme.of(context).disabledColor);
        }
        if (states.contains(MaterialState.error)) {
          return TextStyle(color: Theme.of(context).colorScheme.error);
        }
        if (states.contains(MaterialState.focused)) {
          return TextStyle(color: Theme.of(context).colorScheme.primary);
        }
        // return TextStyle(color: Theme.of(context).hintColor);
        return const TextStyle(color: adrColor.textNormal);
      });

  @override
  TextStyle? get helperStyle =>
      MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
        final ThemeData themeData = Theme.of(context);
        if (states.contains(MaterialState.disabled)) {
          return themeData.textTheme.bodySmall!
              .copyWith(color: Colors.transparent);
        }

        return themeData.textTheme.bodySmall!
            .copyWith(color: themeData.hintColor);
      });

  @override
  TextStyle? get errorStyle =>
      MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
        final ThemeData themeData = Theme.of(context);
        if (states.contains(MaterialState.disabled)) {
          return themeData.textTheme.bodySmall!
              .copyWith(color: Colors.transparent);
        }
        return themeData.textTheme.bodySmall!
            .copyWith(color: themeData.colorScheme.error);
      });

  @override
  Color? get fillColor =>
      MaterialStateColor.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          // dark theme: 5% white
          // light theme: 2% black
          switch (Theme.of(context).brightness) {
            case Brightness.dark:
              return const Color(0x0DFFFFFF);
            case Brightness.light:
              return const Color(0x05000000);
          }
        }
        // dark theme: 10% white
        // light theme: 4% black
        switch (Theme.of(context).brightness) {
          case Brightness.dark:
            return const Color(0x1AFFFFFF);
          case Brightness.light:
            return const Color(0x0A000000);
        }
      });

  @override
  Color? get iconColor =>
      MaterialStateColor.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled) &&
            !states.contains(MaterialState.focused)) {
          return Theme.of(context).disabledColor;
        }
        if (states.contains(MaterialState.focused)) {
          return Theme.of(context).colorScheme.primary;
        }
        switch (Theme.of(context).brightness) {
          case Brightness.dark:
            return Colors.white70;
          case Brightness.light:
            return Colors.black45;
        }
      });

  @override
  Color? get prefixIconColor =>
      MaterialStateColor.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled) &&
            !states.contains(MaterialState.focused)) {
          // return Theme.of(context).disabledColor;

          return adrColor.textNormal;
        }
        if (states.contains(MaterialState.focused)) {
          // return Theme.of(context).colorScheme.primary;
          return adrColor.backgroundBaseDark;
        }
        switch (Theme.of(context).brightness) {
          case Brightness.dark:
            return Colors.white70;
          case Brightness.light:
            // return Colors.black45;
            return adrColor.textNormal;
        }
      });

  @override
  Color? get suffixIconColor =>
      MaterialStateColor.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled) &&
            !states.contains(MaterialState.focused)) {
          // return Theme.of(context).disabledColor;
          return adrColor.textNormal;
        }
        if (states.contains(MaterialState.focused)) {
          // return Theme.of(context).colorScheme.primary;
          return adrColor.backgroundBaseDark;
        }
        switch (Theme.of(context).brightness) {
          case Brightness.dark:
            return Colors.white70;
          case Brightness.light:
            // return Colors.black45;
            return adrColor.textNormal;
        }
      });
}

// BEGIN GENERATED TOKEN PROPERTIES - InputDecorator

// Do not edit by hand. The code between the "BEGIN GENERATED" and
// "END GENERATED" comments are generated from data in the Material
// Design token database by the script:
//   dev/tools/gen_defaults/bin/gen_defaults.dart.

// Token database version: v0_143

class _InputDecoratorDefaultsM3 extends InputDecorationTheme {
  _InputDecoratorDefaultsM3(this.context) : super();

  final BuildContext context;

  late final ColorScheme _colors = Theme.of(context).colorScheme;
  late final TextTheme _textTheme = Theme.of(context).textTheme;

  @override
  TextStyle? get hintStyle =>
      MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return TextStyle(color: Theme.of(context).disabledColor);
        }
        return TextStyle(color: Theme.of(context).hintColor);
      });

  @override
  Color? get fillColor =>
      MaterialStateColor.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return _colors.onSurface.withOpacity(0.04);
        }
        return _colors.surfaceVariant;
      });

  @override
  BorderSide? get activeIndicatorBorder =>
      MaterialStateBorderSide.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.error)) {
          if (states.contains(MaterialState.focused)) {
            return BorderSide(color: _colors.error, width: 2.0);
          }
          if (states.contains(MaterialState.hovered)) {
            return BorderSide(color: _colors.onErrorContainer);
          }
          return BorderSide(color: _colors.error);
        }
        if (states.contains(MaterialState.focused)) {
          // return BorderSide(color: _colors.primary, width: 2.0);
          return const BorderSide(
              color: adrColor.backgroundButtonPrimaryHover, width: 2.0);
        }
        if (states.contains(MaterialState.hovered)) {
          return BorderSide(color: _colors.onSurface);
        }
        if (states.contains(MaterialState.disabled)) {
          return BorderSide(color: _colors.onSurface.withOpacity(0.38));
        }
        return BorderSide(color: _colors.onSurfaceVariant);
      });

  @override
  BorderSide? get outlineBorder =>
      MaterialStateBorderSide.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.error)) {
          if (states.contains(MaterialState.focused)) {
            return BorderSide(color: _colors.error, width: 2.0);
          }
          if (states.contains(MaterialState.hovered)) {
            return BorderSide(color: _colors.onErrorContainer);
          }
          return BorderSide(color: _colors.error);
        }
        if (states.contains(MaterialState.focused)) {
          // return BorderSide(color: _colors.primary, width: 2.0);
          return const BorderSide(
              color: adrColor.backgroundButtonPrimaryHover, width: 2.0);
        }
        if (states.contains(MaterialState.hovered)) {
          return BorderSide(color: _colors.onSurface);
        }
        if (states.contains(MaterialState.disabled)) {
          return BorderSide(color: _colors.onSurface.withOpacity(0.12));
        }
        return BorderSide(color: _colors.outline);
      });

  @override
  Color? get iconColor => _colors.onSurfaceVariant;

  @override
  Color? get prefixIconColor =>
      MaterialStateColor.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return _colors.onSurface.withOpacity(0.38);
        }
        return _colors.onSurfaceVariant;
      });

  @override
  Color? get suffixIconColor =>
      MaterialStateColor.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.error)) {
          if (states.contains(MaterialState.hovered)) {
            return _colors.onErrorContainer;
          }
          return _colors.error;
        }
        if (states.contains(MaterialState.disabled)) {
          return _colors.onSurface.withOpacity(0.38);
        }
        return _colors.onSurfaceVariant;
      });

  @override
  TextStyle? get labelStyle =>
      MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
        final TextStyle textStyle = _textTheme.bodyLarge ?? const TextStyle();
        if (states.contains(MaterialState.error)) {
          if (states.contains(MaterialState.focused)) {
            return textStyle.copyWith(color: _colors.error);
          }
          if (states.contains(MaterialState.hovered)) {
            return textStyle.copyWith(color: _colors.onErrorContainer);
          }
          return textStyle.copyWith(color: _colors.error);
        }
        if (states.contains(MaterialState.focused)) {
          return textStyle.copyWith(color: _colors.primary);
        }
        if (states.contains(MaterialState.hovered)) {
          return textStyle.copyWith(color: _colors.onSurfaceVariant);
        }
        if (states.contains(MaterialState.disabled)) {
          return textStyle.copyWith(color: _colors.onSurface.withOpacity(0.38));
        }
        return textStyle.copyWith(color: _colors.onSurfaceVariant);
      });

  @override
  TextStyle? get floatingLabelStyle =>
      MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
        final TextStyle textStyle = _textTheme.bodyLarge ?? const TextStyle();
        if (states.contains(MaterialState.error)) {
          if (states.contains(MaterialState.focused)) {
            return textStyle.copyWith(color: _colors.error);
          }
          if (states.contains(MaterialState.hovered)) {
            return textStyle.copyWith(color: _colors.onErrorContainer);
          }
          return textStyle.copyWith(color: _colors.error);
        }
        if (states.contains(MaterialState.focused)) {
          return textStyle.copyWith(color: _colors.primary);
        }
        if (states.contains(MaterialState.hovered)) {
          return textStyle.copyWith(color: _colors.onSurfaceVariant);
        }
        if (states.contains(MaterialState.disabled)) {
          return textStyle.copyWith(color: _colors.onSurface.withOpacity(0.38));
        }
        // return textStyle.copyWith(color: _colors.onSurfaceVariant);
        return textStyle.copyWith(color: adrColor.textNormal);
      });

  @override
  TextStyle? get helperStyle =>
      MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
        final TextStyle textStyle = _textTheme.bodySmall ?? const TextStyle();
        if (states.contains(MaterialState.disabled)) {
          return textStyle.copyWith(color: _colors.onSurface.withOpacity(0.38));
        }
        return textStyle.copyWith(color: _colors.onSurfaceVariant);
      });

  @override
  TextStyle? get errorStyle =>
      MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
        final TextStyle textStyle = _textTheme.bodySmall ?? const TextStyle();
        return textStyle.copyWith(color: _colors.error);
      });
}

// END GENERATED TOKEN PROPERTIES - InputDecorator
