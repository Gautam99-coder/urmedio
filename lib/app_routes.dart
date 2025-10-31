import 'package:flutter/material.dart';

// Import all your screen widgets here
import 'package:urmedio/screens/address/addnewaddress_screen.dart';
import 'package:urmedio/screens/address/location_screen.dart';
import 'package:urmedio/screens/address/paddress_screen.dart';
import 'package:urmedio/screens/admin/add_medicine_screen.dart';
import 'package:urmedio/screens/admin/earnings_screen.dart';
import 'package:urmedio/screens/admin/inventory_screen.dart';
import 'package:urmedio/screens/admin/orders_dashboard_screen.dart';
import 'package:urmedio/screens/admin/updatastock_screen.dart';
import 'package:urmedio/screens/auth/forgetpassword_screen.dart';
import 'package:urmedio/screens/auth/otp_verification_screen.dart';
import 'package:urmedio/screens/auth/pharmacy_signup.dart';
import 'package:urmedio/screens/auth/reset_password_screen.dart';
import 'package:urmedio/screens/auth/signin_screen.dart';
import 'package:urmedio/screens/auth/signup_screen.dart';
import 'package:urmedio/screens/cart/cart_screen.dart';
import 'package:urmedio/screens/checkout/checkout_payment_screen.dart';
import 'package:urmedio/screens/checkout/order_confirmation_screen.dart';
import 'package:urmedio/screens/contact_us_screen.dart';
import 'package:urmedio/screens/faq_screen.dart';
import 'package:urmedio/screens/home/home_screen.dart';
import 'package:urmedio/screens/home/phome_screen.dart';
import 'package:urmedio/screens/medicines/my_order_screen.dart';
import 'package:urmedio/screens/medicines/product_detail_screen.dart';
import 'package:urmedio/screens/medicines/storePage_screen.dart';
import 'package:urmedio/screens/onboarding1.dart';
import 'package:urmedio/screens/onboarding2.dart';
import 'package:urmedio/screens/privacy_policy_screen.dart';
import 'package:urmedio/screens/profile/aprofile_screen.dart';
import 'package:urmedio/screens/profile/edit_profile_screen.dart';
import 'package:urmedio/screens/profile/pedit_profile_screen.dart';
import 'package:urmedio/screens/profile/profile_screen.dart';
import 'package:urmedio/screens/save_address_screen.dart';
import 'package:urmedio/screens/splash_screen.dart';
import 'package:urmedio/screens/term_of_services_screen.dart';
import 'package:urmedio/screens/view/notification_screen.dart';
import 'package:urmedio/screens/view/pharmacydetail_screen.dart';
import 'package:urmedio/services/call_screen.dart';
// import 'package:urmedio/widgets/medicine_card.dart'; // Not needed here
import 'package:urmedio/widgets/setting_screen.dart';
import 'package:urmedio/models/medicine_model.dart'; // ✅ IMPORT THE MEDICINE MODEL

