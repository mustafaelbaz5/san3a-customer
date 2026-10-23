import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/cancel_request_bottom_sheet.dart';

class TechnicianTrackingScreen extends StatelessWidget {
  const TechnicianTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: Stack(
        children: [
          // ==================== MAP ====================

          Container(
            color: const Color(0xFFE5E7EB),
            width: double.infinity,
            height: double.infinity,
            child: const Center(
              child: Icon(
                Icons.map_rounded,
                size: 100,
                color: Colors.grey,
              ),
            ),
          ),

          // ==================== TOP HEADER ====================

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Row(
                children: [
                  // Back Button
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.textPrimary,
                      ),
                      onPressed: () => context.pop(),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // San3a Header
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1B4B),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.build,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'San3a',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Interactive Prototype',
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ==================== STATUS BADGE ====================

          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 72),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.teal,
                          shape: BoxShape.circle,
                        ),
                      ),

                      const SizedBox(width: 8),

                      const Text(
                        'Technician on the way',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ==================== BOTTOM SHEET ====================

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              constraints: BoxConstraints(
                maxHeight:
                MediaQuery.of(context).size.height * 0.65,
              ),

              padding: EdgeInsets.fromLTRB(
                20,
                20,
                20,
                20 +
                    MediaQuery.of(context)
                        .viewInsets
                        .bottom,
              ),

              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),

              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ==================== HANDLE ====================

                    Container(
                      width: 36,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius:
                        BorderRadius.circular(2),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ==================== ARRIVAL + PRICE ====================

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0D9488),
                        borderRadius:
                        BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.access_time_filled,
                            color: Colors.white,
                            size: 28,
                          ),

                          const SizedBox(width: 12),

                          const Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Estimated arrival',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 11,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                '8 min',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          const Spacer(),

                          const Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Est. price',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 11,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'EGP 150–250',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ==================== TECHNICIAN ====================

                    Row(
                      children: [
                        Stack(
                          children: [
                            const CircleAvatar(
                              radius: 26,
                              backgroundImage: NetworkImage(
                                'https://i.pravatar.cc/150?img=11',
                              ),
                            ),

                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                padding:
                                const EdgeInsets.all(2),
                                decoration:
                                const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.check_circle,
                                  color: AppColors.primary,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(width: 14),

                        const Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ahmed Mostafa',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight:
                                  FontWeight.bold,
                                  color:
                                  AppColors.textPrimary,
                                ),
                              ),

                              SizedBox(height: 2),

                              Text(
                                'Senior Electrician',
                                style: TextStyle(
                                  fontSize: 12,
                                  color:
                                  AppColors
                                      .textSecondary,
                                ),
                              ),

                              SizedBox(height: 4),

                              Row(
                                children: [
                                  Icon(
                                    Icons.star_rounded,
                                    color: Colors.amber,
                                    size: 16,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    '4.9',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight:
                                      FontWeight.bold,
                                      color:
                                      AppColors
                                          .textPrimary,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    '(847)',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color:
                                      AppColors
                                          .textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // ==================== ACTION BUTTONS ====================

                    Row(
                      children: [
                        // Chat
                        Expanded(
                          flex: 2,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              context.push(
                                '/chat-detail',
                              );
                            },
                            icon: const Icon(
                              Icons.chat_bubble_outline,
                              size: 18,
                              color: AppColors.primary,
                            ),
                            label: const Text(
                              'Chat',
                              style: TextStyle(
                                color:
                                AppColors.primary,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                            style:
                            ElevatedButton.styleFrom(
                              minimumSize:
                              const Size.fromHeight(
                                46,
                              ),
                              backgroundColor:
                              const Color(0xFFF5F3FF),
                              elevation: 0,
                              shape:
                              RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(
                                  14,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        // Call
                        Expanded(
                          flex: 2,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // TODO: Call technician
                            },
                            icon: const Icon(
                              Icons.phone_outlined,
                              size: 18,
                              color: Colors.teal,
                            ),
                            label: const Text(
                              'Call',
                              style: TextStyle(
                                color: Colors.teal,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                            style:
                            ElevatedButton.styleFrom(
                              minimumSize:
                              const Size.fromHeight(
                                46,
                              ),
                              backgroundColor:
                              const Color(0xFFE6F4F1),
                              elevation: 0,
                              shape:
                              RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(
                                  14,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        // Cancel
                        Container(
                          height: 46,
                          width: 46,
                          decoration: BoxDecoration(
                            color:
                            const Color(0xFFFEF2F2),
                            borderRadius:
                            BorderRadius.circular(14),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: Colors.redAccent,
                              size: 20,
                            ),
                            onPressed: () {
                              CancelRequestBottomSheet.show(context);
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // ==================== SIMULATE ARRIVAL ====================

                    GestureDetector(
                      onTap: () {
                        context.push('/technician-arrived');
                      },
                      child: const Text(
                        'Simulate arrival →',
                        style: TextStyle(
                          fontSize: 12,
                          color:
                          AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}