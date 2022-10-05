import 'package:exceed_resources_frontend/app/modules/core/theme/index.dart';
import 'package:exceed_resources_frontend/app/modules/core/theme/size.dart';
import 'package:exceed_resources_frontend/app/modules/core/theme/sizebox.dart';
import 'package:exceed_resources_frontend/app/modules/core/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormFieldInput extends StatelessWidget {
  final String hintText;
  final double width;
  final bool readOnly;
  final bool obscureText;
  final TextEditingController? controller;
  final String? value;
  final List<TextInputFormatter>? inputFormat;
  final String? suffix;
  final FocusNode? focusNode;
  final String? title;
  final bool? smallText;
  final String? Function(String? value)? validator;
  final Function()? onTap;
  final Function(String value)? onChanged;
  final Function(bool hasFocus)? onFocusChange;

  const FormFieldInput({
    Key? key,
    required this.hintText,
    required this.width,
    this.controller,
    this.value,
    this.obscureText = false,
    this.readOnly = false,
    this.inputFormat,
    this.focusNode,
    this.suffix,
    this.title,
    this.smallText,
    this.validator,
    this.onTap,
    this.onChanged,
    this.onFocusChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null
            ? Text(title!,
                style: smallText != null
                    ? AppTheme.of(context).text.h3(context: context)
                    : AppTheme.of(context).text.h3(context: context))
            : AppSizeBox.zero,
        Column(
          children: [
            SizedBox(
              width: width,
              height: AppSize.fHMd,
              child: Focus(
                onFocusChange: ((bool hasFocus) => onFocusChange != null ? onFocusChange!(hasFocus) : null),
                child: TextFormField(
                  readOnly: readOnly,
                  obscureText: obscureText,
                  controller: controller,
                  initialValue: value,
                  inputFormatters: inputFormat,
                  focusNode: focusNode,
                  onTap: onTap,
                  style: smallText != null
                      ? AppTheme.of(context).text.h4(context: context)
                      : AppTheme.of(context).text.h3(context: context),
                  decoration: InputDecoration(
                    hintText: hintText,
                    suffix: suffix != null
                        ? ColoredBox(
                            color: AppTheme.of(context).color.primary.withOpacity(0.2),
                            child: Padding(
                              padding: const EdgeInsets.all(AppSize.sm),
                              child: Text(
                                suffix!,
                                style: AppTheme.of(context).text.h4(context: context, type: EText.primary),
                              ),
                            ),
                          )
                        : AppSizeBox.zero,
                    hintStyle: smallText != null
                        ? AppTheme.of(context).text.h4(context: context, type: EText.subtitle)
                        : AppTheme.of(context).text.h3(context: context, type: EText.subtitle),
                    border: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppTheme.of(context).color.primary),
                    ),
                  ),
                  onChanged: onChanged,
                  validator: validator,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
