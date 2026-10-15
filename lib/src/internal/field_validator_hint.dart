import 'package:flutter/material.dart';

class FieldValidatorHint extends StatelessWidget {
  const FieldValidatorHint({required this.hintText, required this.isValid, super.key});

  final String hintText;
  final bool isValid;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: isValid ? Colors.green : Colors.transparent,
            border:
                isValid
                    ? Border.all(color: Colors.transparent)
                    : Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Center(child: Icon(Icons.check, color: Colors.white, size: 16)),
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(hintText)),
      ],
    );
  }
}
