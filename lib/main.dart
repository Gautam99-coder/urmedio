import 'package:flutter/material.dart';
import 'package:urmedio/screens/address/addnewaddress_screen.dart';
import 'package:urmedio/screens/address/location_screen.dart';
import 'package:urmedio/screens/admin/add_medicine_screen.dart';
import 'package:urmedio/screens/admin/address_screen.dart';
import 'package:urmedio/screens/admin/earnings_screen.dart';
import 'package:urmedio/screens/admin/inventory_screen.dart';
import 'package:urmedio/screens/admin/orders_dashboard_screen.dart';
import 'package:urmedio/screens/admin/pedit_profile_screen.dart';
import 'package:urmedio/screens/admin/updatastock_screen.dart';
import 'package:urmedio/screens/auth/forgetpassword_screen.dart';
import 'package:urmedio/screens/auth/otp_screen.dart';
import 'package:urmedio/screens/auth/reset_password_screen.dart';
import 'package:urmedio/screens/cart/cart_screen.dart';
import 'package:urmedio/screens/checkout/checkout_payment_screen.dart';
import 'package:urmedio/screens/checkout/order_confirmation_screen.dart';
import 'package:urmedio/screens/contact_us_screen.dart';
import 'package:urmedio/screens/faq_screen.dart';
import 'package:urmedio/screens/home/home_screen.dart';
import 'package:urmedio/screens/home/phome_screen.dart';
import 'package:urmedio/screens/medicines/order_recived_screen.dart';
import 'package:urmedio/screens/medicines/product_detail_screen.dart';
import 'package:urmedio/screens/medicines/storePage_screen.dart';
import 'package:urmedio/screens/privacy_policy_screen.dart';
import 'package:urmedio/screens/profile/aprofile_screen.dart';
import 'package:urmedio/screens/profile/edit_profile_screen.dart';
import 'package:urmedio/screens/profile/my_order_screen.dart';
import 'package:urmedio/screens/profile/profile_screen.dart';
import 'package:urmedio/screens/save_address_screen.dart';
import 'package:urmedio/screens/term_of_services_screen.dart';
import 'package:urmedio/screens/view/notification_screen.dart';
import 'package:urmedio/screens/view/pharmacydetail_screen.dart';
import 'package:urmedio/widgets/setting_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding1.dart';
import 'screens/onboarding2.dart';
import 'screens/signup_screen.dart';
import 'screens/signin_screen.dart';
import 'screens/pharmacy_signup.dart';
///

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
        '/homePage':(context)=> const HomeScreen(),
        
        '/productPage':(context)=> const MedicineDetailsScreen(),
        '/cartPage':(context)=> const CartScreen(),
        '/profilePage':(context)=> const ProfileScreen(),
       '/storePage':(context)=> const StoreScreen(),
       '/checkoutPage':(context)=> const CheckoutScreen(),
       '/confmPage':(context)=> const OrderConfirmationScreen(),
       '/myorder':(context)=> const MyOrdersScreen(),
       '/ordreciv':(context)=> const OrderSummaryScreen(),
       '/editPro':(context)=> const EditProfileScreen(),
       '/saveAdd':(context)=> const SavedAddressesScreen(),
       '/addNewAdd':(context)=> const AddNewAddressScreen(),
       '/settingScr':(context)=> const SettingsScreen(),
       '/forgetPass':(context)=> const ForgotPasswordScreen(),
       '/otpsrc':(context)=> const OtpVerificationScreen(),
       '/restPass':(context)=> const ResetPasswordScreen(),
       '/locationSrc':(context)=> const LocationScreen(),
       '/pharmacyDetail':(context)=> const PharmacyDetailsScreen(),
       '/notificationsrc':(context)=> const NotificationsScreen(),
       '/phomePage':(context)=> const PhomeScreen(),
       '/addMedicine':(context)=> const AddMedicineScreen(),
       '/updatestock':(context)=> const UpdateStockScreen(),
       '/orderSrc':(context)=> const OrdersScreen(),
       '/inventry':(context)=> const InventoryScreen(),
       '/aprofile':(context)=> const AprofileScreen(),
       '/aeditp':(context)=> const PeditProfileScreen(),
       '/earning':(context)=> const EarningsScreen(),
       '/plocation':(context)=> const AddAddressScreen(),
       '/contactUs':(context)=> const ContactUsScreen(),
       '/faq':(context)=> const FaqScreen(),
       '/tos':(context)=> const TermsOfServiceScreen(),
       '/pp':(context)=> const PrivacyPolicyScreen(),


      },
    );
  }
}
