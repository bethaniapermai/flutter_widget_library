import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _isLoading = false;
  String? _errorMsg;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isLoading = true;
      _errorMsg = null;
    });
    final success = await AuthService.login(_userCtrl.text.trim(), _passCtrl.text);
    if (!mounted) return;
    if (success) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const DashboardScreen()));
    } else {
      setState(() {
        _isLoading = false;
        _errorMsg = 'Invalid username or password.';
      });
    }
  }

  @override
  void dispose() {
    _userCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 60),
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppTheme.primary, Color(0xFF8B5CF6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.widgets_rounded,
                    size: 56, color: Colors.white),
              ),
              const SizedBox(height: 28),
              const Text('Welcome',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textDarkLight)),
              const SizedBox(height: 6),
              const Text('Sign in to explore the widget library',
                  style: TextStyle(fontSize: 14, color: AppTheme.textLight)),
              const SizedBox(height: 36),
              // Form Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.07),
                        blurRadius: 16,
                        offset: const Offset(0, 4))
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        label: 'Username',
                        hint: 'Enter your username',
                        prefixIcon: Icons.person_outline,
                        controller: _userCtrl,
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Username is required' : null,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Password',
                        hint: 'Enter your password',
                        prefixIcon: Icons.lock_outline,
                        isPassword: true,
                        controller: _passCtrl,
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Password is required' : null,
                      ),
                      if (_errorMsg != null) ...[
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppTheme.error.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.error_outline,
                                  color: AppTheme.error, size: 18),
                              const SizedBox(width: 8),
                              Text(_errorMsg!,
                                  style: const TextStyle(
                                      color: AppTheme.error, fontSize: 13)),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: 24),
                      CustomButton(
                        label: 'Sign In',
                        fullWidth: true,
                        icon: Icons.login,
                        isLoading: _isLoading,
                        onPressed: _login,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Hint
            ],
          ),
        ),
      ),
    );
  }
}