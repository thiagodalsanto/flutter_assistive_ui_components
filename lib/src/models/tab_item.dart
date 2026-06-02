import 'package:flutter/material.dart';

class TabItem {
  final String label;
  final IconData icon;

  final Color? activeColor;
  final Color? inactiveColor;

  TabItem({required this.label, required this.icon, this.activeColor, this.inactiveColor});
}
