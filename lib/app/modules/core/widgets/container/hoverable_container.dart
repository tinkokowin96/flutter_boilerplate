import 'package:flutter/material.dart';

class AppHoverableContainer extends StatefulWidget {
  final Widget child;
  final Function() onPressed;
  final Color hoverColor;
  final Color idleColor;
  const AppHoverableContainer({
    Key? key,
    required this.child,
    required this.onPressed,
    required this.hoverColor,
    required this.idleColor,
  }) : super(key: key);

  @override
  State<AppHoverableContainer> createState() => _AppHoverableContainerState();
}

class _AppHoverableContainerState extends State<AppHoverableContainer> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      onHover: (value) => setState(() {
        _hover = value;
      }),
      child: Container(
        color: _hover ? widget.hoverColor : widget.idleColor,
        child: widget.child,
      ),
    );
  }
}
