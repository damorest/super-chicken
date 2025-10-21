import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/base_screen.dart';
import '../../services/settings_service.dart';
import '../../widgets/components/app_button.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  int? selectedEggIndex;

  @override
  void initState() {
    super.initState();
    final settings = context.read<SettingsService>();
    for (int i = 0; i < 9; i++) {
      if (settings.selectedEgg.endsWith('egg_${i + 1}.png')) {
        selectedEggIndex = i;
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsService>();
    final balance = settings.balance;

    return BaseScreen(
      title: 'SHOP',
      width: 0.95,
      bottomChild: AppButton(
        text: 'Buy',
        fontSize: 32,
        onPressed: selectedEggIndex == null
            ? null
            : () async {
          final price = (selectedEggIndex! + 1) * 10;
          if (balance < price) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Not enough coins!')),
            );
            return;
          }

          final newBalance = balance - price;
          await settings.updateBalance(newBalance);
          await settings.updateSelectedEgg('assets/images/egg_${selectedEggIndex! + 1}.png');

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Purchase successful!')),
          );
        },
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: List.generate(9, (index) {
              final price = (index + 1) * 10;
              final isSelected = selectedEggIndex == index;
              return SizedBox(
                width: (MediaQuery.of(context).size.width * 0.7 - 32) / 3,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedEggIndex = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected ? Colors.greenAccent : const Color(0xFFFF6CD8),
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(6),
                        child: Image.asset(
                          'assets/images/egg_${index + 1}.png',
                          fit: BoxFit.contain,
                          height: 70,
                          width: 70,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$price',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: Colors.black87,
                                offset: Offset(1, 1),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 4),
                        Image.asset(
                            'assets/images/Circle.png',
                          width: 18,
                          height: 18,
                        )
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
