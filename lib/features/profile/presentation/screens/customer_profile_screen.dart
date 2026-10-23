import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';

class CustomerProfileScreen extends StatefulWidget {
  const CustomerProfileScreen({super.key});

  @override
  State<CustomerProfileScreen> createState() =>
      _CustomerProfileScreenState();
}

class _CustomerProfileScreenState extends State<CustomerProfileScreen> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          child: Column(
            children: [
              // ==================== PROFILE HEADER ====================

              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.push('/edit-profile');
                    },child:
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.inputBackground,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.person_rounded,
                          size: 40,
                          color: AppColors.textPrimary,
                        ),
                      ),

                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
    ),


                  const SizedBox(width: 16),

                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ahmed Hassan',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),

                      SizedBox(height: 2),

                      Text(
                        '+20 100 000 0000',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
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

                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '4.8 ',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                TextSpan(
                                  text: '(12) ',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                TextSpan(
                                  text: 'as customer',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ==================== STATS ====================

              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      value: '12',
                      label: 'Requests',
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _buildStatCard(
                      value: 'EGP 0',
                      label: 'Saved',
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _buildStatCard(
                      value: '9',
                      label: 'Reviews',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ==================== NOTIFICATIONS ====================

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
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
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF9E6),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.notifications_none_rounded,
                        color: Colors.amber,
                        size: 22,
                      ),
                    ),

                    const SizedBox(width: 12),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Notifications',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),

                          SizedBox(height: 2),

                          Text(
                            'Request updates, offers',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Switch(
                      value: _notificationsEnabled,
                      onChanged: (value) {
                        setState(() {
                          _notificationsEnabled = value;
                        });
                      },
                      activeColor: AppColors.secondary,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ==================== OPTIONS ====================

              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.border,
                  ),
                ),
                child: Column(
                  children: [
                    _buildOptionTile(
                      icon: Icons.person_outline_rounded,
                      iconBgColor: AppColors.inputBackground,
                      iconColor: AppColors.textSecondary,
                      title: 'Personal Information',
                      subtitle: 'Name, phone, email',
                      onTap: () {},
                    ),

                    _divider(),

                    _buildOptionTile(
                      icon: Icons.location_on_outlined,
                      iconBgColor: const Color(0xFFFFEBEE),
                      iconColor: AppColors.error,
                      title: 'Saved Addresses',
                      subtitle: 'Home, work, other',
                      onTap: () {
                        context.push('/saved-addresses');
                      },
                    ),

                    _divider(),

                    _buildOptionTile(
                      icon: Icons.credit_card_rounded,
                      iconBgColor: const Color(0xFFFFF8E1),
                      iconColor: Colors.amber.shade800,
                      title: 'Payment Methods',
                      subtitle: 'Vodafone Cash, Fawry, cards',
                      onTap: () {},
                    ),

                    _divider(),

                    _buildOptionTile(
                      icon: Icons.shield_outlined,
                      iconBgColor: const Color(0xFFE8F5E9),
                      iconColor: AppColors.success,
                      title: 'Privacy & Security',
                      subtitle: 'Password',
                      onTap: () {
                        context.push('/privacy-security');
                      },
                    ),

                    _divider(),

                    _buildOptionTile(
                      icon: Icons.help_outline_rounded,
                      iconBgColor: const Color(0xFFFFEBEE),
                      iconColor: AppColors.error,
                      title: 'Help & Support',
                      subtitle: 'FAQ, contact us',
                      onTap: () {
                        context.push('/help-support');
                      },
                    ),

                    _divider(),

                    _buildOptionTile(
                      icon: Icons.star_outline_rounded,
                      iconBgColor: const Color(0xFFFFF8E1),
                      iconColor: Colors.amber.shade700,
                      title: 'Rate San3a',
                      subtitle: 'Share your feedback',
                      onTap: () {
                        context.push('/rate-san3a');
                      },
                    ),
                    _divider(),

                    _buildOptionTile(
                      icon: Icons.logout_rounded,
                      iconBgColor: const Color(0xFFFFEBEE),
                      iconColor: AppColors.error,
                      title: 'Log Out',
                      subtitle: 'Sign out of your account',
                      onTap: () {
                        _showLogoutDialog(context);
                      },
                    ),

                  ],
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // ==================== STAT CARD ====================

  Widget _buildStatCard({
    required String value,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.infoBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  // ==================== OPTION TILE ====================

  Widget _buildOptionTile({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconBgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 12,
          color: AppColors.textSecondary,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: AppColors.textSecondary,
        size: 20,
      ),
    );
  }

  // ==================== DIVIDER ====================

  Widget _divider() {
    return const Divider(
      height: 1,
      thickness: 1,
      color: AppColors.border,
      indent: 16,
      endIndent: 16,
    );
  }
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Log Out?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          content: const Text(
            'Are you sure you want to log out?',
            style: TextStyle(
              color: AppColors.textSecondary,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);

                // TODO: Implement actual logout
              },
              child: const Text(
                'Log Out',
                style: TextStyle(
                  color: AppColors.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}