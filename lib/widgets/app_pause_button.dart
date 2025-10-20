import 'package:flutter/material.dart';
import 'package:media_test/widgets/components/app_button.dart';

class AppPauseButton extends StatelessWidget {
  final VoidCallback onTap;
  final double size;
  final double iconSize;

  const AppPauseButton({
    super.key,
    required this.onTap,
    this.size = 70,
    this.iconSize = 36,
  });

  @override
  Widget build(BuildContext context) {
    return AppButton(
      type: AppButtonType.secondary,
      width: size,
      height: size,
      onPressed: onTap,
      icon: Icon(
        Icons.pause,
        color: Colors.white,
        size: iconSize,
        shadows: const [
          Shadow(
            color: Colors.black87,
            offset: Offset(2, 2),
            blurRadius: 4,
          ),
        ],
      ),
    );
  }
}
