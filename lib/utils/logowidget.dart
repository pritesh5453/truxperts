import 'package:flutter/material.dart';
import 'package:truxperts/utils/appcolors.dart';

/// The "TX" mark + "TruXperts" wordmark + tagline, used on
/// Splash and Login screens.
///
/// [dark] = true  -> white text version (used on navy splash background)
/// [dark] = false -> colored version (navy "T" + orange "X", used on white bg)
class LogoWidget extends StatelessWidget {
  final bool dark;
  final double markFontSize;
  final double nameFontSize;

  const LogoWidget({
    super.key,
    this.dark = false,
    this.markFontSize = 64,
    this.nameFontSize = 40,
  });

  @override
  Widget build(BuildContext context) {
    final Color tColor = dark ? Colors.white : AppColors.navy;
    const Color xColor = AppColors.orange;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // "TX" mark
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: markFontSize,
              fontWeight: FontWeight.w800,
              fontStyle: FontStyle.italic,
              height: 1,
            ),
            children: [
              TextSpan(text: 'T', style: TextStyle(color: tColor)),
              TextSpan(text: 'X', style: TextStyle(color: xColor)),
            ],
          ),
        ),
        const SizedBox(height: 6),
        // "TruXperts" wordmark
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: nameFontSize,
              fontWeight: FontWeight.w700,
              height: 1,
            ),
            children: [
              TextSpan(
                text: 'Tru',
                style: TextStyle(color: dark ? Colors.white : AppColors.navy),
              ),
              const TextSpan(
                text: 'X',
                style: TextStyle(color: xColor),
              ),
              TextSpan(
                text: 'perts',
                style: TextStyle(color: dark ? Colors.white : AppColors.navy),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        // Tagline with side rules
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 18, height: 1.5, color: xColor),
            const SizedBox(width: 8),
            Text(
              'Trusted Professionals, One Tap Away.',
              style: TextStyle(
                fontSize: 11.5,
                color: dark ? Colors.white70 : AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            Container(width: 18, height: 1.5, color: xColor),
          ],
        ),
      ],
    );
  }
}