import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../requests/data/services/request_api_service.dart';
import '../../data/models/request_draft.dart';
///import '../../data/services/request_api_service.dart';

class RequestStep5Screen extends StatefulWidget {
  final RequestDraft request;

  const RequestStep5Screen({
    super.key,
    required this.request,
  });

  @override
  State<RequestStep5Screen> createState() =>
      _RequestStep5ScreenState();
}

class _RequestStep5ScreenState
    extends State<RequestStep5Screen> {
  final RequestApiService _requestApiService =
  RequestApiService();

  bool _isSubmitting = false;

  Future<void> _submitRequest() async {
    final request = widget.request;

    if (request.latitude == null ||
        request.longitude == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Location is required',
          ),
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final createdRequest =
      await _requestApiService.createRequest(
        craftId: request.craftId,
        description: request.description,
        latitude: request.latitude!,
        longitude: request.longitude!,
      );

      if (!mounted) return;

      context.go(
        '/finding-technician',
        extra: createdRequest,
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Could not submit request: $e',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = widget.request;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.textPrimary,
          ),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Review Request',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              const Text(
                'Review your request',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Make sure everything is correct before submitting.',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: 20),

              _buildCard(
                children: [
                  _buildSummaryItem(
                    'Service',
                    request.serviceName,
                  ),
                  const SizedBox(height: 14),
                  _buildSummaryItem(
                    'Problem',
                    request.description,
                  ),
                  const SizedBox(height: 14),
                  _buildSummaryItem(
                    'Location',
                    '${request.latitude?.toStringAsFixed(5)}, '
                        '${request.longitude?.toStringAsFixed(5)}',
                  ),
                  if (request.addressDetails
                      .isNotEmpty) ...[
                    const SizedBox(height: 14),
                    _buildSummaryItem(
                      'Address details',
                      request.addressDetails,
                    ),
                  ],
                  if (request.buildingDetails
                      .isNotEmpty) ...[
                    const SizedBox(height: 14),
                    _buildSummaryItem(
                      'Building',
                      request.buildingDetails,
                    ),
                  ],
                ],
              ),

              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.infoBackground,
                  borderRadius:
                  BorderRadius.circular(16),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'The final service price will be confirmed by the technician after checking the problem.',
                        style: TextStyle(
                          fontSize: 12,
                          color:
                          AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _isSubmitting
                      ? null
                      : _submitRequest,
                  style:
                  ElevatedButton.styleFrom(
                    backgroundColor:
                    AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(16),
                    ),
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child:
                    CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                      : const Text(
                    'Submit Request',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildSummaryItem(
      String label,
      String value,
      ) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}