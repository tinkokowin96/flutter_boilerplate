import 'package:exceed_resources_frontend/app/modules/core/theme/miscs.dart';
import 'package:exceed_resources_frontend/app/modules/core/theme/size.dart';
import 'package:exceed_resources_frontend/app/modules/core/utils/enum.dart';
import 'package:flutter/material.dart';

class AppContainer extends StatelessWidget {
  final bool vertical;
  final bool noShadow;
  final ESize borderRadius;
  final BoxShadow? shadow;
  final double? padding;
  final double? width;
  final double? height;
  final Widget? child;
  const AppContainer({
    Key? key,
    this.vertical = false,
    this.noShadow = false,
    this.borderRadius = ESize.md,
    this.shadow,
    this.padding,
    this.width,
    this.height,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: vertical
            ? BorderRadius.only(
                topLeft: Radius.circular(
                  borderRadius == ESize.md ? AppSize.sm : AppSize.xs,
                ),
                bottomLeft: Radius.circular(
                  borderRadius == ESize.md ? AppSize.sm : AppSize.xs,
                ),
              )
            : BorderRadius.all(
                Radius.circular(
                  borderRadius == ESize.md ? AppSize.sm : AppSize.xs,
                ),
              ),
        boxShadow: noShadow ? null : [shadow ?? AppThemeMiscs.shadow2],
      ),
      child: SizedBox(
        width: width,
        height: height,
        child: Padding(
          padding: EdgeInsets.all(padding ?? AppSize.lg),
          child: child,
        ),
      ),
    );
  }
}
