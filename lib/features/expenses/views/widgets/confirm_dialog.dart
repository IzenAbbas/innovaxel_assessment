import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final bool isDestructive;

  const ConfirmDialog({
    super.key,
    required this.title,
    required this.content,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    required this.onConfirm,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final confirmColor = isDestructive
        ? (isDark ? const Color(0xFF93000a) : const Color(0xFFBA1A1A))
        : (isDark ? const Color(0xFFB7C4FF) : const Color(0xFF111827));

    final confirmTextColor = isDestructive
        ? Colors.white
        : (isDark ? const Color(0xFF002682) : Colors.white);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: isDark ? const Color(0xFF131B2E) : Colors.white,
      title: Text(
        title,
        style: GoogleFonts.manrope(
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: isDark ? const Color(0xFFDAE2FD) : const Color(0xFF111C2D),
        ),
      ),
      content: Text(
        content,
        style: GoogleFonts.inter(
          fontSize: 14,
          height: 1.5,
          color: isDark ? const Color(0xFFC3C5D9) : const Color(0xFF45464D),
        ),
      ),
      actionsPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            cancelText,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: isDark ? const Color(0xFFB7C4FF) : const Color(0xFF111C2D),
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: confirmColor,
            foregroundColor: confirmTextColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          child: Text(
            confirmText,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
