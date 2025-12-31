import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/core/core.dart' hide Visibility;
import '/shared/shared.dart';

class TextFormFieldWidget extends StatefulWidget {
  final String? title;
  final String? hintText;
  final IconData? icon;
  final bool enabled;
  final bool autocorrect;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;

  final bool? isRequired;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Iterable<String>? autofillHints;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final Widget? label;
  final double? width;
  final bool isNotBorderless;

  const TextFormFieldWidget({
    super.key,
    this.title,
    this.hintText,
    this.icon,
    this.autocorrect = false,
    this.enabled = true,
    this.obscureText = false,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onFieldSubmitted,
    this.isRequired = false,
    this.prefixIcon,
    this.suffixIcon,
    this.autofillHints,
    this.validator,
    this.inputFormatters,
    this.maxLines = 1,
    this.label,
    this.width,
    this.isNotBorderless = false,
  });

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();

  factory TextFormFieldWidget.seachService({required BuildContext context, required TextEditingController controller}) {
    return TextFormFieldWidget(
      controller: controller,
      hintText: context.text.searchAttendimentosHint,
      icon: context.icon.search,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@._-]'))],
    );
  }

  factory TextFormFieldWidget.name(BuildContext context, {double? width, String? title, required TextEditingController controller}) {
    return TextFormFieldWidget(
      controller: controller,
      isRequired: true,
      width: width,
      title: title ?? context.text.name,
      hintText: context.text.nameHint,
      icon: context.icon.user,
      autocorrect: true,
      validator: (v) => InputValidator(context: context, value: v).validateEmptyField(),
    );
  }

  factory TextFormFieldWidget.password(BuildContext context, {double? width, required TextEditingController controller}) {
    return TextFormFieldWidget(
      controller: controller,
      isRequired: true,
      width: width,
      title: context.text.password,
      hintText: context.text.passwordHint,
      icon: context.icon.password,
      obscureText: true,
      autocorrect: true,
      validator: (v) => (InputValidator(context: context, value: v)..validatePassword()).message,
      inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
    );
  }

  factory TextFormFieldWidget.passwordConfirm(BuildContext context, {double? width, required TextEditingController controller, required String Function() passwordProvider}) {
    return TextFormFieldWidget(
      controller: controller,
      isRequired: true,
      width: width,
      title: context.text.passwordConfirm,
      hintText: context.text.passwordConfirmHint,
      icon: context.icon.password,
      obscureText: true,
      autocorrect: true,
      validator: (v) => (InputValidator(context: context, value: v)..validateConfirmPassword(passwordProvider())).message,
      inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
    );
  }

  factory TextFormFieldWidget.email(BuildContext context, {double? width, required TextEditingController controller}) {
    return TextFormFieldWidget(
      width: width,
      controller: controller,
      isRequired: true,
      hintText: context.text.emailHint,
      icon: context.icon.email,
      title: context.text.email,
      autocorrect: true,
      validator: (v) => InputValidator(context: context, value: v).validateEmail(),
      inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
    );
  }

  factory TextFormFieldWidget.phone({required BuildContext context, required TextEditingController controller}) {
    return TextFormFieldWidget(
      controller: controller,
      isRequired: true,
      hintText: context.text.phoneHint,
      icon: context.icon.phone,
      label: Text(context.text.whatsappHint),
      obscureText: false,
      autocorrect: true,
      validator: (v) => InputValidator(context: context, value: v).validateEmptyField(),
      inputFormatters: [CustomMasks.phoneMaskFormatterWithDDD],
    );
  }
  // token
  factory TextFormFieldWidget.token({required BuildContext context, required TextEditingController controller}) {
    return TextFormFieldWidget(
      controller: controller,
      isRequired: true,
      hintText: context.text.tokenHint,
      icon: context.icon.token,
      label: Text(context.text.token),
      obscureText: false,
      autocorrect: true,
      keyboardType: TextInputType.number,
      validator: (v) => InputValidator(context: context, value: v).validateEmptyField(errorText: context.text.tokenHint),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }

  // cpf
  factory TextFormFieldWidget.cpf({required BuildContext context, required TextEditingController controller}) {
    return TextFormFieldWidget(
      controller: controller,
      isRequired: true,
      hintText: context.text.cpfHint,
      icon: context.icon.cpf,
      obscureText: false,
      autocorrect: true,
      label: Text(context.text.cpf),
      validator: (v) => InputValidator(context: context, value: v).validateCpf(),
      inputFormatters: [CustomMasks.cpfMaskFormatter],
    );
  }

  // search
  factory TextFormFieldWidget.search({required BuildContext context, required TextEditingController controller, Widget? prefixIcon, String? hintText}) {
    return TextFormFieldWidget(
      controller: controller,
      hintText: hintText,
      icon: context.icon.search,
      prefixIcon: prefixIcon,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@._-]'))],
    );
  }
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  ValueNotifier<bool> isObscure = ValueNotifier(false);
  String? _combinedValidator(String? value) {
    final contextValidator = InputValidator(context: context, value: value);
    if (widget.isRequired == true) {
      contextValidator.validateEmptyField();
    }
    if (widget.validator != null) {
      final parentMessage = widget.validator!(value);
      if (parentMessage != null) {
        return parentMessage;
      }
    }
    return contextValidator.message;
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: widget.width ?? 200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4,
        children: [
          Visibility(
            visible: widget.title != null,
            child: Row(
              children: [
                Text(
                  widget.title ?? "",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600, fontSize: 14, color: CustomColors.preto),
                ),
                Visibility(
                  visible: widget.isRequired!,
                  child: Row(
                    children: [
                      SpaceWidget.extraSmall(),
                      Text(
                        context.text.required,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.error, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ValueListenableBuilder(
            valueListenable: isObscure,
            builder: (context, value, child) {
              return TextFormField(
                maxLines: widget.maxLines,
                inputFormatters: widget.inputFormatters,
                controller: widget.controller,
                obscureText: widget.obscureText && !isObscure.value,
                keyboardType: widget.keyboardType,
                textInputAction: widget.textInputAction,
                onChanged: widget.onChanged,
                onFieldSubmitted: widget.onFieldSubmitted,
                enabled: widget.enabled,
                style: !widget.isNotBorderless
                    ? context.textTheme.titleMedium?.copyWith(color: CustomColors.preto, fontWeight: FontWeight.w400)
                    : context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w400, color: CustomColors.white),
                cursorColor: context.theme.colorScheme.primary,
                cursorHeight: 20,
                cursorWidth: 2,
                autocorrect: widget.autocorrect,
                autofillHints: widget.autofillHints,
                validator: widget.validator ?? _combinedValidator,
                decoration: InputDecoration(
                  // label: widget.label,
                  contentPadding: widget.isNotBorderless ? const EdgeInsets.symmetric(vertical: 8, horizontal: 0) : const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  enabled: widget.enabled,
                  hintText: widget.hintText,

                  prefixIcon: Icon(widget.icon),
                  suffixIcon:
                      widget.suffixIcon ??
                      (widget.obscureText
                          ? IconButton(
                              icon: Icon(isObscure.value ? context.icon.eye : context.icon.eyeOff),
                              onPressed: () {
                                isObscure.value = !isObscure.value;
                              },
                            )
                          : null),
                  border: !widget.isNotBorderless
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(color: context.theme.colorScheme.outline, width: 0.5),
                        )
                      : InputBorder.none,
                  disabledBorder: !widget.isNotBorderless
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(color: CustomColors.preto),
                        )
                      : InputBorder.none,
                  enabledBorder: !widget.isNotBorderless
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(color: context.theme.colorScheme.outline, width: 0.5),
                        )
                      : InputBorder.none,
                  prefixIconColor: context.theme.colorScheme.primary,
                  focusedBorder: !widget.isNotBorderless
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(color: context.theme.colorScheme.primary),
                        )
                      : InputBorder.none,
                  errorBorder: !widget.isNotBorderless
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(color: CustomColors.vermelho),
                        )
                      : InputBorder.none,
                  focusedErrorBorder: !widget.isNotBorderless
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(color: CustomColors.vermelho),
                        )
                      : InputBorder.none,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
