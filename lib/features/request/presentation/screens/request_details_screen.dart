import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/cancel_request_bottom_sheet.dart';

class RequestDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> request;

  const RequestDetailsScreen({
    super.key,
    required this.request,
  });

  @override
  Widget build(BuildContext context) {
    final status = request['status'] as String;
    final hasTechnician =
        request['hasTechnicianAvatar'] ?? true;

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text(
          'Request Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==================== SERVICE CARD ====================

            Container(
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.border,
                ),
              ),

              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),

                    decoration: BoxDecoration(
                      color: request['iconBgColor'],
                      borderRadius: BorderRadius.circular(14),
                    ),

                    child: Icon(
                      request['icon'],
                      color: request['iconColor'],
                      size: 26,
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          request['title'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          request['dateTime'],
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  _buildStatusBadge(
                    status,
                    request['statusColor'],
                    request['statusBgColor'],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ==================== TECHNICIAN ====================

            const Text(
              'Technician',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: AppColors.border,
                ),
              ),

              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey.shade300,
                    child: Icon(
                      hasTechnician
                          ? Icons.person
                          : Icons.person_off_outlined,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          request['technicianName'],
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: hasTechnician
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: hasTechnician
                                ? AppColors.textPrimary
                                : AppColors.textSecondary,
                          ),
                        ),

                        if (hasTechnician) ...[
                          const SizedBox(height: 4),

                          const Row(
                            children: [
                              Icon(
                                Icons.star_rounded,
                                size: 16,
                                color: Colors.amber,
                              ),

                              SizedBox(width: 4),

                              Text(
                                '4.9',
                                style: TextStyle(
                                  fontSize: 12,
                                  color:
                                  AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),

                  if (hasTechnician)
                    IconButton(
                      onPressed: () {
                        context.push('/chat-detail');
                      },
                      icon: const Icon(
                        Icons.chat_bubble_outline_rounded,
                        color: AppColors.primary,
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ==================== REQUEST INFORMATION ====================

            const Text(
              'Request Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: AppColors.border,
                ),
              ),

              child: Column(
                children: [
                  _buildInfoRow(
                    Icons.calendar_today_outlined,
                    'Date & Time',
                    request['dateTime'],
                  ),

                  const Divider(height: 24),

                  _buildInfoRow(
                    Icons.location_on_outlined,
                    'Location',
                    'Assiut, Egypt',
                  ),

                  const Divider(height: 24),

                  _buildInfoRow(
                    Icons.description_outlined,
                    'Description',
                    'Electrical problem at home',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ==================== PRICE ====================

            const Text(
              'Payment Summary',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: AppColors.border,
                ),
              ),

              child: Column(
                children: [
                  _buildPriceRow(
                    'Service',
                    request['price'],
                  ),

                  const Divider(height: 24),

                  _buildPriceRow(
                    'Total',
                    request['price'],
                    isTotal: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // ==================== ACTION ====================

            // ==================== ACTION ====================

            if (status == 'ACTIVE') ...[
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.push('/technician-tracking');
                  },
                  icon: const Icon(
                    Icons.location_on_outlined,
                  ),
                  label: const Text('Track Technician'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton.icon(
                  onPressed: () {
                    context.push('/chat-detail');
                  },
                  icon: const Icon(
                    Icons.chat_bubble_outline_rounded,
                  ),
                  label: const Text('Chat with Technician'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(
                      color: AppColors.primary,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: TextButton.icon(
                  onPressed: () {
                    CancelRequestBottomSheet.show(context);
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                    color: AppColors.error,
                  ),
                  label: const Text(
                    'Cancel Request',
                    style: TextStyle(
                      color: AppColors.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],

            if (status == 'COMPLETED' && hasTechnician) ...[
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.push('/initial-rating');
                  },
                  icon: const Icon(
                    Icons.star_outline,
                  ),
                  label: const Text('Rate Service'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ==================== STATUS BADGE ====================

  Widget _buildStatusBadge(
      String status,
      Color color,
      Color backgroundColor,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),

      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),

      child: Text(
        status,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  // ==================== INFO ROW ====================

  Widget _buildInfoRow(
      IconData icon,
      String title,
      String value,
      ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: AppColors.primary,
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ==================== PRICE ROW ====================

  Widget _buildPriceRow(
      String title,
      String value, {
        bool isTotal = false,
      }) {
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight:
            isTotal ? FontWeight.bold : FontWeight.normal,
            color: AppColors.textPrimary,
          ),
        ),

        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 17 : 14,
            fontWeight: FontWeight.bold,
            color: isTotal
                ? AppColors.primary
                : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}