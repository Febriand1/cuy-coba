import 'package:flutter/material.dart';

/// Enum untuk variant button
enum CustomButtonVariant { primary, secondary, outlined, text, danger }

/// Enum untuk ukuran button
enum CustomButtonSize { small, medium, large }

/// Custom button dengan styling konsisten
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final CustomButtonVariant variant;
  final CustomButtonSize size;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final bool isLoading;
  final bool isFullWidth;
  final bool disabled;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = CustomButtonVariant.primary,
    this.size = CustomButtonSize.medium,
    this.leadingIcon,
    this.trailingIcon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Size configurations
    final EdgeInsetsGeometry padding;
    final double fontSize;
    final double iconSize;
    final double height;

    switch (size) {
      case CustomButtonSize.small:
        padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
        fontSize = 12;
        iconSize = 16;
        height = 36;
        break;
      case CustomButtonSize.medium:
        padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 12);
        fontSize = 14;
        iconSize = 18;
        height = 48;
        break;
      case CustomButtonSize.large:
        padding = const EdgeInsets.symmetric(horizontal: 28, vertical: 16);
        fontSize = 16;
        iconSize = 20;
        height = 56;
        break;
    }

    // Build button content
    Widget buttonContent = Row(
      mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) ...[
          SizedBox(
            width: iconSize,
            height: iconSize,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: _getContentColor(theme),
            ),
          ),
          const SizedBox(width: 8),
        ] else if (leadingIcon != null) ...[
          Icon(leadingIcon, size: iconSize),
          const SizedBox(width: 8),
        ],
        Text(
          text,
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
        ),
        if (trailingIcon != null && !isLoading) ...[
          const SizedBox(width: 8),
          Icon(trailingIcon, size: iconSize),
        ],
      ],
    );

    // Build button based on variant
    final bool isDisabled = disabled || isLoading;

    switch (variant) {
      case CustomButtonVariant.primary:
        return SizedBox(
          width: isFullWidth ? double.infinity : null,
          height: height,
          child: ElevatedButton(
            onPressed: isDisabled ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              padding: padding,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: buttonContent,
          ),
        );

      case CustomButtonVariant.secondary:
        return SizedBox(
          width: isFullWidth ? double.infinity : null,
          height: height,
          child: ElevatedButton(
            onPressed: isDisabled ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.secondaryContainer,
              foregroundColor: theme.colorScheme.onSecondaryContainer,
              padding: padding,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: buttonContent,
          ),
        );

      case CustomButtonVariant.outlined:
        return SizedBox(
          width: isFullWidth ? double.infinity : null,
          height: height,
          child: OutlinedButton(
            onPressed: isDisabled ? null : onPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: theme.colorScheme.primary,
              padding: padding,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              side: BorderSide(
                color: isDisabled
                    ? theme.colorScheme.outline.withValues(alpha: 0.5)
                    : theme.colorScheme.primary,
              ),
            ),
            child: buttonContent,
          ),
        );

      case CustomButtonVariant.text:
        return SizedBox(
          width: isFullWidth ? double.infinity : null,
          height: height,
          child: TextButton(
            onPressed: isDisabled ? null : onPressed,
            style: TextButton.styleFrom(
              foregroundColor: theme.colorScheme.primary,
              padding: padding,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: buttonContent,
          ),
        );

      case CustomButtonVariant.danger:
        return SizedBox(
          width: isFullWidth ? double.infinity : null,
          height: height,
          child: ElevatedButton(
            onPressed: isDisabled ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.error,
              foregroundColor: theme.colorScheme.onError,
              padding: padding,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: buttonContent,
          ),
        );
    }
  }

  Color _getContentColor(ThemeData theme) {
    switch (variant) {
      case CustomButtonVariant.primary:
        return theme.colorScheme.onPrimary;
      case CustomButtonVariant.secondary:
        return theme.colorScheme.onSecondaryContainer;
      case CustomButtonVariant.outlined:
      case CustomButtonVariant.text:
        return theme.colorScheme.primary;
      case CustomButtonVariant.danger:
        return theme.colorScheme.onError;
    }
  }
}

/// Custom icon button dengan styling konsisten
class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final CustomButtonVariant variant;
  final CustomButtonSize size;
  final String? tooltip;
  final bool disabled;

  const CustomIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.variant = CustomButtonVariant.primary,
    this.size = CustomButtonSize.medium,
    this.tooltip,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Size configurations
    final double iconSize;
    final double buttonSize;

    switch (size) {
      case CustomButtonSize.small:
        iconSize = 18;
        buttonSize = 36;
        break;
      case CustomButtonSize.medium:
        iconSize = 22;
        buttonSize = 44;
        break;
      case CustomButtonSize.large:
        iconSize = 26;
        buttonSize = 52;
        break;
    }

    Color backgroundColor;
    Color iconColor;

    switch (variant) {
      case CustomButtonVariant.primary:
        backgroundColor = theme.colorScheme.primary;
        iconColor = theme.colorScheme.onPrimary;
        break;
      case CustomButtonVariant.secondary:
        backgroundColor = theme.colorScheme.secondaryContainer;
        iconColor = theme.colorScheme.onSecondaryContainer;
        break;
      case CustomButtonVariant.outlined:
        backgroundColor = Colors.transparent;
        iconColor = theme.colorScheme.primary;
        break;
      case CustomButtonVariant.text:
        backgroundColor = Colors.transparent;
        iconColor = theme.colorScheme.primary;
        break;
      case CustomButtonVariant.danger:
        backgroundColor = theme.colorScheme.error;
        iconColor = theme.colorScheme.onError;
        break;
    }

    final button = Container(
      width: buttonSize,
      height: buttonSize,
      decoration: BoxDecoration(
        color: disabled
            ? backgroundColor.withValues(alpha: 0.5)
            : backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: variant == CustomButtonVariant.outlined
            ? Border.all(
                color: disabled
                    ? theme.colorScheme.outline.withValues(alpha: 0.5)
                    : theme.colorScheme.primary,
              )
            : null,
      ),
      child: IconButton(
        onPressed: disabled ? null : onPressed,
        icon: Icon(
          icon,
          size: iconSize,
          color: disabled ? iconColor.withValues(alpha: 0.5) : iconColor,
        ),
        padding: EdgeInsets.zero,
      ),
    );

    if (tooltip != null) {
      return Tooltip(message: tooltip!, child: button);
    }

    return button;
  }
}

/// Floating Action Button dengan styling konsisten
class CustomFab extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String? label;
  final bool isExtended;
  final bool mini;

  const CustomFab({
    super.key,
    required this.icon,
    this.onPressed,
    this.label,
    this.isExtended = false,
    this.mini = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isExtended && label != null) {
      return FloatingActionButton.extended(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(label!),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      );
    }

    return FloatingActionButton(
      onPressed: onPressed,
      mini: mini,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Icon(icon),
    );
  }
}
