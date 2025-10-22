import 'package:flutter/material.dart';
import 'package:media_test/widgets/components/app_button.dart';
import '../../core/app_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/menu_bg.png',
              fit: BoxFit.cover,
            ),
          ),

          Align(
            alignment: Alignment.center,
            child: FractionallySizedBox(
              heightFactor: 0.8,
              child: Image.asset(
                'assets/images/chicken.png',
                fit: BoxFit.contain,
              ),
            ),
          ),

          Positioned(
            bottom: size.height * 0.04,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRouter.levels);
              },
              child: const AppButton(
                text: 'PLAY',
                width: 270,
                height: 170,
                fontSize: 60,
              ),
            ),
          ),

          Positioned(
            top: 40,
            left: 20,
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, AppRouter.howToPlay) ,
              child: const AppButton(
                type: AppButtonType.secondary,
                text: 'i',
                width: 70,
                height: 70,
              ),
            ),
          ),

          Positioned(
            top: 40,
            right: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRouter.menu);
              },
              child: const AppButton(
                type: AppButtonType.secondary,
                width: 70,
                height: 70,
                icon: Icon(
                Icons.menu,
                color: Colors.white,
                size: 36,
                shadows: [
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
        ],
      ),
    );
  }
}
