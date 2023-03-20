import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import '../../dart/dart_color.dart';
import '../../dart/dart_font.dart';

// import 'package:latihan_text_field/tokens/dart/dart_color.dart';
// import 'package:latihan_text_field/tokens/dart/dart_font.dart';
// import 'ad_input_decorator.dart' as adInDecor;

import 'ad_text_field.dart' as aether;

export 'package:flutter/services.dart' show SmartDashesType, SmartQuotesType;

class AdTextFormField extends FormField<String> {
  AdTextFormField({
    super.key,
    this.controller,
    String? initialValue,
    FocusNode? focusNode,
    InputDecoration? decoration = const InputDecoration(),
    // adInDecor.InputDecoration? decoration = const adInDecor.InputDecoration(),
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction? textInputAction,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical? textAlignVertical,
    bool autofocus = false,
    bool readOnly = false,
    @Deprecated(
      'Use `contextMenuBuilder` instead. '
      'This feature was deprecated after v3.3.0-0.5.pre.',
    )
        ToolbarOptions? toolbarOptions,
    bool? showCursor,
    String obscuringCharacter = '•',
    bool obscureText = false,
    bool autocorrect = true,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    bool enableSuggestions = true,
    MaxLengthEnforcement? maxLengthEnforcement,
    int? maxLines = 1,
    int? minLines,
    bool expands = false,
    int? maxLength,
    ValueChanged<String>? onChanged,
    GestureTapCallback? onTap,
    TapRegionCallback? onTapOutside,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onFieldSubmitted,
    super.onSaved,
    super.validator,
    List<TextInputFormatter>? inputFormatters,
    bool? enabled,
    double cursorWidth = 2.0,
    double? cursorHeight,
    Radius? cursorRadius,
    Color? cursorColor,
    Brightness? keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool? enableInteractiveSelection,
    TextSelectionControls? selectionControls,
    InputCounterWidgetBuilder? buildCounter,
    ScrollPhysics? scrollPhysics,
    Iterable<String>? autofillHints,
    AutovalidateMode? autovalidateMode,
    ScrollController? scrollController,
    super.restorationId,
    bool enableIMEPersonalizedLearning = true,
    MouseCursor? mouseCursor,
    EditableTextContextMenuBuilder? contextMenuBuilder =
        _defaultContextMenuBuilder,
  })  : assert(initialValue == null || controller == null),
        assert(textAlign != null),
        assert(autofocus != null),
        assert(readOnly != null),
        assert(obscuringCharacter != null && obscuringCharacter.length == 1),
        assert(obscureText != null),
        assert(autocorrect != null),
        assert(enableSuggestions != null),
        assert(scrollPadding != null),
        assert(maxLines == null || maxLines > 0),
        assert(minLines == null || minLines > 0),
        assert(
          (maxLines == null) || (minLines == null) || (maxLines >= minLines),
          "minLines can't be greater than maxLines",
        ),
        assert(expands != null),
        assert(
          !expands || (maxLines == null && minLines == null),
          'minLines and maxLines must be null when expands is true.',
        ),
        assert(!obscureText || maxLines == 1,
            'Obscured fields cannot be multiline.'),
        assert(maxLength == null ||
            maxLength == TextField.noMaxLength ||
            maxLength > 0),
        assert(enableIMEPersonalizedLearning != null),
        super(
          initialValue:
              controller != null ? controller.text : (initialValue ?? ''),
          enabled: enabled ?? decoration?.enabled ?? true,
          autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
          builder: (FormFieldState<String> field) {
            final _TextFormFieldState state = field as _TextFormFieldState;
            // final adInDecor.InputDecoration effectiveDecoration = (decoration ??
            //         const adInDecor.InputDecoration())
            //     .applyDefaults(Theme.of(field.context).inputDecorationTheme);
            final InputDecoration effectiveDecoration = (decoration ??
                    const InputDecoration())
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);
            // .applyDefaults(Theme.of(field.context).inputDecorationTheme);
            void onChangedHandler(String value) {
              field.didChange(value);
              if (onChanged != null) {
                onChanged(value);
              }
            }

            final bool adaLabel =
                decoration?.label != null || decoration?.labelText != null;
            final bool fieldEnabled = enabled != false;

            return UnmanagedRestorationScope(
              bucket: field.bucket,
              child: Padding(
                // padding: const EdgeInsets.only(top: 20.0),
                padding: adaLabel
                    ? const EdgeInsets.only(top: 20)
                    : const EdgeInsets.all(0),
                child: aether.AdTextField(
                  restorationId: restorationId,
                  controller: state._effectiveController,
                  focusNode: focusNode,
                  decoration: effectiveDecoration.copyWith(
                      errorText: field.errorText,
                      hintStyle: TextStyle(
                          color: fieldEnabled
                              ? effectiveDecoration.hintStyle?.color
                              : adrColor.textDisable),
                      filled: fieldEnabled ? effectiveDecoration.filled : true,
                      fillColor: fieldEnabled
                          ? effectiveDecoration.fillColor
                          : adrColor.backgroundBaseGrey,
                      labelStyle: const TextStyle(
                        color: adrColor.textNormal,
                        fontWeight: adrFont.weightSemibold,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 10),
                      // contentPadding: const EdgeInsets.symmetric(
                      //     horizontal: 16, vertical: 10),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: adrColor.backgroundButtonPrimaryActive,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      disabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: adrColor.borderBase,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: adrColor.borderBase),
                          borderRadius: BorderRadius.all(Radius.circular(8)))),
                  keyboardType: keyboardType,
                  textInputAction: textInputAction,
                  style: style,
                  strutStyle: strutStyle,
                  textAlign: textAlign,
                  textAlignVertical: textAlignVertical,
                  textDirection: textDirection,
                  textCapitalization: textCapitalization,
                  autofocus: autofocus,
                  toolbarOptions: toolbarOptions,
                  readOnly: readOnly,
                  showCursor: showCursor,
                  obscuringCharacter: obscuringCharacter,
                  obscureText: obscureText,
                  autocorrect: autocorrect,
                  smartDashesType: smartDashesType ??
                      (obscureText
                          ? SmartDashesType.disabled
                          : SmartDashesType.enabled),
                  smartQuotesType: smartQuotesType ??
                      (obscureText
                          ? SmartQuotesType.disabled
                          : SmartQuotesType.enabled),
                  enableSuggestions: enableSuggestions,
                  maxLengthEnforcement: maxLengthEnforcement,
                  maxLines: maxLines,
                  minLines: minLines,
                  expands: expands,
                  maxLength: maxLength,
                  onChanged: onChangedHandler,
                  onTap: onTap,
                  onTapOutside: onTapOutside,
                  onEditingComplete: onEditingComplete,
                  onSubmitted: onFieldSubmitted,
                  inputFormatters: inputFormatters,
                  enabled: enabled ?? decoration?.enabled ?? true,
                  cursorWidth: cursorWidth,
                  cursorHeight: cursorHeight,
                  cursorRadius: cursorRadius,
                  cursorColor: cursorColor,
                  scrollPadding: scrollPadding,
                  scrollPhysics: scrollPhysics,
                  keyboardAppearance: keyboardAppearance,
                  enableInteractiveSelection:
                      enableInteractiveSelection ?? (!obscureText || !readOnly),
                  selectionControls: selectionControls,
                  buildCounter: buildCounter,
                  autofillHints: autofillHints,
                  scrollController: scrollController,
                  enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
                  mouseCursor: mouseCursor,
                  contextMenuBuilder: contextMenuBuilder,
                ),
              ),
            );
          },
        );

  final TextEditingController? controller;

  static Widget _defaultContextMenuBuilder(
      BuildContext context, EditableTextState editableTextState) {
    return AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState,
    );
  }

  @override
  FormFieldState<String> createState() => _TextFormFieldState();
}

