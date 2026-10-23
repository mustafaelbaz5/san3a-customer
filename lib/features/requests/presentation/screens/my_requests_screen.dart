import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/models/service_request_model.dart';
import '../../data/services/request_api_service.dart';

class MyRequestsScreen extends StatefulWidget {
  const MyRequestsScreen({super.key});

  @override
  State<MyRequestsScreen> createState() => _MyRequestsScreenState();
}

class _MyRequestsScreenState extends State<MyRequestsScreen> {
  int _selectedFilterIndex = 0;

  final RequestApiService _requestApiService =
  RequestApiService();

  List<ServiceRequestModel> _requests = [];
  bool _isLoading = true;
  String? _errorMessage;

  final List<String> _filters = [
    'All',
    'Active',
    'Completed',
    'Cancelled',
  ];

  @override
  void initState() {
    super.initState();
    _loadRequests();
  }

  Future<void> _loadRequests() async {
    try {
      final requests =
      await _requestApiService.getMyRequests();

      if (!mounted) return;

      setState(() {
        _requests = requests;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load requests';
      });
    }
  }

  List<ServiceRequestModel> get _filteredRequests {
    if (_selectedFilterIndex == 0) {
      return _requests;
    }

    final selectedFilter =
    _filters[_selectedFilterIndex];

    return _requests.where((request) {
      if (selectedFilter == 'Active') {
        return request.status == 'ACTIVE';
      }

      if (selectedFilter == 'Completed') {
        return request.status == 'COMPLETED';
      }

      if (selectedFilter == 'Cancelled') {
        return request.status == 'CANCELLED';
      }

      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              const Text(
                'My Requests',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 16),

              // ==================== FILTERS ====================

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    _filters.length,
                        (index) {
                      final isSelected =
                          _selectedFilterIndex == index;

                      return Padding(
                        padding:
                        const EdgeInsets.only(
                          right: 8,
                        ),
                        child: ChoiceChip(
                          label: Text(
                            _filters[index],
                          ),
                          selected: isSelected,
                          onSelected: (selected) {
                            if (selected) {
                              setState(() {
                                _selectedFilterIndex =
                                    index;
                              });
                            }
                          },
                          selectedColor:
                          AppColors.primary,
                          backgroundColor:
                          AppColors.inputBackground,
                          labelStyle: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : AppColors
                                .textSecondary,
                            fontWeight:
                            FontWeight.bold,
                            fontSize: 13,
                          ),
                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(
                              20,
                            ),
                          ),
                          side: BorderSide.none,
                          padding:
                          const EdgeInsets
                              .symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ==================== REQUESTS ====================

              Expanded(
                child: _isLoading
                    ? const Center(
                  child:
                  CircularProgressIndicator(),
                )
                    : _errorMessage != null
                    ? Center(
                  child: Text(
                    _errorMessage!,
                    style:
                    const TextStyle(
                      fontSize: 15,
                      color:
                      AppColors.error,
                    ),
                  ),
                )
                    : _filteredRequests.isEmpty
                    ? const Center(
                  child: Text(
                    'No requests found',
                    style:
                    TextStyle(
                      fontSize: 15,
                      color: AppColors
                          .textSecondary,
                    ),
                  ),
                )
                    : ListView.separated(
                  itemCount:
                  _filteredRequests
                      .length,
                  separatorBuilder:
                      (context, index) =>
                  const SizedBox(
                    height: 12,
                  ),
                  itemBuilder:
                      (context, index) {
                    final request =
                    _filteredRequests[
                    index];

                    return _buildRequestCard(
                      title:
                      request.craftName,
                      dateTime: request
                          .createdAt
                          .toString(),
                      technicianName:
                      request
                          .technicianName ??
                          'No technician',
                      status:
                      request.status,
                      price: '—',
                      icon: Icons
                          .home_repair_service,
                      iconBgColor:
                      const Color(
                        0xFFF5F5F5,
                      ),
                      iconColor:
                      AppColors.primary,
                      statusColor:
                      AppColors.primary,
                      statusBgColor:
                      const Color(
                        0xFFE6F7F2,
                      ),
                      hasTechnicianAvatar:
                      request
                          .technicianName !=
                          null,
                      onTap: () {
                        context.push(
                          '/request-details',
                          extra: request,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==================== REQUEST CARD ====================

  Widget _buildRequestCard({
    required String title,
    required String dateTime,
    required String technicianName,
    required String status,
    required String price,
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required Color statusColor,
    required Color statusBgColor,
    bool hasTechnicianAvatar = true,
    required VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius:
          BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.border,
          ),
        ),
        child: Column(
          children: [
            // ==================== TOP ROW ====================

            Row(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                  const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    borderRadius:
                    BorderRadius.circular(14),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 22,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style:
                        const TextStyle(
                          fontSize: 16,
                          fontWeight:
                          FontWeight.bold,
                          color: AppColors
                              .textPrimary,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        dateTime,
                        style:
                        const TextStyle(
                          fontSize: 12,
                          color: AppColors
                              .textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusBgColor,
                    borderRadius:
                    BorderRadius.circular(8),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight:
                      FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // ==================== BOTTOM ROW ====================

            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (hasTechnicianAvatar) ...[
                      CircleAvatar(
                        radius: 12,
                        backgroundColor:
                        Colors.grey.shade300,
                        child: const Icon(
                          Icons.person,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],

                    Text(
                      technicianName,
                      style: TextStyle(
                        fontSize: 13,
                        color:
                        hasTechnicianAvatar
                            ? AppColors
                            .textPrimary
                            : AppColors
                            .textSecondary,
                        fontWeight:
                        hasTechnicianAvatar
                            ? FontWeight.w500
                            : FontWeight
                            .normal,
                      ),
                    ),
                  ],
                ),

                Text(
                  price,
                  style:
                  const TextStyle(
                    fontSize: 15,
                    fontWeight:
                    FontWeight.bold,
                    color:
                    AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}