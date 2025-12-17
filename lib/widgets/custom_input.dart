import 'package:flutter/material.dart';

/// Custom text input field dengan styling konsisten
class CustomInput extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final bool enabled;
  final int maxLines;
  final int? maxLength;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final bool autofocus;
  final EdgeInsetsGeometry? contentPadding;

  const CustomInput({
    super.key,
    this.labelText,
    this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.focusNode,
    this.textInputAction,
    this.autofocus = false,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      enabled: enabled,
      maxLines: maxLines,
      maxLength: maxLength,
      focusNode: focusNode,
      textInputAction: textInputAction,
      autofocus: autofocus,
      style: TextStyle(color: theme.colorScheme.onSurface),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding:
            contentPadding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.colorScheme.error, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.5),
          ),
        ),
        filled: true,
        fillColor: enabled
            ? theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3)
            : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.1),
      ),
    );
  }
}

/// Custom password input dengan toggle visibility
class CustomPasswordInput extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final bool enabled;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;

  const CustomPasswordInput({
    super.key,
    this.labelText,
    this.hintText,
    this.controller,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.focusNode,
    this.textInputAction,
  });

  @override
  State<CustomPasswordInput> createState() => _CustomPasswordInputState();
}

class _CustomPasswordInputState extends State<CustomPasswordInput> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return CustomInput(
      labelText: widget.labelText,
      hintText: widget.hintText,
      controller: widget.controller,
      obscureText: !_isPasswordVisible,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      enabled: widget.enabled,
      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction,
      prefixIcon: const Icon(Icons.lock_outlined),
      suffixIcon: IconButton(
        icon: Icon(
          _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
        ),
        onPressed: () {
          setState(() => _isPasswordVisible = !_isPasswordVisible);
        },
      ),
    );
  }
}

/// Custom search input
class CustomSearchInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final VoidCallback? onClear;

  const CustomSearchInput({
    super.key,
    this.controller,
    this.hintText = 'Search...',
    this.onChanged,
    this.onSubmitted,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInput(
      controller: controller,
      hintText: hintText,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      textInputAction: TextInputAction.search,
      prefixIcon: const Icon(Icons.search),
      suffixIcon: controller != null && controller!.text.isNotEmpty
          ? IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                controller?.clear();
                onClear?.call();
              },
            )
          : null,
    );
  }
}
