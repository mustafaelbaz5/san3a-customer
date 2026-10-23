import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../requests/data/models/service_request_model.dart';
import '../../../requests/data/services/request_api_service.dart';

class FindingTechnicianScreen extends StatefulWidget {
  final ServiceRequestModel request;

  const FindingTechnicianScreen({
    super.key,
    required this.request,
  });

  @override
  State<FindingTechnicianScreen> createState() =>
      _FindingTechnicianScreenState();
}

class _FindingTechnicianScreenState
    extends State<FindingTechnicianScreen> {
  final RequestApiService _requestApiService =
  RequestApiService();

  Timer? _timer;

  ServiceRequestModel? _currentRequest;

  bool _isChecking = true;

  @override
  void initState() {
    super.initState();

    _currentRequest = widget.request;

    _checkRequest();

    _timer = Timer.periodic(
      const Duration(seconds: 5),
          (_) => _checkRequest(),
    );
  }

  Future<void> _checkRequest() async {
    try {
      final requests =
      await _requestApiService
          .getMyRequests();

      if (!mounted) return;

      ServiceRequestModel? updatedRequest;

      for (final request in requests) {
        if (request.id == widget.request.id) {
          updatedRequest = request;
          break;
        }
      }

      if (updatedRequest == null) {
        setState(() {
          _isChecking = false;
        });
        return;
      }

      setState(() {
        _currentRequest = updatedRequest;
        _isChecking = false;
      });

      final status =
      updatedRequest.status.toUpperCase();

      final hasTechnician =
          updatedRequest.technicianName != null &&
              updatedRequest.technicianName!
                  .trim()
                  .isNotEmpty;

      final requestAssigned =
          hasTechnician ||
              status == 'ASSIGNED' ||
              status == 'ACCEPTED';

      if (requestAssigned) {
        _timer?.cancel();
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isChecking = false;
      });
    }
  }

  bool get _hasTechnician {
    final request = _currentRequest;

    if (request == null) return false;

    final status =
    request.status.toUpperCase();

    return (request.technicianName != null &&
        request.technicianName!
            .trim()
            .isNotEmpty) ||
        status == 'ASSIGNED' ||
        status == 'ACCEPTED';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final request = _currentRequest!;

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
                Icons.map_outlined,
                size: 100,
                color: AppColors.textSecondary,
              ),
            ),
          ),

          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin:
                const EdgeInsets.only(top: 16),
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius:
                  BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize:
                  MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration:
                      BoxDecoration(
                        color: _hasTechnician
                            ? AppColors.secondary
                            : AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _hasTechnician
                          ? 'Technician found'
                          : 'Searching nearby',
                      style:
                      const TextStyle(
                        fontSize: 12,
                        fontWeight:
                        FontWeight.bold,
                        color:
                        AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Align(
            alignment:
            Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding:
              const EdgeInsets.all(24),
              decoration:
              const BoxDecoration(
                color: AppColors.surface,
                borderRadius:
                BorderRadius.only(
                  topLeft:
                  Radius.circular(32),
                  topRight:
                  Radius.circular(32),
                ),
              ),
              child: Column(
                mainAxisSize:
                MainAxisSize.min,
                children: [
                  Container(
                    width: 36,
                    height: 4,
                    decoration:
                    BoxDecoration(
                      color:
                      AppColors.border,
                      borderRadius:
                      BorderRadius.circular(
                        2,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Container(
                    width: 64,
                    height: 64,
                    decoration:
                    BoxDecoration(
                      color: _hasTechnician
                          ? AppColors.secondary
                          : AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _hasTechnician
                          ? Icons.check_rounded
                          : Icons.search_rounded,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    _hasTechnician
                        ? 'Technician assigned'
                        : 'Finding a technician',
                    style:
                    const TextStyle(
                      fontSize: 20,
                      fontWeight:
                      FontWeight.bold,
                      color:
                      AppColors.textPrimary,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    _hasTechnician
                        ? request.technicianName ??
                        'Your technician has been assigned.'
                        : _isChecking
                        ? 'Checking for available technicians...'
                        : 'Searching nearby verified technicians...',
                    textAlign: TextAlign.center,
                    style:
                    const TextStyle(
                      fontSize: 12,
                      color:
                      AppColors.textSecondary,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Container(
                    width: double.infinity,
                    padding:
                    const EdgeInsets.all(14),
                    decoration:
                    BoxDecoration(
                      color:
                      AppColors.infoBackground,
                      borderRadius:
                      BorderRadius.circular(
                        16,
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.build_outlined,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            children: [
                              Text(
                                request.craftName,
                                style:
                                const TextStyle(
                                  fontSize: 13,
                                  fontWeight:
                                  FontWeight.bold,
                                  color:
                                  AppColors
                                      .textPrimary,
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Request #${_shortId(request.id)}',
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

                  const SizedBox(height: 20),

                  if (_hasTechnician)
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          context.go(
                            '/technician-tracking',
                          );
                        },
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
                                .circular(
                              14,
                            ),
                          ),
                        ),
                        child: const Text(
                          'Track Technician',
                          style: TextStyle(
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: OutlinedButton(
                      onPressed: () {
                        _timer?.cancel();
                        context.go('/home');
                      },
                      style:
                      OutlinedButton.styleFrom(
                        side:
                        const BorderSide(
                          color:
                          AppColors.border,
                        ),
                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(
                            14,
                          ),
                        ),
                      ),
                      child: const Text(
                        'Back to Home',
                        style: TextStyle(
                          color:
                          AppColors.primary,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _shortId(String id) {
    if (id.length <= 8) {
      return id;
    }

    return id.substring(0, 8);
  }
}