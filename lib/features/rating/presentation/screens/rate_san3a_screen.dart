import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class RateSan3aScreen extends StatefulWidget {
  const RateSan3aScreen({super.key});

  @override
  State<RateSan3aScreen> createState() => _RateSan3aScreenState();
}

class _RateSan3aScreenState extends State<RateSan3aScreen> {
  int _rating = 0;

  final TextEditingController _commentController =
  TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Rate San3a',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // ICON
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.infoBackground,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.star_rounded,
                size: 50,
                color: Colors.amber,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'How was your experience with San3a?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Your feedback helps us improve our service.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),

            const SizedBox(height: 28),

            // STARS
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                    (index) {
                  final starNumber = index + 1;

                  return IconButton(
                    onPressed: () {
                      setState(() {
                        _rating = starNumber;
                      });
                    },
                    icon: Icon(
                      starNumber <= _rating
                          ? Icons.star_rounded
                          : Icons.star_outline_rounded,
                      size: 42,
                      color: Colors.amber,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // COMMENT
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Tell us more (optional)',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: _commentController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Write your feedback...',
                alignLabelWithHint: true,
              ),
            ),

            const SizedBox(height: 24),

            // SUBMIT
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _rating == 0
                    ? null
                    : () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: AppColors.border,
                  disabledForegroundColor: AppColors.textSecondary,
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Submit Review',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Maybe Later',
                style: TextStyle(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}