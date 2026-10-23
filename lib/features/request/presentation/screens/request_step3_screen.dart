import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/location/location_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/request_draft.dart';

class RequestStep3Screen extends StatefulWidget {
  final RequestDraft request;

  const RequestStep3Screen({
    super.key,
    required this.request,
  });

  @override
  State<RequestStep3Screen> createState() =>
      _RequestStep3ScreenState();
}

class _RequestStep3ScreenState
    extends State<RequestStep3Screen> {
  final LocationService _locationService =
  LocationService();

  final TextEditingController
  _addressDetailsController =
  TextEditingController();

  final TextEditingController _buildingController =
  TextEditingController();

  bool _isLoadingLocation = false;
  bool _isLocationConfirmed = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _addressDetailsController.dispose();
    _buildingController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    if (!mounted) return;

    setState(() {
      _isLoadingLocation = true;
    });

    try {
      final position =
      await _locationService
          .getCurrentLocation();

      if (!mounted) return;

      setState(() {
        widget.request.latitude =
            position.latitude;

        widget.request.longitude =
            position.longitude;

        _isLocationConfirmed = true;
        _isLoadingLocation = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoadingLocation = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Could not get your location.',
          ),
        ),
      );
    }
  }

  void _continue() {
    if (widget.request.latitude == null ||
        widget.request.longitude == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please enable your location first.',
          ),
        ),
      );
      return;
    }

    widget.request.addressDetails =
        _addressDetailsController.text.trim();

    widget.request.buildingDetails =
        _buildingController.text.trim();

    context.push(
      '/request-step4',
      extra: widget.request,
    );
  }

  @override
  Widget build(BuildContext context) {
    final latitude = widget.request.latitude;
    final longitude = widget.request.longitude;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Container(
            color: AppColors.inputBackground,
            width: double.infinity,
            height: double.infinity,
            child: const Center(
              child: Icon(
                Icons.location_on_rounded,
                size: 80,
                color: AppColors.textSecondary,
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    decoration:
                    const BoxDecoration(
                      color: AppColors.surface,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color:
                        AppColors.textPrimary,
                      ),
                      onPressed:
                          () => context.pop(),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Container(
                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration:
                      BoxDecoration(
                        color: AppColors.surface,
                        borderRadius:
                        BorderRadius.circular(30),
                      ),
                      child: const Text(
                        'Your location',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight:
                          FontWeight.bold,
                          color:
                          AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  const Text(
                    '3/4',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              constraints: BoxConstraints(
                maxHeight:
                MediaQuery.of(context)
                    .size
                    .height *
                    0.68,
              ),
              padding: EdgeInsets.fromLTRB(
                24,
                24,
                24,
                24 +
                    MediaQuery.of(context)
                        .viewInsets
                        .bottom,
              ),
              decoration:
              const BoxDecoration(
                color: AppColors.surface,
                borderRadius:
                BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Confirm your location',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight:
                        FontWeight.bold,
                        color:
                        AppColors.textPrimary,
                      ),
                    ),

                    const SizedBox(height: 4),

                    const Text(
                      'Technicians will use this location to reach you.',
                      style: TextStyle(
                        fontSize: 12,
                        color:
                        AppColors.textSecondary,
                      ),
                    ),

                    const SizedBox(height: 16),

                    if (_isLoadingLocation)
                      const Center(
                        child:
                        CircularProgressIndicator(),
                      ),

                    if (_isLocationConfirmed) ...[
                      Container(
                        padding:
                        const EdgeInsets.all(12),
                        decoration:
                        BoxDecoration(
                          color:
                          const Color(
                            0xFFECFDF5,
                          ),
                          borderRadius:
                          BorderRadius.circular(
                            16,
                          ),
                          border: Border.all(
                            color:
                            const Color(
                              0xFFA7F3D0,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding:
                              const EdgeInsets
                                  .all(6),
                              decoration:
                              const BoxDecoration(
                                color:
                                AppColors
                                    .secondary,
                                shape:
                                BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),

                            const SizedBox(
                              width: 12,
                            ),

                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                                children: [
                                  const Text(
                                    'Location confirmed',
                                    style:
                                    TextStyle(
                                      fontSize: 12,
                                      fontWeight:
                                      FontWeight
                                          .bold,
                                      color:
                                      AppColors
                                          .secondary,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    'Lat: ${latitude?.toStringAsFixed(5)}\nLng: ${longitude?.toStringAsFixed(5)}',
                                    style:
                                    const TextStyle(
                                      fontSize: 11,
                                      color:
                                      AppColors
                                          .textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      _buildTextField(
                        controller:
                        _addressDetailsController,
                        icon:
                        Icons.home_outlined,
                        hint:
                        'Apartment / Floor / Landmark',
                      ),

                      const SizedBox(height: 10),

                      _buildTextField(
                        controller:
                        _buildingController,
                        icon:
                        Icons.business_outlined,
                        hint:
                        'Building number / Gate code',
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _continue,
                          style:
                          ElevatedButton
                              .styleFrom(
                            backgroundColor:
                            AppColors.primary,
                            foregroundColor:
                            Colors.white,
                            elevation: 0,
                            shape:
                            RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius
                                  .circular(16),
                            ),
                          ),
                          child: const Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ] else if (!_isLoadingLocation)
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed:
                          _getCurrentLocation,
                          style:
                          ElevatedButton.styleFrom(
                            backgroundColor:
                            AppColors.primary,
                            foregroundColor:
                            Colors.white,
                          ),
                          child: const Text(
                            'Enable Location Access',
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

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String hint,
  }) {
    return Container(
      padding:
      const EdgeInsets.symmetric(
        horizontal: 14,
      ),
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        borderRadius:
        BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: AppColors.textSecondary,
            size: 20,
          ),
          hintText: hint,
          hintStyle: const TextStyle(
            fontSize: 13,
            color: AppColors.textSecondary,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}