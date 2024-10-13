import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:the_laundry_app/Screens/address_screen.dart';
import 'package:the_laundry_app/Screens/check_out_screen.dart';
import '../Screens/dry_clean_screen.dart';
import '../Screens/home_screen.dart';
import '../Screens/ironing_screen.dart';
import '../Screens/login_screen.dart';
import '../Screens/premium_wash_screen.dart';
import '../Screens/signup_screen.dart';
import '../Screens/standard_wash_screen.dart';
import '../Screens/cart_screen.dart';

class NavigationService{
  late GlobalKey<NavigatorState> _navigatorKey;

  final Map<String, Widget Function(BuildContext)> _routes= {
    "/login" : (context) => const LoginScreen(),
    "/signup" : (context) => const SignupScreen(),
    "/home" : (context) =>  HomeScreen(),
    "/standardwash" : (context) => Standardwashscreen(),
    "/premiumwash" : (context) => PremiumWashScreen(),
    "/ironing" : (context) => IronScreen(),
    "/dryclean" : (context) => DryCleanScreen(),
    "/cart" : (context) => CartScreen(),
    "/address" : (context) => AddressScreen(),
    "/checkout" : (context) => Checkoutscreen()
  };

  GlobalKey<NavigatorState>? get navigatorKey{
    return _navigatorKey;
  }

  Map<String, Widget Function(BuildContext)> get routes {
    return _routes;
  }

  NavigationService(){
    _navigatorKey = GlobalKey<NavigatorState>();
  }

  void push(MaterialPageRoute route){
    _navigatorKey.currentState?.push(route);
  }

  void pushNamed(String routeName){
    _navigatorKey.currentState?.pushNamed(routeName);
  }

  void pushReplacementNamed(String routeName){
    _navigatorKey.currentState?.pushReplacementNamed(routeName);
  }

  void goBack(){
    _navigatorKey.currentState?.pop();
  }
}
