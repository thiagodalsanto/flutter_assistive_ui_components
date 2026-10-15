// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_assistive_ui_components/src/internal/field_validator_hint.dart';
import 'package:flutter_assistive_ui_components/src/helpers/preset_size_multiplier.dart';
import 'package:flutter_assistive_ui_components/src/models/password_hint_string_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_assistive_ui_components/src/internal/floating_feedback.dart';
import 'package:flutter_assistive_ui_components/src/providers/providers.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

/// =======================================================
/// Custom TextField Component
///
/// A configurable text input widget with support for:
/// - External controller management
/// - Focus handling via tap interaction
/// - Global styling via UserComponentProvider
/// - Optional haptic feedback
/// - Optional floating feedback messages
/// - Press delay animation support
///
/// Designed for reusable form systems where input fields
/// need consistent behavior and centralized styling control.
/// =======================================================

class AssistiveUITextField extends StatefulWidget {
  final String label;
  final double height;
  final double width;
  final double touchPadding;
  final double padding;
  final Duration pressDelay;
  final bool enableHaptic;
  final Duration hapticDuration;
  final bool showFeedback;
  final String feedbackText;
  final Color color;
  final FocusNode? focusNode;
  final ValueChanged<String?>? onSubmitted;
  final ValueChanged<String?> onSaved;
  final TextInputAction textInputAction;
  final String? initialValue;
  final IconData prefixIconData;
  final bool? autofocus;
  final String? Function(String?)? validator;
  final bool? isPassword;
  final bool validate;
  final PasswordHintString hintString;
  final bool? showObscure;
  final TextInputType? keyboardType;

  const AssistiveUITextField({
    super.key,
    required this.label,
    required this.onSaved,
    required this.textInputAction,
    this.onSubmitted,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.showObscure = false,
    this.validate = true,
    this.isPassword = false,
    this.autofocus = false,
    this.prefixIconData = Icons.email,
    this.initialValue,
    this.height = 56,
    this.width = 200,
    this.padding = 8,
    this.touchPadding = 12,
    this.pressDelay = Duration.zero,
    this.enableHaptic = false,
    this.hapticDuration = const Duration(milliseconds: 30),
    this.showFeedback = false,
    this.feedbackText = "Campo de texto ativado",
    this.color = Colors.blue,
    this.focusNode,
    this.hintString = const PasswordHintString(),
  });

  @override
  State<AssistiveUITextField> createState() => _AssistiveUITextFieldState();
}

class _AssistiveUITextFieldState extends State<AssistiveUITextField> {
  bool _pressed = false;
  final FocusNode _focusNode = FocusNode();

  static const String prefix = "textfield";

  late bool _isVisible;
  late bool _hasMinLengthEight;
  late bool _hasOneLowercase;
  late bool _hasOneUppercase;
  late bool _hasOneNumber;
  late bool _hasOneSymbol;

  @override
  void initState() {
    super.initState();

    _isVisible = false;
    _onChanged(widget.initialValue);

    if (widget.validate == false) {
      _hasMinLengthEight = true;
      _hasOneLowercase = true;
      _hasOneUppercase = true;
      _hasOneNumber = true;
      _hasOneSymbol = true;
    }
  }

  void _onChanged(String? value) {
    if (widget.validate == false) return;

    if (value == null) {
      return setState(() {
        _hasMinLengthEight = false;
        _hasOneLowercase = false;
        _hasOneUppercase = false;
        _hasOneNumber = false;
        _hasOneSymbol = false;
      });
    }

    setState(() {
      _hasMinLengthEight = value.length >= 8;
      _hasOneLowercase = value.contains(RegExp('[a-z]'));
      _hasOneUppercase = value.contains(RegExp('[A-Z]'));
      _hasOneNumber = value.contains(RegExp('[0-9]'));
      _hasOneSymbol = value.contains(RegExp(r'''[-#!\$@£%\^&\*\(\)_\+\|~=`\{\}\[\]:";'<>\?,\.\/ ]'''));
    });
  }

