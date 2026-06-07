import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../view_models/auth_view_model.dart';
import 'widgets/auth_text_field.dart';
import 'widgets/auth_button.dart';
import '../../home/views/home.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _signup() async {
    final viewModel = context.read<AuthViewModel>();
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    final success = await viewModel.signUp(name, email, password);
    if (success && mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('Verify Email'),
          content: Text('A verification link has been sent to $email. Please check your inbox.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else if (mounted && viewModel.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(viewModel.errorMessage!)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AuthViewModel>().isLoading;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Innovaxel Finance',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF111827),
                  ),
                ),
              ),
              const SizedBox(height: 48),
              Text(
                'Create your account',
                style: GoogleFonts.inter(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF111827),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Start your journey toward financial clarity and precision today.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: const Color(0xFF4B5563),
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    AuthTextField(
                      controller: _nameController,
                      label: 'FULL NAME',
                      hintText: 'John Doe',
                    ),
                    const SizedBox(height: 24),
                    AuthTextField(
                      controller: _emailController,
                      label: 'EMAIL ADDRESS',
                      hintText: 'name@company.com',
                    ),
                    const SizedBox(height: 24),
                    AuthTextField(
                      controller: _passwordController,
                      label: 'PASSWORD',
                      hintText: '••••••••',
                      isPassword: true,
                    ),
                    const SizedBox(height: 24),
                    AuthTextField(
                      controller: _confirmPasswordController,
                      label: 'CONFIRM PASSWORD',
                      hintText: '••••••••',
                      isPassword: true,
                    ),
                    const SizedBox(height: 32),
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : AuthButton(
                            text: 'Create Account',
                            showArrow: false,
                            onPressed: _signup,
                          ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        const Expanded(child: Divider(color: Color(0xFFE5E7EB))),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'OR',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF9CA3AF),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        const Expanded(child: Divider(color: Color(0xFFE5E7EB))),
                      ],
                    ),
                    const SizedBox(height: 32),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF4B5563),
                            fontSize: 15,
                          ),
                          children: [
                            TextSpan(
                              text: 'Log In',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF111827),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
