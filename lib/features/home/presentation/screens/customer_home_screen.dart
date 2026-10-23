import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../auth/data/models/customer_user.dart';
import '../../../auth/data/services/customer_auth_api_service.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() =>
      _CustomerHomeScreenState();
}

class _CustomerHomeScreenState
    extends State<CustomerHomeScreen> {
  final CustomerAuthApiService _authApiService =
  CustomerAuthApiService();

  CustomerUser? _currentUser;
  bool _isLoadingUser = true;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    try {
      final user = await _authApiService.getCurrentUser();

      if (!mounted) return;

      setState(() {
        _currentUser = user;
        _isLoadingUser = false;
      });
    } catch (e) {
      debugPrint('FAILED TO LOAD CURRENT USER: $e');

      if (!mounted) return;

      setState(() {
        _isLoadingUser = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userName = _currentUser?.name.isNotEmpty == true
        ? _currentUser!.name
        : 'User';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Good morning,',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Text(
                            _isLoadingUser
                                ? 'User'
                                : userName,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color:
                              AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            '👋',
                            style:
                            TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            padding:
                            const EdgeInsets.all(10),
                            decoration:
                            const BoxDecoration(
                              color: AppColors
                                  .inputBackground,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons
                                  .notifications_none_rounded,
                              color:
                              AppColors.textPrimary,
                              size: 22,
                            ),
                          ),
                          Positioned(
                            right: 10,
                            top: 10,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration:
                              const BoxDecoration(
                                color: AppColors.error,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding:
                        const EdgeInsets.all(10),
                        decoration:
                        const BoxDecoration(
                          color:
                          AppColors.inputBackground,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.person_outline_rounded,
                          color:
                          AppColors.textPrimary,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Container(
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius:
                  BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.border,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search,
                      color:
                      AppColors.textSecondary,
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: TextField(
                        decoration:
                        InputDecoration(
                          hintText:
                          'Search for a service...',
                          hintStyle: TextStyle(
                            color: AppColors
                                .textSecondary,
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      padding:
                      const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius:
                        BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.bolt,
                        color: Colors.amber,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'What do you need?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color:
                      AppColors.textPrimary,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'See all',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _buildMainServiceCard(
                      title: 'Electrician',
                      subtitle:
                      'Wiring, outlets,\nbreakers & more',
                      icon:
                      Icons.electric_bolt_rounded,
                      iconBgColor:
                      const Color(0xFFFFF9E6),
                      iconColor:
                      Colors.amber.shade700,
                      onTap: () {
                        _openRequest(
                          context,
                          'Electrician',
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildMainServiceCard(
                      title: 'Plumber',
                      subtitle:
                      'Pipes, leaks, fixtures &\ndrains',
                      icon:
                      Icons.water_drop_rounded,
                      iconBgColor:
                      const Color(0xFFE3F2FD),
                      iconColor: Colors.blue,
                      onTap: () {
                        _openRequest(
                          context,
                          'Plumber',
                        );
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _buildMainServiceCard(
                      title: 'Mechanic',
                      subtitle: 'Coming soon',
                      icon: Icons.build_rounded,
                      iconBgColor:
                      const Color(0xFFFCE4EC),
                      iconColor:
                      Colors.pink.shade400,
                      onTap: () {
                        _showComingSoon(
                          context,
                          'Mechanic',
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildMainServiceCard(
                      title: 'AC & Cooling',
                      subtitle: 'Coming soon',
                      icon: Icons.ac_unit_rounded,
                      iconBgColor:
                      const Color(0xFFE0F7FA),
                      iconColor: Colors.teal,
                      onTap: () {
                        _showComingSoon(
                          context,
                          'AC & Cooling',
                        );
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _buildMiniServiceCard(
                      title: 'Painting',
                      icon:
                      Icons.palette_rounded,
                      iconColor: Colors.orange,
                      onTap: () {
                        _showComingSoon(
                          context,
                          'Painting',
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildMiniServiceCard(
                      title: 'Carpenter',
                      icon:
                      Icons.door_sliding_outlined,
                      iconColor: Colors.brown,
                      onTap: () {
                        _showComingSoon(
                          context,
                          'Carpenter',
                        );
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Requests',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color:
                      AppColors.textPrimary,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.go('/requests');
                    },
                    child: const Text(
                      'See all',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              _buildRecentRequestCard(
                title: 'Electrician',
                date: 'Today, 10:30 AM',
                price: 'EGP 200',
                status: 'COMPLETED',
                icon:
                Icons.electric_bolt_rounded,
              ),

              const SizedBox(height: 10),

              _buildRecentRequestCard(
                title: 'Plumber',
                date: 'Yesterday, 2:15 PM',
                price: 'EGP 350',
                status: 'COMPLETED',
                icon:
                Icons.water_drop_rounded,
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _openRequest(
      BuildContext context,
      String serviceName,
      ) {
    context.push(
      '/request-step1',
      extra: serviceName,
    );
  }

  void _showComingSoon(
      BuildContext context,
      String serviceName,
      ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$serviceName is coming soon.',
        ),
      ),
    );
  }

  Widget _buildMainServiceCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius:
        BorderRadius.circular(20),
        child: Container(
          padding:
          const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius:
            BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.border,
            ),
          ),
          child: Column(
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
                  size: 24,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color:
                  AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 11,
                  color:
                  AppColors.textSecondary,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMiniServiceCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius:
        BorderRadius.circular(16),
        child: Container(
          padding:
          const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius:
            BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.border,
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 20,
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
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
    );
  }

  Widget _buildRecentRequestCard({
    required String title,
    required String date,
    required String price,
    required String status,
    required IconData icon,
  }) {
    return Container(
      padding:
      const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius:
        BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding:
            const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color:
              AppColors.inputBackground,
              borderRadius:
              BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color:
              AppColors.textPrimary,
              size: 20,
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
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight:
                    FontWeight.bold,
                    color:
                    AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 12,
                    color:
                    AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment:
            CrossAxisAlignment.end,
            children: [
              Container(
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color:
                  const Color(0xFFE3F2FD),
                  borderRadius:
                  BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight:
                    FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                price,
                style: const TextStyle(
                  fontSize: 13,
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
    );
  }
}