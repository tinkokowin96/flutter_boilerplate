import 'package:exceed_resources_frontend/app/modules/core/theme/index.dart';
import 'package:exceed_resources_frontend/app/modules/core/utils/enum.dart';
import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final ESize size;
  final EText style;
  final bool disabled;

  const AppTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.style = EText.primary,
    this.size = ESize.md,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final TextStyle textStyle;
    switch (size) {
      case ESize.sm:
        textStyle = AppTheme.of(context).text.h4(context: context, type: style);
        break;
      case ESize.md:
        textStyle = AppTheme.of(context).text.h3(context: context, type: style);
        break;
      default:
    }
    return TextButton(
      onPressed: () => disabled ? null : onPressed(),
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(
          disabled ? AppTheme.of(context).color.disabled : AppTheme.of(context).color.primary.withOpacity(0.2),
        ),
      ),
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}
