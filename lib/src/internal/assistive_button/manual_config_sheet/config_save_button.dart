import 'package:flutter/material.dart';

Widget saveButton(VoidCallback onTap) {
  final Color accent = Colors.blue;

  return Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 20),
    child: Material(
      color: accent,
      borderRadius: BorderRadius.circular(20),
      elevation: 3,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          height: 64,
          alignment: Alignment.center,
          child: const Text(
            "Salvar",
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    ),
  );
}
