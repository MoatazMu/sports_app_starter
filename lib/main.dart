import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'firebase_options.dart';

// Screens
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/explore_screen.dart';
import 'screens/venue_details_screen.dart';
import 'screens/booking_screen.dart';
import 'screens/book_venue_screen.dart';
import 'screens/booking_start_screen.dart';
import 'screens/booking_summary_screen.dart';
import 'screens/date_time_repeat_screen.dart';
import 'screens/host_match_screen.dart';
import 'screens/invite_participants_screen.dart';
import 'screens/match_details_screen.dart';
import 'screens/my_bookings_screen.dart';
import 'screens/payment_confirmation_screen.dart';
import 'screens/player_discovery_screen.dart';
import 'screens/player_profile_screen.dart';
import 'screens/edit_profile_screen.dart';
import 'screens/redeem_voucher_screen.dart';
import 'screens/search_screen.dart';
import 'screens/team_formation_screen.dart';
import 'screens/match_chat_screen.dart';
import 'screens/my_rewards_screen.dart';
import 'screens/achievements_screen.dart';
import 'screens/empty_states_screen.dart';
import 'screens/user_profile_screen.dart';
import 'screens/change_mobile_screen.dart';
import 'screens/verify_new_mobile_otp_screen.dart';

// Auth Screens
import 'screens/auth/phone_input_screen.dart';
import 'screens/auth/otp_verification_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/auth/user_intent_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint("⚠️ Firebase initialization failed: $e");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sports App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/explore': (context) => const ExploreScreen(),
        '/booking': (context) => const BookingScreen(),
        '/book-venue': (context) => const BookVenueScreen(),
        '/booking-start': (context) => const BookingStartScreen(),
        '/booking-summary': (context) => const BookingSummaryScreen(),
        // Removed the static route for /date-time. Will handle via onGenerateRoute.
        '/host': (context) => const HostMatchScreen(),
        '/invite': (context) => InviteParticipantsScreen(),
        '/my-bookings': (context) => const MyBookingsScreen(),
        '/payment': (context) => const PaymentConfirmationScreen(),
        '/player-discovery': (context) => PlayerDiscoveryScreen(), // ⛔️ removed const
        '/redeem': (context) => RedeemVoucherScreen(), // ⛔️ removed const
        '/search': (context) => const SearchScreen(),
        '/chat': (context) => const MatchChatScreen(),
        '/rewards': (context) => MyRewardsScreen(), // ⛔️ removed const
        '/achievements': (context) => AchievementsScreen(), // ⛔️ removed const
        '/empty': (context) => const EmptyStatesScreen(type: 'bookings'),
        '/phone': (context) => const PhoneInputScreen(),
        '/intent': (context) => const UserIntentScreen(),
        '/user-profile': (context) => const UserProfileScreen(),
        '/profile': (context) => const UserProfileScreen(),
        '/edit-profile': (context) => const EditProfileScreen(),
        '/change-mobile': (context) => const ChangeMobileScreen(),
        '/verify-new-mobile': (context) => const VerifyNewMobileOTPScreen(mobileNumber: '0000000000'),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/otp':
            final args = settings.arguments as Map<String, String>;
            return MaterialPageRoute(
              builder: (_) => OTPVerificationScreen(
                phoneNumber: args['phone']!,
                verificationId: args['verificationId']!,
              ),
            );

          case '/register':
            final phone = settings.arguments as String;
            return MaterialPageRoute(
              builder: (_) => RegisterScreen(phoneNumber: phone),
            );

          case '/match-details':
            final match = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (_) => MatchDetailsScreen(match: match),
            );

          case '/venue-details':
            final venue = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (_) => VenueDetailsScreen(venue: venue),
            );

          case '/player-profile':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (_) => PlayerProfileScreen(player: args['player']),
            );

          case '/team-formation':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (_) => TeamFormationScreen(players: args['players']),
            );

          case '/date-time':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (_) => DateTimeRepeatScreen(venue: args['venue']),
            );
        }

        return null; // default fallback
      },
    );
  }
}