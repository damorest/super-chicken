import 'package:flutter/material.dart';
import 'package:media_test/widgets/base_screen.dart';
import 'package:media_test/widgets/components/app_button.dart';
import 'package:provider/provider.dart';
import '../../services/settings_service.dart';
import '../../widgets/icon_text_field.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  String? _avatarPath;

  @override
  void initState() {
    super.initState();
    final settings = context.read<SettingsService>();
    _usernameController = TextEditingController(text: settings.username);
    _emailController = TextEditingController(text: settings.email);
    _avatarPath = settings.avatarPath.isNotEmpty ? settings.avatarPath : null;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _saveProfile() async {
    final settings = context.read<SettingsService>();

    await settings.saveSettings(
      sound: null,
      notification: null,
      vibration: null,
    );

    await settings.setUsername(_usernameController.text);
    await settings.setEmail(_emailController.text);

    if (_avatarPath != null) await settings.setAvatarPath(_avatarPath!);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile saved!')),
    );
  }



  void _showEditAvatarDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return FractionallySizedBox(
          widthFactor: 1,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/dialog_bg.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'PLEASE MAKE YOUR CHOICE',
                    style: TextStyle(
                      fontFamily: 'Fredoka',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () {
                              // TODO: input camera
                            },
                            child: const Text(
                              'MAKE A PHOTO',
                              style: TextStyle(
                                  fontFamily: 'Fredoka',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                              ),
                            ),
                          ),
                        ),
                        const Divider(height: 1, color: Colors.grey),
                        SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: _showChoosePhotoDialog,
                            child: const Text(
                              'CHOOSE PHOTO',
                              style: TextStyle(
                                  fontFamily: 'Fredoka',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                SizedBox(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    child: const Text(
                      'CANCEL',
                      style: TextStyle(
                          fontFamily: 'Fredoka',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showChoosePhotoDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final avatars = [
          'assets/images/chicken.png',
          'assets/images/avatar_2.png',
        ];
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Choose avatar'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: avatars.map((path) {
                  return GestureDetector(
                    onTap: () async{
                      setState(() {
                        _avatarPath = path.replaceFirst('assets/images/', '');
                      });

                      final settings = context.read<SettingsService>();
                      await settings.setAvatarPath(path);

                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Image.asset(path, width: 80, height: 80),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      showWallet: false,
      width: 0.8,
      title: 'PROFILE',
      bottomChild: AppButton(
        text: 'SAVE',
        width: 220,
        height: 110,
        fontSize: 45,
        onPressed: _saveProfile,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                const AppButton(
                  type: AppButtonType.secondary,
                  text: '',
                  width: 160,
                  height: 160,
                ),
                if (_avatarPath != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset('assets/images/${_avatarPath!}', width: 120, height: 120, fit: BoxFit.cover),
                  ),
                Positioned(
                  bottom: -8,
                  child: ElevatedButton(
                    onPressed: _showEditAvatarDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1BC431),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(32, 32),
                      maximumSize: const Size(32, 32),
                      padding: EdgeInsets.zero,
                    ),
                    child: Image.asset(
                      'assets/images/edit_icon.png',
                      width: 16,
                      height: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            IconTextField(
              controller: _usernameController,
              label: 'Username',
              iconPath: 'assets/images/edit_icon.png',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: IconTextField(
                controller: _emailController,
                label: 'Email',
                iconPath: 'assets/images/edit_icon.png',
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

}

