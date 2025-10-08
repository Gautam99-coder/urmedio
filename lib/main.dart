import 'package:flutter/material.dart';
import 'package:urmedio/screens/address/addnewaddress_screen.dart';

import 'package:urmedio/screens/address/location_screen.dart';
import 'package:urmedio/screens/address/paddress_screen.dart';
import 'package:urmedio/screens/admin/add_medicine_screen.dart';
import 'package:urmedio/screens/admin/earnings_screen.dart';
import 'package:urmedio/screens/admin/inventory_screen.dart';
import 'package:urmedio/screens/admin/orders_dashboard_screen.dart';
import 'package:urmedio/screens/admin/updatastock_screen.dart';
import 'package:urmedio/screens/auth/forgetpassword_screen.dart';
import 'package:urmedio/screens/auth/otp_screen.dart';
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

// --- KEY ADDITION 1: Import the ProductDetailScreen to use the correct name
import 'package:urmedio/screens/medicines/product_detail_screen.dart'; 
import 'package:urmedio/screens/medicines/storePage_screen.dart';
import 'package:urmedio/screens/privacy_policy_screen.dart';
import 'package:urmedio/screens/profile/aprofile_screen.dart';
import 'package:urmedio/screens/profile/edit_profile_screen.dart';
import 'package:urmedio/screens/profile/pedit_profile_screen.dart';
import 'package:urmedio/screens/profile/profile_screen.dart';
import 'package:urmedio/screens/save_address_screen.dart';
import 'package:urmedio/screens/term_of_services_screen.dart';
import 'package:urmedio/screens/view/notification_screen.dart';
import 'package:urmedio/screens/view/pharmacydetail_screen.dart';
import 'package:urmedio/widgets/medicine_card.dart';
import 'package:urmedio/widgets/setting_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding1.dart';
import 'screens/onboarding2.dart';

// --- KEY ADDITION 2: Import the Medicine model from the home screen
// This makes the 'Medicine' type available for the route definition. // Assumes you have a data file here, adjust path if needed

void main() {
  runApp(const UrMedioApp());
}

class UrMedioApp extends StatelessWidget {
  const UrMedioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UrMedio',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding1': (context) => const Onboarding1(),
        '/onboarding2': (context) => const Onboarding2(),
        '/signup': (context) => const SignupScreen(),
        '/signin': (context) => const SigninScreen(),
        '/pharmacySignup': (context) => const PharmacySignup(),
        '/homePage': (context) => const HomeScreen(),

        // 🚀 THE FIX: This route now expects and extracts the Medicine object.
        '/productPage': (context) {
          // Get the arguments passed to the route.
          final settings = ModalRoute.of(context)?.settings;
          // Cast the arguments to the correct type (Medicine).
          final medicine = settings?.arguments as Medicine?;

          // Ensure medicine is not null before using it.
          if (medicine == null) {
            // You can navigate back or show an error screen if no data is passed
            return const Scaffold(
                body: Center(child: Text('Error: No medicine data provided!')));
          }

          // Pass the data to the ProductDetailScreen.
          return ProductDetailScreen(medicine: medicine);
        },

        '/cartPage': (context) => const CartScreen(),
        '/profilePage': (context) => const ProfileScreen(),
        '/storePage': (context) => StoreScreen(),
        '/checkoutPage': (context) => const CheckoutScreen(),
        '/confmPage': (context) => const OrderConfirmationScreen(),
        '/myorder': (context) => const MyOrdersScreen(),
        '/editPro': (context) => const EditProfileScreen(),
        '/saveAdd': (context) => const SavedAddressesScreen(),
        '/addNewAdd': (context) => const AddNewAddressScreen(),
        '/settingScr': (context) => const SettingsScreen(),
        '/forgetPass': (context) => const ForgotPasswordScreen(),
        '/otpsrc': (context) => const OtpVerificationScreen(),
        '/restPass': (context) => const ResetPasswordScreen(),
        '/locationSrc': (context) => const LocationScreen(),
        '/pharmacyDetail': (context) => const PharmacyDetailsScreen(),
        '/notificationsrc': (context) => const NotificationsScreen(),
        '/phomePage': (context) => const PhomeScreen(),
        '/addMedicine': (context) => const AddMedicineScreen(),
        '/updatestock': (context) => const UpdateStockScreen(),
        
        // Corrected the route for OrdersScreen (imported as OrdersScreen)
        '/orderSrc': (context) => const OrdersScreen(),
        '/inventry': (context) => const InventoryScreen(),
        '/aprofile': (context) => const AprofileScreen(),
        '/aeditp': (context) => const PeditProfileScreen(),
        '/earning': (context) => const EarningsScreen(),
        '/plocation': (context) => const AddAddressScreen(),
        '/contactUs': (context) => const ContactUsScreen(),
        '/faq': (context) => const FaqScreen(),
        '/tos': (context) => const TermsOfServiceScreen(),
        '/pp': (context) => const PrivacyPolicyScreen(),
        '/splash': (context) => const SplashScreen(),

      },
    );
  }
}