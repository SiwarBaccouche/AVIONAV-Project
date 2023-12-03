//@dart=2.9

import 'package:avionav/auth/LoginScreen.dart';
import 'package:avionav/UserProfile.dart';
import 'auth/WelcomePage.dart';
import 'EmailVerification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth/authentication_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationHelper>(
          create: (_) => AuthenticationHelper(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationHelper>().authStateChanges,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Avionav',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: kPrimaryColor,
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: kHintTextColor,
              ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WelcomeScreen();
  }
}