class AppRoutes {
  // Route constants
  static const String splash = '/';
  static const String onboarding1 = '/onboarding1';
  static const String onboarding2 = '/onboarding2';
  static const String signup = '/signup';
  static const String signin = '/signin';
  static const String pharmacySignup = '/pharmacySignup';
  static const String home = '/homePage';
  static const String productPage = '/productPage';
  static const String cartPage = '/cartPage';
  static const String profilePage = '/profilePage';
  static const String storePage = '/storePage';
  static const String checkoutPage = '/checkoutPage';
  static const String confmPage = '/confmPage';
  static const String myorder = '/myorder';
  static const String editPro = '/editPro';
  static const String saveAdd = '/saveAdd';
  static const String addNewAdd = '/addNewAdd';
  static const String settingScr = '/settingScr';
  static const String forgetPass = '/forgetPass';
  static const String otpsrc = '/otpsrc';
  static const String restPass = '/restPass';
  static const String locationSrc = '/locationSrc';
  static const String pharmacyDetail = '/pharmacyDetail';
  static const String notificationsrc = '/notificationsrc';
  static const String phomePage = '/phomePage';
  static const String addMedicine = '/addMedicine';
  static const String updatestock = '/updatestock';
  static const String orderSrc = '/orderSrc';
  static const String inventry = '/inventry';
  static const String aprofile = '/aprofile';
  static const String aeditp = '/aeditp';
  static const String earning = '/earning';
  static const String plocation = '/plocation';
  static const String contactUs = '/contactUs';
  static const String faq = '/faq';
  static const String tos = '/tos';
  static const String pp = '/pp';
  static const String call = '/call';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onboarding1:
        return MaterialPageRoute(builder: (_) => const Onboarding1());
      case onboarding2:
        return MaterialPageRoute(builder: (_) => const Onboarding2());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case signin:
        return MaterialPageRoute(builder: (_) => const SigninScreen());
      case pharmacySignup:
        return MaterialPageRoute(builder: (_) => const PharmacySignup());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case productPage:
        // ✅ FIX: Use the correct Medicine model
        final medicine = settings.arguments as Medicine?;
        if (medicine != null) {
          return MaterialPageRoute(
              builder: (_) => ProductDetailScreen(medicine: medicine));
        }
        return _errorRoute('No medicine data provided!');
      case cartPage:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case profilePage:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case storePage:
        return MaterialPageRoute(builder: (_) => StoreScreen());
      case checkoutPage:
        return MaterialPageRoute(builder: (_) => const CheckoutScreen());
      case confmPage:
        return MaterialPageRoute(builder: (_) => const OrderConfirmationScreen());
      case myorder:
        return MaterialPageRoute(builder: (_) => const MyOrdersScreen());
      case editPro:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case saveAdd:
        return MaterialPageRoute(builder: (_) => const SavedAddressesScreen());
      case addNewAdd:
        return MaterialPageRoute(builder: (_) => const AddNewAddressScreen());
      case settingScr:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case forgetPass:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());
      case otpsrc:
        // Note: Your app seems to have two password reset flows.
        // This OTP screen is one, but ForgotPasswordScreen uses an email link.
        // Make sure you know which one you intend to use.
        return MaterialPageRoute(builder: (_) => const OtpVerificationScreen(email: 'test@example.com')); // ✅ Added placeholder
      case restPass:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());
      case locationSrc:
        return MaterialPageRoute(builder: (_) => const LocationScreen());
      case pharmacyDetail:
        return MaterialPageRoute(builder: (_) => const PharmacyDetailsScreen());
      case notificationsrc:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      case phomePage:
        return MaterialPageRoute(builder: (_) => const PhomeScreen());
      case addMedicine:
        return MaterialPageRoute(builder: (_) => const AddMedicineScreen());
      case updatestock:
        return MaterialPageRoute(builder: (_) => const UpdateStockScreen());
      case orderSrc:
        return MaterialPageRoute(builder: (_) => const OrdersScreen());
      case inventry:
        return MaterialPageRoute(builder: (_) => const InventoryScreen());
      case aprofile:
        return MaterialPageRoute(builder: (_) => const AprofileScreen());
      case aeditp:
        return MaterialPageRoute(builder: (_) => const PeditProfileScreen());
      case earning:
        return MaterialPageRoute(builder: (_) => const EarningsScreen());
      case plocation:
        return MaterialPageRoute(builder: (_) => const AddAddressScreen());
      case contactUs:
        return MaterialPageRoute(builder: (_) => const ContactUsScreen());
      case faq:
        return MaterialPageRoute(builder: (_) => const FaqScreen());
      case tos:
        return MaterialPageRoute(builder: (_) => const TermsOfServiceScreen());
      case pp:
        return MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen());
      case call:
        return MaterialPageRoute(builder: (_) => const CallScreen());

      default:
        return _errorRoute('Unknown route: ${settings.name}');
    }
  }

  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text('Error')),
          body: Center(
            child: Text('Error: $message'),
          ),
        );
      },
    );
  }
}