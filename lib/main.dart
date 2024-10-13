import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_laundry_app/Screens/welcome_screen.dart';
import 'package:the_laundry_app/providers/dryCleanProvider.dart';
import 'package:the_laundry_app/providers/ironProvider.dart';
import 'package:the_laundry_app/providers/premWashProvider.dart';
import 'package:the_laundry_app/providers/stdWashProvider.dart';
import 'package:the_laundry_app/services/auth_service.dart';
import 'package:the_laundry_app/services/navigation_service.dart';
import 'package:the_laundry_app/utils.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:provider/provider.dart';
import '../providers/addressScreenProvider.dart';

void main() async {
  await setup();
  runApp(MyApp());
}

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupFirebase();
  await registerServices();
}

class MyApp extends StatelessWidget {
  final GetIt _getIt = GetIt.instance;
  late NavigationService _navigationService;
  late AuthService _authService;

  MyApp({super.key}){
    _navigationService = _getIt.get<NavigationService>();
    _authService = _getIt.get<AuthService>();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StandardWashProvider()),
        ChangeNotifierProvider(create: (context) => PremiumWashProvider()),
        ChangeNotifierProvider(create: (context) => DryCleanProvider()),
        ChangeNotifierProvider(create: (context) => IronProvider()),
        ChangeNotifierProvider(create: (context) => AddressScreenProvider())
      ],
      child: MaterialApp(
        navigatorKey: _navigationService.navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
            textTheme: GoogleFonts.montserratTextTheme()
        ),
        initialRoute: _authService.user != null ? "/home" : "/login",
        routes: _navigationService.routes,
      ),
    );
  }
}

