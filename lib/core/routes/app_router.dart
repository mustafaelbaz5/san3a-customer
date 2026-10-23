import 'package:go_router/go_router.dart';
import '../../features/rating/presentation/screens/detailed_rating_screen.dart';
import '../../features/rating/presentation/screens/initial_rating_screen.dart';
import '../../features/rating/presentation/screens/rate_san3a_screen.dart';
import '../../features/rating/presentation/screens/success_screen.dart';
import '../../features/request/data/models/request_draft.dart';
import '../../features/request/presentation/screens/finding_technician_screen.dart';
import '../../features/request/presentation/screens/request_details_screen.dart';
import '../../features/request/presentation/screens/request_step1_screen.dart';
import '../../features/request/presentation/screens/request_step2_screen.dart';
import '../../features/request/presentation/screens/request_step3_screen.dart';
import '../../features/request/presentation/screens/request_step4_screen.dart';

import '../../features/auth/presentation/screens/EmailRegistrationScreen.dart';
import '../../features/auth/presentation/screens/create_account_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/otp_screen.dart';
import '../../features/chat/presentation/screens/chat_detail_screen.dart';
import '../../features/chat/presentation/screens/messages_screen.dart';
import '../../features/home/presentation/screens/customer_home_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/payment/presentation/screens/payment_screen.dart';
import '../../features/profile/presentation/screens/customer_profile_screen.dart';
import '../../features/profile/presentation/screens/edit_profile_screen.dart';
import '../../features/profile/presentation/screens/help_support_screen.dart';
import '../../features/profile/presentation/screens/privacy_security_screen.dart';
import '../../features/profile/presentation/screens/saved_addresses_screen.dart';
import '../../features/requests/data/models/service_request_model.dart';
import '../../features/requests/presentation/screens/my_requests_screen.dart';
import '../../features/tracking/presentation/screens/service_in_progress_screen.dart';
import '../../features/tracking/presentation/screens/technician_arrived_screen.dart';
import '../../features/tracking/presentation/screens/technician_tracking_screen.dart';
import '../../shared/widgets/customer_bottom_nav_bar.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      // ==================== AUTH ====================
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const OnboardingScreen();
        },
      ),

      GoRoute(
        path: '/email-registration',
        builder: (context, state) {
          return const EmailRegistrationScreen();
        },
      ),

      GoRoute(
        path: '/otp',
        builder: (context, state) {
          final email = state.extra as String? ?? 'example@email.com';

          return OtpVerificationScreen(email: email);
        },
      ),

      GoRoute(
        path: '/create-account',
        builder: (context, state) {
          final email = state.extra as String? ?? '';

          return CreateAccountScreen(email: email);
        },
      ),

      GoRoute(
        path: '/login',
        builder: (context, state) {
          return const LoginScreen();
        },
      ),

      // ==================== REQUEST FLOW ====================
      GoRoute(
        path: '/request-step1',
        builder: (context, state) {
          final serviceName = state.extra as String? ?? 'Service';

          return RequestStep1Screen(serviceName: serviceName);
        },
      ),

      GoRoute(
        path: '/request-step2',
        builder: (context, state) {
          final request = state.extra as RequestDraft;

          return RequestStep2Screen(request: request);
        },
      ),

      GoRoute(
        path: '/request-step3',
        builder: (context, state) {
          final request = state.extra as RequestDraft;

          return RequestStep3Screen(request: request);
        },
      ),

      GoRoute(
        path: '/request-step4',
        builder: (context, state) {
          final request = state.extra as RequestDraft;

          return RequestStep4Screen(request: request);
        },
      ),

      GoRoute(
        path: '/finding-technician',
        builder: (context, state) {
          final request = state.extra as ServiceRequestModel;

          return FindingTechnicianScreen(request: request);
        },
      ),

      // ==================== TRACKING ====================
      GoRoute(
        path: '/technician-tracking',
        builder: (context, state) {
          return const TechnicianTrackingScreen();
        },
      ),

      GoRoute(
        path: '/technician-arrived',
        builder: (context, state) {
          return const TechnicianArrivedScreen();
        },
      ),

      GoRoute(
        path: '/service-in-progress',
        builder: (context, state) {
          return const ServiceInProgressScreen();
        },
      ),

      GoRoute(
        path: '/payment',
        builder: (context, state) {
          return const PaymentScreen();
        },
      ),

      GoRoute(
        path: '/initial-rating',
        builder: (context, state) {
          return const InitialRatingScreen();
        },
      ),

      GoRoute(
        path: '/detailed-rating',
        builder: (context, state) {
          final rating = state.extra as int;

          return DetailedRatingScreen(initialRating: rating);
        },
      ),

      GoRoute(
        path: '/success',
        builder: (context, state) {
          return const SuccessScreen();
        },
      ),

      // ==================== CHAT ====================
      GoRoute(
        path: '/chat-detail',
        builder: (context, state) {
          return const ChatDetailScreen();
        },
      ),

      // ==================== REQUEST DETAILS ====================
      GoRoute(
        path: '/request-details',
        builder: (context, state) {
          final request = state.extra as Map<String, dynamic>;

          return RequestDetailsScreen(request: request);
        },
      ),

      // ==================== PROFILE ====================
      GoRoute(
        path: '/edit-profile',
        builder: (context, state) {
          return const EditProfileScreen();
        },
      ),

      GoRoute(
        path: '/saved-addresses',
        builder: (context, state) {
          return const SavedAddressesScreen();
        },
      ),

      GoRoute(
        path: '/privacy-security',
        builder: (context, state) {
          return const PrivacySecurityScreen();
        },
      ),

      GoRoute(
        path: '/help-support',
        builder: (context, state) {
          return const HelpSupportScreen();
        },
      ),

      GoRoute(
        path: '/rate-san3a',
        builder: (context, state) {
          return const RateSan3aScreen();
        },
      ),

      // ==================== MAIN APP ====================
      ShellRoute(
        builder: (context, state, child) {
          return CustomerMainScaffold(child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) {
              return const CustomerHomeScreen();
            },
          ),

          GoRoute(
            path: '/requests',
            builder: (context, state) {
              return const MyRequestsScreen();
            },
          ),

          GoRoute(
            path: '/messages',
            builder: (context, state) {
              return const MessagesScreen();
            },
          ),

          GoRoute(
            path: '/profile',
            builder: (context, state) {
              return const CustomerProfileScreen();
            },
          ),
        ],
      ),
    ],
  );
}
