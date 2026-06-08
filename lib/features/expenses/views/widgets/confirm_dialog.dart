import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/colors.dart';

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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final confirmColor = isDestructive
        ? theme.colorScheme.error
        : theme.colorScheme.primary;

    final confirmTextColor = isDestructive
        ? theme.colorScheme.onError
        : theme.colorScheme.onPrimary;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: theme.colorScheme.surface,
      title: Text(
        title,
        style: GoogleFonts.manrope(
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: theme.colorScheme.onSurface,
        ),
      ),
      content: Text(
        content,
        style: GoogleFonts.inter(
          fontSize: 14,
          height: 1.5,
          color: AppColors.textSecondary(isDark),
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
              color: theme.colorScheme.primary,
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
