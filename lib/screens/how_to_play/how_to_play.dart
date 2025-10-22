import 'package:flutter/material.dart';
import '../../widgets/base_screen.dart';

class HowToPlay extends StatelessWidget {
  const HowToPlay({super.key});

  final String _instructionsTextUa = '''
Мета гри — допомогти курці вижити якомога довше, уникаючи вогняних кіл, які летять знизу вгору. На старті ви отримуєте 1000 монет, за які можна купувати яйця в магазині. Куплені яйця можна використовувати під час гри, щоб збивати вогняні кола та отримувати додаткові очки.

Керуйте куркою, переміщуючи її вліво або вправо, щоб уникати вогняних кіл. У грі немає стрибків або додаткових дій — лише реакція та точність рухів.

Вогняні кола з’являються знизу та піднімаються вгору. З кожним рівнем вони рухаються швидше та з’являються частіше. Якщо коло торкнеться курки — гра завершується.

Кожен пройдений рівень відкриває наступний. Якщо ви програли, можна спробувати знову та покращити свій результат. За успішну гру ви отримуєте бали, які зберігаються у вашому профілі. Намагайтеся побити свій найкращий рекорд.

У грі можна обрати аватара для свого персонажа. Вибраний аватар відображатиметься у грі замість стандартної курки, що дозволяє персоналізувати досвід.

У будь-який момент гру можна поставити на паузу, використавши кнопку у верхньому правому куті екрана. У меню паузи можна повернутися на головний екран або перезапустити поточний рівень.
''';

  final String _instructionsTextEn = '''
The goal of the game is to help the chicken survive as long as possible by avoiding fire circles that fly from the bottom to the top of the screen. At the start, you receive 1,000 coins, which can be used to buy eggs in the shop. Purchased eggs can be used during the game to knock down fire circles and earn additional points.

Control the chicken by moving it left or right to avoid the fire circles. The game does not include jumping or additional actions — only reaction and precise movements matter.

Fire circles appear from the bottom and rise upward. With each level, they move faster and spawn more frequently. If a circle touches the chicken, the game ends.

Each completed level unlocks the next one. If you lose, you can try again to improve your score. Successful gameplay earns points that are saved to your profile. Try to beat your best record.

You can choose an avatar for your character. The selected avatar will appear in the game instead of the default chicken, allowing for a personalized experience.

At any time, you can pause the game using the button in the top-right corner of the screen. In the pause menu, you can return to the main screen or restart the current level.
''';

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      showWallet: false,
      title: 'how to play',
      child: Text(_instructionsTextEn,
          style: const TextStyle(color: Colors.white, fontSize: 18)),
    );
  }
}
