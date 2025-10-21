import 'package:flutter/material.dart';
import 'package:media_test/widgets/wallet_display.dart';
import 'package:provider/provider.dart';
import '../services/settings_service.dart';
import 'app_back_button.dart';

class BaseScreen extends StatefulWidget {
  final String title;
  final Widget? child;
  final Widget? bottomChild;
  final VoidCallback? onBack;
  final double width;
  final bool showWallet;

  const BaseScreen({
    super.key,
    required this.title,
    this.child,
    this.bottomChild,
    this.onBack,
    this.width = 0.95,
    this.showWallet = true,
  });

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _colorAnimation = ColorTween(
      begin: Colors.transparent,
      end: Colors.red.withAlpha((0.2 * 255).round()),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/menu_bg.png',
              fit: BoxFit.fill,
            ),
          ),
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (_, __) => Container(
                color: _colorAnimation.value,
              ),
            ),
          ),

          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppBackButton(
                                  size: 70,
                                  onTap: widget.onBack ?? () => Navigator.pop(context),
                                ),
                                WalletDisplay(
                                    balance: context.watch<SettingsService>().balance,
                                  ),
                              ],
                            ),
                          ),

                          const Spacer(),

                          Center(
                            child: Container(
                              width: screenWidth * widget.width,
                              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                              decoration: BoxDecoration(
                                color: const Color(0xCC7A025A),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(0xFFFF6CD8),
                                  width: 3,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    widget.title,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black87,
                                          offset: Offset(2, 2),
                                          blurRadius: 4,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  if (widget.child != null)
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxHeight: screenHeight * 0.65,
                                      ),
                                      child: SingleChildScrollView(
                                        child: widget.child,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),

                          const Spacer(),

                          if (widget.bottomChild != null)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: widget.bottomChild!,
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}
