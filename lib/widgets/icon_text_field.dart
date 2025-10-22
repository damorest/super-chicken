import 'package:flutter/material.dart';

class IconTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String iconPath;

  const IconTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white, fontSize: 18),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Image.asset(
            iconPath,
            color: Colors.white,
          ),
        ),
        suffixIconConstraints: const BoxConstraints(
          minWidth: 20,
          minHeight: 20,
          maxWidth: 40,
          maxHeight: 40,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white54),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white),
        ),
        fillColor: const Color(0xFFFF6CD8),
        filled: true,
      ),
    );
  }
}
