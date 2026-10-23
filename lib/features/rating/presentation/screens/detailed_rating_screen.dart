import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';

class DetailedRatingScreen extends StatefulWidget {
  final int initialRating;

  const DetailedRatingScreen({
    super.key,
    required this.initialRating,
  });

  @override
  State<DetailedRatingScreen> createState() =>
      _DetailedRatingScreenState();
}

class _DetailedRatingScreenState
    extends State<DetailedRatingScreen> {
  late int rating;

  final List<String> tags = [
    'Professional',
    'On time',
    'Friendly',
    'Great work',
    'Clean & tidy',
    'Fair price',
  ];

  final Set<String> selectedTags = {};

  final TextEditingController commentController =
  TextEditingController();

  @override
  void initState() {
    super.initState();
    rating = widget.initialRating;
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Rate Your Experience',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          24,
          10,
          24,
          24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 12),

            const CircleAvatar(
              radius: 36,
              backgroundImage: NetworkImage(
                'https://i.pravatar.cc/150?img=11',
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'How was your experience?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Rate your service with Ahmed Mostafa',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 14),

            Row(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: List.generate(
                5,
                    (index) {
                  return IconButton(
                    iconSize: 32,
                    icon: Icon(
                      index < rating
                          ? Icons.star_rounded
                          : Icons.star_border_rounded,
                      color: index < rating
                          ? Colors.amber
                          : AppColors.border,
                    ),
                    onPressed: () {
                      setState(() {
                        rating = index + 1;
                      });
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 14),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'What did you like about the service?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: tags.map((tag) {
                final isSelected =
                selectedTags.contains(tag);

                return FilterChip(
                  label: Text(tag),
                  selected: isSelected,
                  selectedColor:
                  AppColors.infoBackground,
                  backgroundColor: Colors.white,
                  side: BorderSide(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.border,
                  ),
                  labelStyle: TextStyle(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textPrimary,
                    fontSize: 12,
                  ),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        selectedTags.add(tag);
                      } else {
                        selectedTags.remove(tag);
                      }
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 22),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Leave a comment (optional)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: AppColors.textPrimary,
                ),
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: commentController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText:
                'Tell us more about your experience...',
                hintStyle: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: rating > 0
                    ? () {
                  context.go('/success');
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize:
                  const Size.fromHeight(54),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Submit Review',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}