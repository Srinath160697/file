import 'package:flutter/material.dart';

class StyledTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;

  const StyledTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(
          color: Colors.black, // input text color
        ),
        cursorColor: Colors.black12,
        decoration: InputDecoration(
          labelText: labelText,

          /// label color
          labelStyle: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),

          /// DARK background
          filled: true,
          fillColor: const Color.fromARGB(255, 242, 238, 238),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 18),

          /// normal border
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1.2,
            ),
          ),

          /// focus border (highlight)
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Colors.black54,
              width: 2,
            ),
          ),

          /// error border (optional)
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Colors.redAccent,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
