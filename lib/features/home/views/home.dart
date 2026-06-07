import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../auth/view_models/auth_view_model.dart';
import '../../../core/theme/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: isDark ? const Color(0xFF131B2E) : Colors.white,
          title: Text(
            'Confirm Log Out',
            style: GoogleFonts.manrope(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: isDark ? const Color(0xFFDAE2FD) : const Color(0xFF111C2D),
            ),
          ),
          content: Text(
            'Are you sure you want to log out of your account? You will need to re-authenticate to access your wealth management dashboard.',
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
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: isDark
                      ? const Color(0xFFB7C4FF)
                      : const Color(0xFF111C2D),
                ),
              ),
            ),
            
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isDark
                    ? const Color(0xFF93000a)
                    : const Color(0xFFBA1A1A),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
              ),
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                await context.read<AuthViewModel>().logout();
              },
              child: Text(
                'Log Out',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDashboard(BuildContext context, bool isDark) {
    final cardBg = isDark ? const Color(0xFF131B2E) : Colors.white;
    final textPrimary = isDark
        ? const Color(0xFFDAE2FD)
        : const Color(0xFF111C2D);
    final textSecondary = isDark
        ? const Color(0xFFC3C5D9)
        : const Color(0xFF45464D);
    final iconBg = isDark ? const Color(0xFF222A3D) : const Color(0xFFF0F3FF);
    final shadowColor = isDark
        ? Colors.black.withValues(alpha: 0.2)
        : const Color(0xFF0F172A).withValues(alpha: 0.05);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Text(
            'Total Balance',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '4,250.00 PKR',
            style: GoogleFonts.manrope(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 24),

          
          _buildSummaryCard(
            icon: Icons.trending_down,
            title: 'SPENT THIS MONTH',
            value: '1,120.45 PKR',
            isDark: isDark,
            cardBg: cardBg,
            textPrimary: textPrimary,
            textSecondary: textSecondary,
            iconBg: iconBg,
            shadowColor: shadowColor,
          ),
          const SizedBox(height: 16),
          _buildSummaryCard(
            icon: Icons.savings_outlined,
            title: 'SAVINGS TARGET',
            value: '5,000.00 PKR',
            isDark: isDark,
            cardBg: cardBg,
            textPrimary: textPrimary,
            textSecondary: textSecondary,
            iconBg: iconBg,
            shadowColor: shadowColor,
          ),
          const SizedBox(height: 32),

          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Activity',
                style: GoogleFonts.manrope(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: textPrimary,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'VIEW ALL',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: textSecondary,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          
          _buildDateHeader('OCT 24, 2023', textSecondary),
          const SizedBox(height: 12),
          _buildTransactionItem(
            icon: Icons.local_cafe_outlined,
            title: 'Starbucks',
            subtitle: 'Morning Coffee',
            amount: '-5.50 PKR',
            time: '08:45 AM',
            isNegative: true,
            isDark: isDark,
            cardBg: cardBg,
            textPrimary: textPrimary,
            textSecondary: textSecondary,
            iconBg: iconBg,
            shadowColor: shadowColor,
          ),
          const SizedBox(height: 12),
          _buildTransactionItem(
            icon: Icons.directions_car_filled_outlined,
            title: 'Shell Gas',
            subtitle: 'Transportation',
            amount: '-52.10 PKR',
            time: '01:20 PM',
            isNegative: true,
            isDark: isDark,
            cardBg: cardBg,
            textPrimary: textPrimary,
            textSecondary: textSecondary,
            iconBg: iconBg,
            shadowColor: shadowColor,
          ),
          const SizedBox(height: 24),

          
          _buildDateHeader('OCT 23, 2023', textSecondary),
          const SizedBox(height: 12),
          _buildTransactionItem(
            icon: Icons.receipt_long_outlined,
            title: 'Electric Bill',
            subtitle: 'Utilities',
            amount: '-142.00 PKR',
            time: '10:05 AM',
            isNegative: true,
            isDark: isDark,
            cardBg: cardBg,
            textPrimary: textPrimary,
            textSecondary: textSecondary,
            iconBg: iconBg,
            shadowColor: shadowColor,
          ),
          const SizedBox(height: 12),
          _buildTransactionItem(
            icon: Icons.payments_outlined,
            title: 'Monthly Salary',
            subtitle: 'Deposit',
            amount: '+3,200.00 PKR',
            time: '09:00 AM',
            isNegative: false,
            isDark: isDark,
            cardBg: cardBg,
            textPrimary: textPrimary,
            textSecondary: textSecondary,
            iconBg: iconBg,
            shadowColor: shadowColor,
          ),
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

  Widget _buildSummaryCard({
    required IconData icon,
    required String title,
    required String value,
    required bool isDark,
    required Color cardBg,
    required Color textPrimary,
    required Color textSecondary,
    required Color iconBg,
    required Color shadowColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: isDark ? const Color(0xFFB7C4FF) : const Color(0xFF111C2D),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: textSecondary,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: GoogleFonts.manrope(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String amount,
    required String time,
    required bool isNegative,
    required bool isDark,
    required Color cardBg,
    required Color textPrimary,
    required Color textSecondary,
    required Color iconBg,
    required Color shadowColor,
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
            child: Icon(
              icon,
              color: isDark ? const Color(0xFFB7C4FF) : const Color(0xFF111C2D),
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.manrope(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(fontSize: 13, color: textSecondary),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: isNegative
                      ? (isDark
                            ? const Color(0xFFFFB4AB)
                            : const Color(0xFFBA1A1A))
                      : (isDark
                            ? const Color(0xFF7DF4FF)
                            : const Color(0xFF38485D)),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                time,
                style: GoogleFonts.inter(fontSize: 12, color: textSecondary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInsightsPlaceholder(bool isDark) {
    final textPrimary = isDark
        ? const Color(0xFFDAE2FD)
        : const Color(0xFF111C2D);
    final textSecondary = isDark
        ? const Color(0xFFC3C5D9)
        : const Color(0xFF45464D);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.donut_large,
              size: 72,
              color: isDark ? const Color(0xFFB7C4FF) : const Color(0xFF111C2D),
            ),
            const SizedBox(height: 24),
            Text(
              'Financial Insights',
              style: GoogleFonts.manrope(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your spending breakdowns, saving metrics, and personalized advice will appear here.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 15,
                color: textSecondary,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          'Innovaxel Finance',
          style: GoogleFonts.manrope(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: isDark ? const Color(0xFFDAE2FD) : const Color(0xFF111C2D),
          ),
        ),
        actions: [
          
          IconButton(
            icon: Icon(
              isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
              color: isDark ? const Color(0xFFDAE2FD) : const Color(0xFF111C2D),
            ),
            onPressed: () {
              themeProvider.toggleTheme(!isDark);
            },
          ),
          
          IconButton(
            icon: Icon(
              Icons.logout,
              color: isDark ? const Color(0xFFFFB4AB) : const Color(0xFFBA1A1A),
            ),
            onPressed: () => _showLogoutDialog(context),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: [
            _buildDashboard(context, isDark),
            _buildInsightsPlaceholder(isDark),
          ],
        ),
      ),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              backgroundColor: isDark
                  ? const Color(0xFFB7C4FF)
                  : const Color(0xFF111827),
              foregroundColor: isDark ? const Color(0xFF002682) : Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onPressed: () {},
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: isDark ? const Color(0xFF2D3449) : const Color(0xFFE5E7EB),
              width: 1,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          backgroundColor: isDark ? const Color(0xFF0B1326) : Colors.white,
          selectedItemColor: isDark
              ? const Color(0xFFB7C4FF)
              : const Color(0xFF111827),
          unselectedItemColor: isDark
              ? const Color(0xFF8D90a2)
              : const Color(0xFF9CA3AF),
          selectedLabelStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          unselectedLabelStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.donut_large_sharp),
              label: 'Insights',
            ),
          ],
        ),
      ),
    );
  }
}
