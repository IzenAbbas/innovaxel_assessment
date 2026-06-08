import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../auth/view_models/auth_view_model.dart';
import '../../../core/theme/theme_provider.dart';
import '../view_models/expense_view_model.dart';
import 'widgets/add_expense_sheet.dart';
import 'widgets/confirm_dialog.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/date_formatter.dart';
import 'summary_screen.dart';
import '../../../core/theme/colors.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    if (userId.isNotEmpty) {
      context.read<ExpenseViewModel>().listenToExpenses(userId);
    }
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return ConfirmDialog(
          title: 'Confirm Log Out',
          content:
              'Are you sure you want to log out of your account? You will need to re-authenticate to access your dashboard.',
          confirmText: 'Log Out',
          isDestructive: true,
          onConfirm: () async {
            await context.read<AuthViewModel>().logout();
          },
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context, String expenseId) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return ConfirmDialog(
          title: 'Delete Expense',
          content:
              'Are you sure you want to delete this expense? This action cannot be undone.',
          confirmText: 'Delete',
          isDestructive: true,
          onConfirm: () async {
            final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
            final success = await context
                .read<ExpenseViewModel>()
                .deleteExpense(userId, expenseId);
            if (!success && context.mounted) {
              final error =
                  context.read<ExpenseViewModel>().errorMessage ??
                  'Failed to delete expense';
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(error)));
            }
          },
        );
      },
    );
  }

  Widget _buildDashboard(BuildContext context, bool isDark) {
    final theme = Theme.of(context);
    final cardBg = theme.colorScheme.surface;
    final textPrimary = theme.colorScheme.onSurface;
    final textSecondary = AppColors.textSecondary(isDark);
    final iconBg = AppColors.iconBg(isDark);
    final shadowColor = AppColors.shadow(isDark);

    final expenseViewModel = context.watch<ExpenseViewModel>();
    final expenses = expenseViewModel.expenses;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Expenses',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            CurrencyFormatter.formatPKR(expenseViewModel.totalExpenses),
            style: GoogleFonts.manrope(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 32),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'All Expenses',
                style: GoogleFonts.manrope(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          if (expenses.isEmpty) ...[
            const SizedBox(height: 20),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.account_balance_wallet_outlined,
                    size: 64,
                    color: AppColors.divider(isDark),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No Expenses Yet',
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Tap the + button to add your first expense.',
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
            ...List.generate(expenses.length, (index) {
              final expense = expenses[index];
              final showHeader =
                  index == 0 ||
                  DateFormatter.formatDate(expenses[index - 1].dateTime) !=
                      DateFormatter.formatDate(expense.dateTime);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showHeader) ...[
                    if (index > 0) const SizedBox(height: 16),
                    _buildDateHeader(
                      DateFormatter.formatDate(expense.dateTime),
                      textSecondary,
                    ),
                    const SizedBox(height: 12),
                  ],
                  _buildTransactionItem(
                    icon: expense.getIcon(),
                    title: expense.title,
                    subtitle: expense.category,
                    notes: expense.notes,
                    amount: '-${CurrencyFormatter.formatPKR(expense.amount)}',
                    time: DateFormatter.formatTime(expense.dateTime),
                    isDark: isDark,
                    cardBg: cardBg,
                    textPrimary: textPrimary,
                    textSecondary: textSecondary,
                    iconBg: iconBg,
                    shadowColor: shadowColor,
                    theme: theme,
                    onEdit: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => AddExpenseSheet(expense: expense),
                      );
                    },
                    onDelete: () => _showDeleteDialog(context, expense.id),
                  ),
                  if (index < expenses.length - 1) const SizedBox(height: 12),
                ],
              );
            }),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildDateHeader(String date, Color color) {
    return Text(
      date,
      style: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildTransactionItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String? notes,
    required String amount,
    required String time,
    required bool isDark,
    required Color cardBg,
    required Color textPrimary,
    required Color textSecondary,
    required Color iconBg,
    required Color shadowColor,
    required ThemeData theme,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) {
    return Container(
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
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: theme.colorScheme.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.manrope(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(fontSize: 12, color: textSecondary),
                ),
                if (notes != null && notes.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    notes,
                    style: GoogleFonts.inter(
                      fontSize: 9,
                      fontStyle: FontStyle.italic,
                      color: textSecondary.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: theme.colorScheme.error,
                ),
              ),
              Text(
                time,
                style: GoogleFonts.inter(fontSize: 11, color: textSecondary),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, size: 18),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: onEdit,
                    color: textSecondary,
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 18),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: onDelete,
                    color: theme.colorScheme.error,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final theme = Theme.of(context);
    final isDark = themeProvider.isDarkMode;

    final List<Widget> screens = [
      _buildDashboard(context, isDark),
      const SummaryScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          _selectedIndex == 0 ? 'Innovaxel Expenses' : 'Expense Summary',
          style: GoogleFonts.manrope(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.onSurface,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
              color: theme.colorScheme.onSurface,
            ),
            onPressed: () {
              themeProvider.toggleTheme(!isDark);
            },
          ),
          IconButton(
            icon: Icon(Icons.logout, color: theme.colorScheme.error),
            onPressed: () => _showLogoutDialog(context),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: IndexedStack(index: _selectedIndex, children: screens),
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const AddExpenseSheet(),
                );
              },
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.divider(isDark), width: 1.0),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          backgroundColor: theme.scaffoldBackgroundColor,
          selectedItemColor: theme.colorScheme.primary,
          unselectedItemColor: AppColors.textSecondary(isDark),
          selectedLabelStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          unselectedLabelStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart_outline),
              activeIcon: Icon(Icons.pie_chart),
              label: 'Summary',
            ),
          ],
        ),
      ),
    );
  }
}
