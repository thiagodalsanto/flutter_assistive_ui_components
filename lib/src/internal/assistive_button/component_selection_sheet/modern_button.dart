// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

Widget modernButton(
  BuildContext context, {
  required String label,
  required IconData icon,
  required VoidCallback onTap,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          height: 72,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, size: 28, color: Colors.blue),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 18),
            ],
          ),
        ),
      ),
    ),
  );
}
