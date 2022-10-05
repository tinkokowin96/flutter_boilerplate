import 'package:exceed_resources_frontend/app/modules/core/theme/index.dart';
import 'package:exceed_resources_frontend/app/modules/core/theme/size.dart';
import 'package:exceed_resources_frontend/app/modules/core/utils/enum.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Size size;
  final String text;
  final TextStyle? buttonTextStyle;
  final Function() onPressed;

  const Button({
    Key? key,
    required this.onPressed,
    required this.text,
    this.buttonTextStyle,
    this.size = const Size(AppSize.btnWMd, AppSize.btnHMd),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(size.height),
            ),
          ),
          fixedSize: MaterialStateProperty.all(size),
          backgroundColor: MaterialStateProperty.all(AppTheme.of(context).color.primary),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
        ),
        child: Center(
          child: Text(
            text,
            style: buttonTextStyle ?? AppTheme.text(context: context, type: ETextType.white),
          ),
        ),
      );
}
