import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class RequestProgressBar extends StatelessWidget {
  final int currentStep;

  const RequestProgressBar({
    super.key,
    required this.currentStep,
  });

  static const int totalSteps = 4;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: List.generate(
              totalSteps,
                  (index) {
                return Expanded(
                  child: Container(
                    height: 4,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 2,
                    ),
                    decoration: BoxDecoration(
                      color: index < currentStep
                          ? AppColors.primary
                          : AppColors.border,
                      borderRadius:
                      BorderRadius.circular(2),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          '$currentStep/$totalSteps',
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}