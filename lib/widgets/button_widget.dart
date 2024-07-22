import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String textButton;
  final Widget? widget;
  final Function()? onTap;
  final Color? buttonColor;
  final Decoration? decoration;
  final double? width;
  final double? height;
  final double? spaceWidget;
  final EdgeInsetsGeometry padding;
  final BorderRadius? borderRadius;
  final TextStyle? textStyle;
  const ButtonWidget({
    super.key,
    required this.textButton,
    required this.onTap,
    this.buttonColor,
    this.decoration,
    this.widget,
    this.width,
    this.height,
    this.spaceWidget = 10,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 5,
    ),
    this.borderRadius,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Material(
        color: buttonColor,
        borderRadius: borderRadius,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius,
          child: Container(
            padding: padding,
            decoration: decoration,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget != null) ...[
                  widget!,
                  SizedBox(width: spaceWidget),
                ],
                Flexible(
                  child: Text(
                    textButton,
                    overflow: TextOverflow.ellipsis,
                    style: textStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