  Future<void> _handleTap(
    BuildContext context, {
    required Duration pressDelay,
    required bool enableHaptic,
    required Duration hapticDuration,
    required bool showFeedback,
  }) async {
    if (pressDelay > Duration.zero) {
      setState(() => _pressed = true);
      await Future.delayed(pressDelay);
    }

    if (enableHaptic) {
      HapticFeedback.lightImpact();
      await Future.delayed(hapticDuration);
    }

    (widget.focusNode ?? _focusNode).requestFocus();

    if (showFeedback) {
      showFloatingFeedback(context, widget.feedbackText);
    }

    setState(() => _pressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserComponentProvider>();
    final FocusNode effectiveFocusNode = widget.focusNode ?? _focusNode;

    final height = getScaledPresetConfig(provider, prefix, 'height', widget.height);
    final validationHeight = widget.validator != null && widget.isPassword != true ? 48.0 : 0.0;
    final width = getScaledPresetConfig(provider, prefix, 'width', widget.width);
    final touchPadding = getScaledPresetConfig(provider, prefix, 'touchPadding', widget.touchPadding);
    final padding = getScaledPresetConfig(provider, prefix, 'padding', widget.padding);
    final pressDelayMs =
        provider.getConfig<double>("${prefix}_pressDelay") ?? widget.pressDelay.inMilliseconds;
    final enableHaptic = provider.getConfig<bool>("${prefix}_enableHaptic") ?? widget.enableHaptic;
    final showFeedback = provider.getConfig<bool>("${prefix}_showFeedback") ?? widget.showFeedback;
    final color = provider.getConfig<Color>("${prefix}_color") ?? widget.color;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _handleTap(
        context,
        pressDelay: Duration(milliseconds: pressDelayMs.toInt()),
        enableHaptic: enableHaptic,
        hapticDuration: widget.hapticDuration,
        showFeedback: showFeedback,
      ),
      child: Padding(
        padding: EdgeInsets.all(touchPadding),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0 + padding),
            boxShadow: _pressed
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: SizedBox(
            width: width,
            height: widget.isPassword! ? 300 : height + validationHeight,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(minHeight: widget.isPassword == true ? 0 : height),
                    child: FormBuilderTextField(
                      autofocus: widget.autofocus!,
                      initialValue: widget.initialValue,
                      focusNode: effectiveFocusNode,
                      onChanged: _onChanged,
                      keyboardType: widget.keyboardType,
                      obscureText: (widget.showObscure == true) ? !_isVisible : false,
                      validator: widget.isPassword!
                          ? FormBuilderValidators.compose([
                              FormBuilderValidators.required(),

                              (val) {
                                if (_hasMinLengthEight == false ||
                                    _hasOneLowercase == false ||
                                    _hasOneUppercase == false ||
                                    _hasOneNumber == false ||
                                    _hasOneSymbol == false) {
                                  return widget.hintString.errorPasswordRequirementsNotMeet;
                                }
                                return null;
                              },
                            ])
                          : widget.validator,
                      decoration: InputDecoration(
                        prefixIcon: Icon(widget.prefixIconData),
                        labelText: widget.label,
                        suffixIcon: Visibility(
                          visible: widget.showObscure == true,
                          child: IconButton(
                            onPressed: () => setState(() {
                              _isVisible = !_isVisible;
                            }),
                            icon: _isVisible
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off, color: Colors.grey),
                          ),
                        ),
                        isDense: widget.isPassword == true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: color, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: padding,
                          vertical: widget.isPassword == true ? padding : (height / 2) - 12,
                        ),
                      ),
                      textInputAction: widget.textInputAction,
                      onSubmitted: widget.onSubmitted,
                      onSaved: widget.onSaved,
                      name: widget.label,
                    ),
                  ),
                  if (widget.isPassword == true && widget.validate) ...[
                    const SizedBox(height: 24),
                    FieldValidatorHint(
                      hintText: widget.hintString.hasMinLengthEight,
                      isValid: _hasMinLengthEight,
                    ),
                    const SizedBox(height: 16),
                    FieldValidatorHint(
                      hintText: widget.hintString.hasOneLowercase,
                      isValid: _hasOneLowercase,
                    ),
                    const SizedBox(height: 16),
                    FieldValidatorHint(
                      hintText: widget.hintString.hasOneUppercase,
                      isValid: _hasOneUppercase,
                    ),
                    const SizedBox(height: 16),
                    FieldValidatorHint(hintText: widget.hintString.hasOneNumber, isValid: _hasOneNumber),
                    const SizedBox(height: 16),
                    FieldValidatorHint(hintText: widget.hintString.hasOneSymbol, isValid: _hasOneSymbol),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
