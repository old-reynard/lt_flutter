import 'package:flutter/material.dart';

const _borderRadius = 28.0;
const _height = 48.0;

// ignore: unused_element
const Set<MaterialState> _interactiveStates = <MaterialState>{
  MaterialState.pressed,
  MaterialState.hovered,
  MaterialState.focused,
};
const Set<MaterialState> _disabledStates = <MaterialState>{
  MaterialState.disabled,
};

class SecondaryButton extends StatelessWidget {
  final Color? backgroundColor;
  final Color? borderColor;
  final Widget child;
  final VoidCallback? onPressed;
  final double width;
  final double? borderRadius;
  final double contentPadding;

  const SecondaryButton({
    Key? key,
    this.backgroundColor,
    this.onPressed,
    required this.child,
    this.width = double.infinity,
    this.borderRadius,
    this.contentPadding = 16,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sideColor = theme.tabBarTheme.unselectedLabelColor;

    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          backgroundColor ?? theme.scaffoldBackgroundColor,
        ),
        padding: MaterialStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(horizontal: contentPadding),
        ),
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(color: borderColor ?? sideColor!),
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderRadius)),
        ),
        fixedSize: MaterialStateProperty.all<Size>(
          Size(width == double.infinity ? 100000 : width, _height),
        ),
        minimumSize: MaterialStateProperty.all<Size>(
          const Size(1, 1),
        ),
        maximumSize: MaterialStateProperty.all<Size>(
          Size.infinite,
        ),
        overlayColor: MaterialStateProperty.all<Color>(
          theme.dividerColor,
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(
          theme.primaryTextTheme.headline4!,
        ),
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) => _textColor(theme, states),
        ),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: contentPadding),
        child: child,
      ),
    );
  }

  Color _textColor(ThemeData theme, Set<MaterialState> states) {
    // disabled state
    if (states.any(_disabledStates.contains)) {
      return theme.disabledColor;
    }

    // all other cases
    return theme.primaryColor;
  }
}

class PrimaryMinuteButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color? main;
  final BorderSide? borderSide;
  final double width;
  final double padding;

  const PrimaryMinuteButton({
    required this.child,
    Key? key,
    this.main,
    this.onPressed,
    this.borderSide,
    this.width = 100,
    this.padding = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) => _backgroundColor(theme, states),
        ),
        padding: MaterialStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(horizontal: padding),
        ),
        side: MaterialStateProperty.resolveWith(
          (states) => _border(theme, states),
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_borderRadius),
          ),
        ),
        fixedSize: MaterialStateProperty.all<Size>(
          Size(width, _height),
        ),
        minimumSize: MaterialStateProperty.all<Size>(
          const Size(1, 1),
        ),
        maximumSize: MaterialStateProperty.all<Size>(
          Size.infinite,
        ),
        overlayColor: MaterialStateProperty.all<Color>(
          theme.colorScheme.secondaryContainer,
        ),
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) => _textColor(theme, states),
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(
          theme.primaryTextTheme.bodyText2!,
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }

  BorderSide _border(ThemeData theme, Set<MaterialState> states) {
    // pressed state
    if (states.any(_interactiveStates.contains)) {
      return BorderSide(color: theme.colorScheme.secondaryContainer);
    }

    // disabled state
    if (states.any(_disabledStates.contains)) {
      return BorderSide(color: theme.canvasColor);
    }

    // all other cases
    return BorderSide(color: theme.colorScheme.secondary);
  }

  Color _textColor(ThemeData theme, Set<MaterialState> states) {
    // disabled state
    if (states.any(_disabledStates.contains)) {
      return theme.disabledColor;
    }

    // all other cases
    return theme.colorScheme.onSecondary;
  }

  Color _backgroundColor(ThemeData theme, Set<MaterialState> states) {
    // disabled state
    if (states.any(_disabledStates.contains)) {
      return theme.canvasColor;
    }

    // all other cases
    return main ?? theme.colorScheme.secondary;
  }
}

