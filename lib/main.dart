import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pet_paw/providers/user_provider.dart';
import 'package:pet_paw/responsive/mobile_screen_layout.dart';
import 'package:pet_paw/responsive/responsive_layout_screen.dart';
import 'package:pet_paw/screens/login_screen.dart';
import 'package:pet_paw/utils/colors.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => UserProvider(),
          ),
        ],
        child: MaterialApp(
          routes: {
            '/login': (context) =>
                LoginScreen(), // Replace LoginScreen with your actual login screen widget
          },
          debugShowCheckedModeBanner: false,
          title: 'Pet Paw',
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: mobileBackgroundColor,
          ),
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                final user = snapshot.data;
                if (user != null) {
                  // User is signed in, redirect to MobileScreenLayout
                  return const ResponsiveLayout(
                    mobileScreenLayout: MobileScreenLayout(),
                  );
                } else {
                  // User is not signed in, show LoginScreen
                  return const LoginScreen();
                }
              } else {
                // Waiting for connection or data
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ),
                );
              }
            },
          ),
        ));
  }
}
