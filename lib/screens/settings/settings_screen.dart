import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/settings_service.dart';
import '../../widgets/base_screen.dart';
import '../../widgets/components/app_button.dart';
import '../../widgets/gradient_switch.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool soundOn = true;
  bool notificationOn = true;
  bool vibrationOn = true;

  @override
  void initState() {
    super.initState();
    final settings = context.read<SettingsService>();
    soundOn = settings.soundOn;
    notificationOn = settings.notificationOn;
    vibrationOn = settings.vibrationOn;
  }

  Future<void> _saveSettings() async {
    final settings = context.read<SettingsService>();
    await settings.save(
      sound: soundOn,
      notification: notificationOn,
      vibration: vibrationOn,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Settings saved!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'SETTINGS',
      bottomChild: AppButton(
        text: 'SAVE',
        width: 220,
        height: 110,
        fontSize: 45,
        onPressed: _saveSettings,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          children: [
            _buildSwitchRow('Sound', soundOn, (val) => setState(() => soundOn = val)),
            _buildSwitchRow('Notification', notificationOn, (val) => setState(() => notificationOn = val)),
            _buildSwitchRow('Vibration', vibrationOn, (val) => setState(() => vibrationOn = val)),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchRow(String label, bool value, ValueChanged<bool> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 18)),
          GradientSwitch(
            value: value,
            onChanged: onChanged,
            activeGradient: const LinearGradient(
              colors: [Color.fromRGBO(27, 196, 49, 1), Color.fromRGBO(0, 116, 33, 1)],
            ),
            inactiveGradient: const LinearGradient(
              colors: [Color.fromRGBO(205, 205, 205, 1), Color.fromRGBO(105, 105, 105, 1)],
            ),
          ),
        ],
      ),
    );
  }
}