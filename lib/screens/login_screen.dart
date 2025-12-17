// import 'package:cobain_dulu/utils/validator.dart';
import 'package:cobain_dulu/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onLoginSuccess;
  final VoidCallback? onGoToRegister;

  const LoginScreen({
    super.key,
    required this.onLoginSuccess,
    this.onGoToRegister,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulasi login delay
      await Future.delayed(const Duration(seconds: 2));

      setState(() => _isLoading = false);

      // Panggil callback sukses
      widget.onLoginSuccess();
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
                  const SizedBox(height: 40),

                  // Login Card
                  _buildLoginCard(theme, size),
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
            Icons.ads_click,
            size: 60,
            color: theme.colorScheme.onPrimary,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Ads Admin',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Platform Management System',
          style: TextStyle(
            fontSize: 16,
            color: theme.colorScheme.onPrimary.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginCard(ThemeData theme, Size size) {
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
              'Welcome Back',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Sign in to continue',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // Email Field - Using CustomInput
            CustomInput(
              controller: _emailController,
              labelText: 'Email',
              hintText: 'Enter your email',
              keyboardType: TextInputType.emailAddress,
              prefixIcon: const Icon(Icons.email_outlined),
              // validator: (value) => Validator.email(value),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 20),

            // Password Field - Using CustomPasswordInput
            CustomPasswordInput(
              controller: _passwordController,
              labelText: 'Password',
              hintText: 'Enter your password',
              // validator: (value) => Validator.password(value),
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _handleLogin(),
            ),
            const SizedBox(height: 16),

            // Remember Me & Forgot Password
            _buildRememberForgot(theme),
            const SizedBox(height: 24),

            // Login Button - Using CustomButton
            CustomButton(
              text: 'Sign In',
              onPressed: _handleLogin,
              variant: CustomButtonVariant.primary,
              size: CustomButtonSize.large,
              isFullWidth: true,
              isLoading: _isLoading,
            ),
            const SizedBox(height: 24),

            // Divider
            _buildDivider(theme),
            const SizedBox(height: 24),

            // Social Login - Using CustomButton
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

            // Sign Up Link
            if (widget.onGoToRegister != null) ...[
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: theme.textTheme.bodyMedium,
                  ),
                  CustomButton(
                    text: 'Sign Up',
                    onPressed: widget.onGoToRegister!,
                    variant: CustomButtonVariant.text,
                    size: CustomButtonSize.small,
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRememberForgot(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: Checkbox(
                value: _rememberMe,
                onChanged: (value) {
                  setState(() => _rememberMe = value ?? false);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text('Remember me', style: theme.textTheme.bodyMedium),
          ],
        ),
        CustomButton(
          text: 'Forgot Password?',
          onPressed: () {
            // TODO: Implement forgot password
          },
          variant: CustomButtonVariant.text,
          size: CustomButtonSize.small,
        ),
      ],
    );
  }

  Widget _buildDivider(ThemeData theme) {
    return Row(
      children: [
        Expanded(child: Divider(color: theme.colorScheme.outline)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'or continue with',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(child: Divider(color: theme.colorScheme.outline)),
      ],
    );
  }
}
