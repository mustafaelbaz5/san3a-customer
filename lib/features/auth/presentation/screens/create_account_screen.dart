import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../data/services/customer_auth_api_service.dart';

class CreateAccountScreen extends StatefulWidget {
  final String email;

  const CreateAccountScreen({
    super.key,
    required this.email,
  });

  @override
  State<CreateAccountScreen> createState() =>
      _CreateAccountScreenState();
}

class _CreateAccountScreenState
    extends State<CreateAccountScreen> {
  final CustomerAuthApiService authApiService =
  CustomerAuthApiService();

  bool isLoading = false;
  final TextEditingController firstNameController =
  TextEditingController();

  final TextEditingController lastNameController =
  TextEditingController();

  final TextEditingController passwordController =
  TextEditingController();

  bool isPasswordVisible = false;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
              IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.inputBackground,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(12),
                ),
              ),

              const SizedBox(height: 24),

              // Profile Icon Box
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.person_outline_rounded,
                  size: 28,
                  color: Color(0xFF2E7D32),
                ),
              ),

              const SizedBox(height: 20),

              // Title
              const Text(
                'Create your account',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 8),

              // Subtitle
              const Text(
                'Tell us a bit about yourself to get started.',
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 32),

              // First Name & Last Name
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'First Name',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),

                        const SizedBox(height: 8),

                        _buildInputField(
                          controller: firstNameController,
                          hintText: 'Ahmed',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Last Name',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),

                        const SizedBox(height: 8),

                        _buildInputField(
                          controller: lastNameController,
                          hintText: 'Hassan',
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Password
              const Text(
                'Password',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 8),

              _buildInputField(
                controller: passwordController,
                hintText: 'At least 6 characters',
                isPassword: true,
                isPasswordVisible: isPasswordVisible,
                onToggleVisibility: () {
                  setState(() {
                    isPasswordVisible =
                    !isPasswordVisible;
                  });
                },
              ),

              const SizedBox(height: 20),

              // Terms & Privacy
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                  children: [
                    TextSpan(
                      text:
                      'By creating an account, you agree to San3a\'s ',
                    ),
                    TextSpan(
                      text: 'Terms of Service',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: '.'),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Create Account Button
              CustomButton(
                text: 'Create Account 🎉',
                onPressed: isLoading
                    ? null
                    : () async {
                  final firstName = firstNameController.text.trim();
                  final lastName = lastNameController.text.trim();
                  final password = passwordController.text;

                  if (firstName.isEmpty ||
                      lastName.isEmpty ||
                      password.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please complete all fields.'),
                      ),
                    );
                    return;
                  }

                  final name = '$firstName $lastName';

                  try {
                    setState(() {
                      isLoading = true;
                    });

                    final response = await authApiService.register(
                      name: name,
                      email: widget.email,
                      password: password,
                    );

                    print('REGISTER STATUS: ${response.statusCode}');
                    print('REGISTER DATA: ${response.data}');

                    if (!mounted) return;

                    context.go('/home');
                  } on DioException catch (e) {
                    if (!mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          e.response?.data?['message'] ??
                              'Failed to create account.',
                        ),
                      ),
                    );
                  } finally {
                    if (mounted) {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  }
                },
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    bool isPassword = false,
    bool isPasswordVisible = false,
    VoidCallback? onToggleVisibility,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        borderRadius: BorderRadius.circular(16),
      ),

      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),

      child: TextField(
        controller: controller,

        obscureText:
        isPassword && !isPasswordVisible,

        decoration: InputDecoration(
          hintText: hintText,

          border: InputBorder.none,

          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 15,
          ),

          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              isPasswordVisible
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: Colors.grey,
            ),
            onPressed: onToggleVisibility,
          )
              : null,
        ),
      ),
    );
  }
}