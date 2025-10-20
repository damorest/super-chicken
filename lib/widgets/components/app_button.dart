import 'package:flutter/material.dart';

enum AppButtonType { primary, secondary, text, circle }

class AppButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final double width;
  final double height;
  final Widget? icon;
  final bool isDisabled;
  final double fontSize;

  const AppButton({
    super.key,
    this.text,
    this.onPressed,
    this.type = AppButtonType.primary,
    this.width = 200,
    this.height = 100,
    this.icon,
    this.isDisabled = false,
    this.fontSize = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    final bool enabled = onPressed != null && !isDisabled;

    return GestureDetector(
      onTap: enabled ? onPressed : null,
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _buildBackground(),
            if (text != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    text!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSize,
                      shadows: const [
                        Shadow(
                          color: Colors.black87,
                          offset: Offset(2, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            if (icon != null) Positioned(child: icon!),
          ],
        ),
      ),
    );
  }

  Widget _buildBackground() {
    switch (type) {
      case AppButtonType.primary:
        return Image.asset(
          'assets/images/menu_but.png',
          width: width,
          height: height,
          fit: BoxFit.contain,
        );
      case AppButtonType.secondary:
        return Image.asset(
          'assets/images/Rectangle.png',
          width: width,
          height: height,
          fit: BoxFit.contain,
        );
      case AppButtonType.circle:
        return Image.asset(
          'assets/images/Circle.png',
          width: width,
          height: height,
          fit: BoxFit.contain,
        );
      case AppButtonType.text:
        return const SizedBox();
    }
  }
}
