import 'package:flutter/material.dart';
import 'package:media_test/widgets/components/app_button.dart';

class WalletDisplay extends StatelessWidget {
  final int balance;

  const WalletDisplay({
    super.key,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          alignment: AlignmentGeometry.centerLeft,
          height: 35,
          decoration: BoxDecoration(
            color: const Color(0xFFFF8E03),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFFF2B00),
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  '$balance',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    shadows: [
                      Shadow(
                        color: Colors.black54,
                        offset: Offset(2, 2),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 40),
            ],
          ),
        ),

        const Positioned(
          right: -10,
          top: -12,
          child: AppButton(
            type: AppButtonType.circle,
            width: 60,
            height: 60,
          ),
        ),
      ],
    );
  }
}
