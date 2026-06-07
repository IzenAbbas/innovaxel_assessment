import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../view_models/expense_view_model.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../data/models/expense.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = themeProvider.isDarkMode;

    final cardBg = isDark ? const Color(0xFF131B2E) : Colors.white;
    final textPrimary = isDark ? const Color(0xFFDAE2FD) : const Color(0xFF111C2D);
    final textSecondary = isDark ? const Color(0xFFC3C5D9) : const Color(0xFF45464D);
    final iconBg = isDark ? const Color(0xFF222A3D) : const Color(0xFFF0F3FF);
    final shadowColor = isDark
        ? Colors.black.withValues(alpha: 0.2)
        : const Color(0xFF0F172A).withValues(alpha: 0.05);

    final expenseViewModel = context.watch<ExpenseViewModel>();
    final expenses = expenseViewModel.expenses;
    final total = expenseViewModel.totalExpenses;

    
    final Map<String, double> categoryTotals = {};
    final Map<String, Expense> categorySampleExpenses = {};

    for (final expense in expenses) {
      final key = expense.category;
      categoryTotals[key] = (categoryTotals[key] ?? 0.0) + expense.amount;
      if (!categorySampleExpenses.containsKey(key)) {
        categorySampleExpenses[key] = expense;
      }
    }

    
    final sortedCategories = categoryTotals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Summary',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            CurrencyFormatter.formatPKR(total),
            style: GoogleFonts.manrope(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Expenses by Category',
            style: GoogleFonts.manrope(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: textPrimary,
            ),
          ),
          const SizedBox(height: 20),
          if (sortedCategories.isEmpty) ...[
            const SizedBox(height: 20),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.pie_chart_outline,
                    size: 64,
                    color: isDark ? const Color(0xFF222A3D) : const Color(0xFFE5E7EB),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No Summary Data',
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Add expenses to see the category breakdown.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ] else
            ...sortedCategories.map((entry) {
              final categoryName = entry.key;
              final categoryTotal = entry.value;
              final percentage = total > 0 ? (categoryTotal / total) : 0.0;
              final sampleExpense = categorySampleExpenses[categoryName];
              final icon = sampleExpense?.getIcon() ?? Icons.monetization_on_outlined;

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor,
                      blurRadius: 15,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: iconBg,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            icon,
                            color: isDark ? const Color(0xFFB7C4FF) : const Color(0xFF111C2D),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                categoryName,
                                style: GoogleFonts.manrope(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: textPrimary,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${(percentage * 100).toStringAsFixed(1)}% of total',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          CurrencyFormatter.formatPKR(categoryTotal),
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: percentage,
                        backgroundColor: isDark ? const Color(0xFF222A3D) : const Color(0xFFE5E7EB),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isDark ? const Color(0xFFB7C4FF) : const Color(0xFF111827),
                        ),
                        minHeight: 6,
                      ),
                    ),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }
}
