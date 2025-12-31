import 'package:flutter/material.dart';
import '/core/core.dart';
import '/shared/shared.dart';

class CheckBoxFormFild extends StatefulWidget {
  const CheckBoxFormFild({super.key, required this.value, this.text, this.errorText, this.onChanged, this.child, this.marge, this.width, this.title, this.isRequired = false});

  final bool value;
  final String? text;
  final Widget? child;
  final String? errorText;
  final Function(bool?)? onChanged;
  final EdgeInsetsGeometry? marge;
  final double? width;
  final String? title;
  final bool isRequired;

  @override
  State<CheckBoxFormFild> createState() => _CheckBoxFormFildState();
}

class _CheckBoxFormFildState extends State<CheckBoxFormFild> {
  bool? _value;

  @override
  void initState() {
    _value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      padding: widget.marge ?? EdgeInsets.zero,
      child: FormField<bool>(
        initialValue: _value,
        validator: (value) {
          if (value == false) {
            return widget.errorText ?? widget.errorText;
          }
          return null;
        },
        builder: (formFieldState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.title != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(widget.title ?? '', style: context.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold)),
                        if (widget.isRequired)
                          Row(
                            children: [
                              SpaceWidget.extraSmall(),
                              Text(
                                context.text.required,
                                style: context.textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.error, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                      ],
                    ),
                    SpaceWidget.extraSmall(),
                  ],
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _value,
                    onChanged: (v) {
                      if (widget.onChanged != null) {
                        formFieldState.didChange(v);

                        setState(() {
                          _value = v!;
                        });
                        widget.onChanged!(v);
                      } else {}
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  if (widget.child != null) widget.child!,
                  Text(widget.text ?? '', style: context.textTheme.labelMedium),
                ],
              ),
              if (formFieldState.hasError)
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(formFieldState.errorText!, style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 12)),
                ),
            ],
          );
        },
      ),
    );
  }
}