class _TextFormFieldState extends FormFieldState<String> {
  RestorableTextEditingController? _controller;

  TextEditingController get _effectiveController =>
      _textFormField.controller ?? _controller!.value;

  AdTextFormField get _textFormField => super.widget as AdTextFormField;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(oldBucket, initialRestore);
    if (_controller != null) {
      _registerController();
    }
    setValue(_effectiveController.text);
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
  void initState() {
    super.initState();
    if (_textFormField.controller == null) {
      _createLocalController(widget.initialValue != null
          ? TextEditingValue(text: widget.initialValue!)
          : null);
    } else {
      _textFormField.controller!.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(AdTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_textFormField.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      _textFormField.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && _textFormField.controller == null) {
        _createLocalController(oldWidget.controller!.value);
      }

      if (_textFormField.controller != null) {
        setValue(_textFormField.controller!.text);
        if (oldWidget.controller == null) {
          unregisterFromRestoration(_controller!);
          _controller!.dispose();
          _controller = null;
        }
      }
    }
  }

  @override
  void dispose() {
    _textFormField.controller?.removeListener(_handleControllerChanged);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChange(String? value) {
    super.didChange(value);

    if (_effectiveController.text != value) {
      _effectiveController.text = value ?? '';
    }
  }

  @override
  void reset() {
    // setState will be called in the superclass, so even though state is being
    // manipulated, no setState call is needed here.
    _effectiveController.text = widget.initialValue ?? '';
    super.reset();
  }

  void _handleControllerChanged() {
    // Suppress changes that originated from within this class.
    //
    // In the case where a controller has been passed in to this widget, we
    // register this change listener. In these cases, we'll also receive change
    // notifications for changes originating from within this class -- for
    // example, the reset() method. In such cases, the FormField value will
    // already have been set.
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    }
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter/src/widgets/restoration.dart';
// import 'ad_text_field.dart';

// class AdTextFromField extends FormField<String> {
//   AdTextFromField({
//     super.key,
//     this.controller,
//     String? initialValue,
//     FocusNode? focusNode,
//     InputDecoration? decoration = const InputDecoration(),
//     TextInputType? keyboardType,
//     TextCapitalization textCapitalization = TextCapitalization.none,
//     TextInputAction? textInputAction,
//     TextStyle? style,
//     StrutStyle? strutStyle,
//     TextDirection? textDirection,
//     TextAlign textAlign = TextAlign.start,
//     TextAlignVertical? textAlignVertical,
//     bool autofocus = false,
//     bool readOnly = false,
//     ToolbarOptions? toolbarOptions,
//     bool? showCursor,
//     String obscuringCharacter = '•',
//     bool obscureText = false,
//     bool autocorrect = true,
//     SmartDashesType? smartDashesType,
//     SmartQuotesType? smartQuotesType,
//     bool enableSuggestions = true,
//     MaxLengthEnforcement? maxLengthEnforcement,
//     int? maxLines = 1,
//     int? minLines,
//     bool expands = false,
//     int? maxLength,
//     ValueChanged<String>? onChanged,
//     GestureTapCallback? onTap,
//     TapRegionCallback? onTapOutside,
//     VoidCallback? onEditingComplete,
//     ValueChanged<String>? onFieldSubmitted,
//     super.onSaved,
//     super.validator,
//     List<TextInputFormatter>? inputFormatters,
//     bool? enabled,
//     double cursorWidth = 2.0,
//     double? cursorHeight,
//     Radius? cursorRadius,
//     Color? cursorColor,
//     Brightness? keyboardAppearance,
//     EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
//     bool? enableInteractiveSelection,
//     TextSelectionControls? selectionControls,
//     InputCounterWidgetBuilder? buildCounter,
//     ScrollPhysics? scrollPhysics,
//     Iterable<String>? autofillHints,
//     AutovalidateMode? autovalidateMode,
//     ScrollController? scrollController,
//     super.restorationId,
//     bool enableIMEPersonalizedLearning = true,
//     MouseCursor? mouseCursor,
//     EditableTextContextMenuBuilder? contextMenuBuilder =
//         _defaultContextMenuBuilder,
//   })  : assert(initialValue == null || controller == null),
//         // assert(textAlign != null),
//         // assert(autofocus != null),
//         // assert(readOnly != null),
//         assert(obscuringCharacter != null && obscuringCharacter.length == 1),
//         // assert(obscureText != null),
//         // assert(autocorrect != null),
//         // assert(enableSuggestions != null),
//         // assert(scrollPadding != null),
//         assert(maxLines == null || maxLines > 0),
//         assert(minLines == null || minLines > 0),
//         assert(
//           (maxLines == null) || (minLines == null) || (maxLines >= minLines),
//           "minLines can't be greater than maxLines",
//         ),
//         //  assert(expands != null),
//         assert(
//           !expands || (maxLines == null && minLines == null),
//           'minLines and maxLines must be null when expands is true.',
//         ),
//         assert(!obscureText || maxLines == 1,
//             'Obscured fields cannot be multiline.'),
//         assert(maxLength == null ||
//             maxLength == TextField.noMaxLength ||
//             maxLength > 0),
//         //  assert(enableIMEPersonalizedLearning != null),;
//         super(
//           initialValue:
//               controller != null ? controller.text : (initialValue ?? ''),
//           enabled: enabled ?? decoration?.enabled ?? true,
//           autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
//           builder: (FormFieldState<String> field) {
//             final _TextFormFieldState state = field as _TextFormFieldState;
//             final InputDecoration effectiveDecoration = (decoration ??
//                     const InputDecoration())
//                 .applyDefaults(Theme.of(field.context).inputDecorationTheme);
//             void onChangedHandler(String value) {
//               field.didChange(value);
//               if (onChanged != null) {
//                 onChanged(value);
//               }
//             }

//             return UnmanagedRestorationScope(
//               bucket: field.bucket,
//               child: TextField(
//                 restorationId: restorationId,
//                 controller: state._effectiveController,
//                 focusNode: focusNode,
//                 decoration:
//                     effectiveDecoration.copyWith(errorText: field.errorText),
//                 keyboardType: keyboardType,
//                 textInputAction: textInputAction,
//                 style: style,
//                 strutStyle: strutStyle,
//                 textAlign: textAlign,
//                 textAlignVertical: textAlignVertical,
//                 textDirection: textDirection,
//                 textCapitalization: textCapitalization,
//                 autofocus: autofocus,
//                 toolbarOptions: toolbarOptions,
//                 readOnly: readOnly,
//                 showCursor: showCursor,
//                 obscuringCharacter: obscuringCharacter,
//                 obscureText: obscureText,
//                 autocorrect: autocorrect,
//                 smartDashesType: smartDashesType ??
//                     (obscureText
//                         ? SmartDashesType.disabled
//                         : SmartDashesType.enabled),
//                 smartQuotesType: smartQuotesType ??
//                     (obscureText
//                         ? SmartQuotesType.disabled
//                         : SmartQuotesType.enabled),
//                 enableSuggestions: enableSuggestions,
//                 maxLengthEnforcement: maxLengthEnforcement,
//                 maxLines: maxLines,
//                 minLines: minLines,
//                 expands: expands,
//                 maxLength: maxLength,
//                 onChanged: onChangedHandler,
//                 onTap: onTap,
//                 onTapOutside: onTapOutside,
//                 onEditingComplete: onEditingComplete,
//                 onSubmitted: onFieldSubmitted,
//                 inputFormatters: inputFormatters,
//                 enabled: enabled ?? decoration?.enabled ?? true,
//                 cursorWidth: cursorWidth,
//                 cursorHeight: cursorHeight,
//                 cursorRadius: cursorRadius,
//                 cursorColor: cursorColor,
//                 scrollPadding: scrollPadding,
//                 scrollPhysics: scrollPhysics,
//                 keyboardAppearance: keyboardAppearance,
//                 enableInteractiveSelection:
//                     enableInteractiveSelection ?? (!obscureText || !readOnly),
//                 selectionControls: selectionControls,
//                 buildCounter: buildCounter,
//                 autofillHints: autofillHints,
//                 scrollController: scrollController,
//                 enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
//                 mouseCursor: mouseCursor,
//                 contextMenuBuilder: contextMenuBuilder,
//               ),
//             );
//           },
//         );
//   final TextEditingController? controller;
//   static Widget _defaultContextMenuBuilder(
//       BuildContext context, EditableTextState editableTextState) {
//     return AdaptiveTextSelectionToolbar.editableText(
//       editableTextState: editableTextState,
//     );
//   }

//   @override
//   FormFieldState<String> createState() => _TextFormFieldState();
// }

// class _TextFormFieldState() extends FormFieldState<String>{
//     RestorableTextEditingController? _controller;

//     TextEditingController get _effectiveController => _TextFormField.controller ?? _controller!.value;

//     AdTextFromField get _TextFormField => super.widget as AdTextFromField;

//     @override
//     void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
//     super.restoreState(oldBucket, initialRestore);
//     if (_controller != null) {
//       _registerController();
//     }
//     // Make sure to update the internal [FormFieldState] value to sync up with
//     // text editing controller value.
//     setValue(_effectiveController.text);
//   }

//   void _registerController(){
//     assert(_controller != null);
//     registerForRestoration(_controller!, 'controller');
//   }

//   void _createLocalController([TextEditingValue? value]){
//     assert(_controller == null);
//     _controller = value == null ? RestorableTextEditingController() : RestorableTextEditingController.fromValue(value);
//     if(!restorePending){
//       _registerController();
//     }
//   }

//   @override
//   void initState(){
//     super.initState();
//     if(_TextFormField.controller == null){
//       _createLocalController(widget.initialValue != null ? TextEditingValue(text: widget.initialValue!) : null);
//     } else {
//       _TextFormField.controller!.addListener(_handleControlChanged);
//     }
//   }

//   @override
//   void didUpdateWidget(AdTextFormField oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (_textFormField.controller != oldWidget.controller) {
//       oldWidget.controller?.removeListener(_handleControllerChanged);
//       _textFormField.controller?.addListener(_handleControllerChanged);

//       if (oldWidget.controller != null && _textFormField.controller == null) {
//         _createLocalController(oldWidget.controller!.value);
//       }

//       if (_textFormField.controller != null) {
//         setValue(_textFormField.controller!.text);
//         if (oldWidget.controller == null) {
//           unregisterFromRestoration(_controller!);
//           _controller!.dispose();
//           _controller = null;
//         }
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _textFormField.controller?.removeListener(_handleControllerChanged);
//     _controller?.dispose();
//     super.dispose();
//   }

//   @override
//   void didChange(String? value) {
//     super.didChange(value);

//     if (_effectiveController.text != value) {
//       _effectiveController.text = value ?? '';
//     }
//   }

//   @override
//   void reset() {
//     _effectiveController.text = widget.initialValue ?? '';
//     super.reset();
//   }

//   void _handleControllerChanged(){
//     if(_effectiveController.text != value){
//       didChange(_effectiveController.text);
//     }
//   }

// }
