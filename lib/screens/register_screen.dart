import 'package:cobain_dulu/utils/validator.dart';
import 'package:cobain_dulu/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback onRegisterSuccess;
  final VoidCallback onBackToLogin;

  const RegisterScreen({
    super.key,
    required this.onRegisterSuccess,
    required this.onBackToLogin,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _agreeToTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please agree to Terms & Conditions')),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulasi register delay
      await Future.delayed(const Duration(seconds: 2));

      setState(() => _isLoading = false);

      // Panggil callback sukses
      widget.onRegisterSuccess();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.primary,
              theme.colorScheme.primaryContainer,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo & Title
                  _buildHeader(theme),
                  const SizedBox(height: 32),

                  // Register Card
                  _buildRegisterCard(theme, size),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.person_add,
            size: 60,
            color: theme.colorScheme.onPrimary,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Create Account',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Join Ads Admin Platform',
          style: TextStyle(
            fontSize: 16,
            color: theme.colorScheme.onPrimary.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterCard(ThemeData theme, Size size) {
    return Container(
      width: size.width > 400 ? 400 : double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Get Started',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Create your account to continue',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // Full Name Field
            CustomInput(
              controller: _nameController,
              labelText: 'Full Name',
              hintText: 'Enter your full name',
              prefixIcon: const Icon(Icons.person_outlined),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                if (value.length < 3) {
                  return 'Name must be at least 3 characters';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),

            // Email Field
            CustomInput(
              controller: _emailController,
              labelText: 'Email',
              hintText: 'Enter your email',
              keyboardType: TextInputType.emailAddress,
              prefixIcon: const Icon(Icons.email_outlined),
              validator: (value) => Validator.email(value),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),

            // Password Field
            CustomPasswordInput(
              controller: _passwordController,
              labelText: 'Password',
              hintText: 'Enter your password',
              validator: (value) => Validator.password(value),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),

            // Confirm Password Field
            CustomPasswordInput(
              controller: _confirmPasswordController,
              labelText: 'Confirm Password',
              hintText: 'Re-enter your password',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }
                if (value != _passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _handleRegister(),
            ),
            const SizedBox(height: 16),

            // Terms & Conditions
            Row(
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: Checkbox(
                    value: _agreeToTerms,
                    onChanged: (value) {
                      setState(() => _agreeToTerms = value ?? false);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: 'I agree to the ',
                      style: theme.textTheme.bodySmall,
                      children: [
                        TextSpan(
                          text: 'Terms & Conditions',
                          style: TextStyle(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Register Button
            CustomButton(
              text: 'Create Account',
              onPressed: _handleRegister,
              variant: CustomButtonVariant.primary,
              size: CustomButtonSize.large,
              isFullWidth: true,
              isLoading: _isLoading,
            ),
            const SizedBox(height: 24),

            // Divider
            Row(
              children: [
                Expanded(child: Divider(color: theme.colorScheme.outline)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'or sign up with',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                Expanded(child: Divider(color: theme.colorScheme.outline)),
              ],
            ),
            const SizedBox(height: 24),

            // Social Register
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Google',
                    onPressed: () {},
                    variant: CustomButtonVariant.outlined,
                    size: CustomButtonSize.medium,
                    leadingIcon: Icons.g_mobiledata,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomButton(
                    text: 'Apple',
                    onPressed: () {},
                    variant: CustomButtonVariant.outlined,
                    size: CustomButtonSize.medium,
                    leadingIcon: Icons.apple,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Back to Login
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account? ',
                  style: theme.textTheme.bodyMedium,
                ),
                CustomButton(
                  text: 'Sign In',
                  onPressed: widget.onBackToLogin,
                  variant: CustomButtonVariant.text,
                  size: CustomButtonSize.small,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
