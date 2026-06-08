import 'package:flutter/material.dart';

class AppColors {

  static Color inputBg(bool isDark) => isDark ? const Color(0xFF1E293B) : const Color(0xFFF3F4F6);
  static Color iconBg(bool isDark) => isDark ? const Color(0xFF222A3D) : const Color(0xFFF0F3FF);


  static Color textSecondary(bool isDark) => isDark ? const Color(0xFFC3C5D9) : const Color(0xFF45464D);
  static Color hintText(bool isDark) => isDark ? const Color(0xFF4B5563) : const Color(0xFF9CA3AF);
  

  static Color errorBg(bool isDark) => isDark ? const Color(0xFF93000a) : const Color(0xFFBA1A1A);


  static Color divider(bool isDark) => isDark ? const Color(0xFF222A3D) : const Color(0xFFE5E7EB);
  

  static Color shadow(bool isDark) => isDark 
      ? Colors.black.withValues(alpha: 0.2) 
      : const Color(0xFF0F172A).withValues(alpha: 0.05);
}
