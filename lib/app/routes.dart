// import 'package:flutter/material.dart';
// import 'package:urmedio/screens/splash_screen.dart';
// import 'package:urmedio/screens/onboarding1.dart';
// import 'package:urmedio/screens/onboarding2.dart';
// import 'package:urmedio/screens/signup_screen.dart';
// import 'package:urmedio/screens/signin_screen.dart';
// import 'package:urmedio/screens/home/home_screen.dart';
// import 'package:urmedio/screens/medicines/product_detail_screen.dart';
// import 'package:urmedio/screens/cart/cart_screen.dart';
// import 'package:urmedio/screens/profile/profile_screen.dart';
// // ...import all other screens

// class AppRoutes {
//   static const splash = '/';
//   static const onboarding1 = '/onboarding1';
//   static const onboarding2 = '/onboarding2';
//   static const signup = '/signup';
//   static const signin = '/signin';
//   static const home = '/home';
//   static const productDetail = '/productDetail';
//   static const cart = '/cart';
//   static const profile = '/profile';
//   // ...define all other routes
// }

// class AppRouter {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case AppRoutes.splash:
//         return MaterialPageRoute(builder: (_) => const SplashScreen());
//       case AppRoutes.onboarding1:
//         return MaterialPageRoute(builder: (_) => const Onboarding1());
//       case AppRoutes.onboarding2:
//         return MaterialPageRoute(builder: (_) => const Onboarding2());
//       case AppRoutes.signup:
//         return MaterialPageRoute(builder: (_) => const SignupScreen());
//       case AppRoutes.signin:
//         return MaterialPageRoute(builder: (_) => const SigninScreen());
//       case AppRoutes.home:
//         return MaterialPageRoute(builder: (_) => const HomeScreen());
//       case AppRoutes.productDetail:
//         return MaterialPageRoute(builder: (_) => const MedicineDetailsScreen());
//       case AppRoutes.cart:
//         return MaterialPageRoute(builder: (_) => const CartScreen());
//       case AppRoutes.profile:
//         return MaterialPageRoute(builder: (_) => const ProfileScreen());
//       // ...add other routes here
//       default:
//         return MaterialPageRoute(
//           builder: (_) => const Scaffold(
//             body: Center(child: Text('Route not found')),
//           ),
//         );
//     }
//   }
// }
