import 'package:exceed_resources_frontend/app/modules/core/theme/index.dart';
import 'package:exceed_resources_frontend/app/modules/core/theme/size.dart';
import 'package:exceed_resources_frontend/app/modules/core/theme/sizebox.dart';
import 'package:exceed_resources_frontend/app/modules/core/utils/enum.dart';
import 'package:flutter/material.dart';

class FieldInput extends StatelessWidget {
  final TextEditingController controller;
  final String? title;
  final double? width;

  const FieldInput({
    Key? key,
    required this.controller,
    this.width,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        width: width ?? AppSize.fWMd(context),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            title != null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(title!, style: AppTheme.text(size: EText.h4, context: context)),
                      AppSizeBox.sm,
                    ],
                  )
                : AppSizeBox.zero,
            Expanded(
              child: TextField(
                style: AppTheme.text(size: EText.h4, context: context),
                controller: controller,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(bottom: AppSize.sm),
                  isCollapsed: true,
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.of(context).color.primary),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
