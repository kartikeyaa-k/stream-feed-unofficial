import 'package:flutter/material.dart';

/// `AppPrimaryButton` is a stateless widget that represents a customizable button with loading state functionality.
/// It can display a loading indicator when an operation is in progress, providing feedback to the user about ongoing actions.
/// This button is primarily used for primary actions within the app, maintaining a consistent style and behavior.
///
/// The button is disabled when it is in the loading state, preventing multiple submissions or interactions during the operation.
class AppPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final ButtonStyle? style;
  final Color textColor;

  /// Constructs an `AppPrimaryButton` with the given parameters.
  ///
  /// - [text]: The text to display on the button.
  /// - [onPressed]: The callback function to execute when the button is pressed.
  /// - [isLoading]: Optional. Indicates whether the button should show a loading indicator. Default is `false`.
  /// - [style]: Optional. The style of the button, allowing customization of its appearance.
  /// - [textColor]: Optional. The color of the text or loading indicator. Default is `Colors.white`.
  const AppPrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.textColor = Colors.white,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: style,
      // Shows a loading indicator if `isLoading` is true; otherwise, shows the button text.
      child: isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(textColor),
                strokeWidth: 2,
              ),
            )
          : Text(
              text,
            ),
    );
  }
}
