import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

class OnboardingPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const OnboardingPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryGreen,
          foregroundColor: Colors.white,
          shape: const StadiumBorder(),
        ),
        child: Row(
          children: [
            const SizedBox(width: 38),
            Expanded(child: Center(child: Text(label))),
            const Padding(
              padding: EdgeInsets.only(right: 14),
              child: Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
    );
  }
}

