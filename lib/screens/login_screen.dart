import 'package:flutter/material.dart';
import 'package:pet_paw/resources/auth_method.dart';
import 'package:pet_paw/responsive/mobile_screen_layout.dart';
import 'package:pet_paw/responsive/responsive_layout_screen.dart';
import 'package:pet_paw/screens/signup_screen.dart';
import 'package:pet_paw/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool isLoading = false;

  void loginUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethod().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == 'success') {
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
          ),
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      showSnackBar(res, context);
    }
  }

  void navigateToSignup() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignupScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Wrap with Center widget
        child: SingleChildScrollView(
          // Wrap with SingleChildScrollView to handle overflow
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            width: MediaQuery.of(context).size.width *
                0.8, // Set width to 80% of the screen width
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50), // Increased spacing at the top
                // Custom logo or app name
                const Text(
                  'Pet Paw', // Customize with your app name
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue, // Customize with your color scheme
                  ),
                ),
                const SizedBox(height: 24),
                // Email input field
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter your Email',
                    border: const OutlineInputBorder(),
                    filled: true, // Set filled to true
                    fillColor:
                        Colors.grey[800], // Set desired dark background color
                    hintStyle: const TextStyle(
                        color: Colors.white70), // Customize hint text color
                    // You can further customize the input text color, cursor color, etc.
                  ),
                  style: const TextStyle(
                      color: Colors.white), // Customize input text color
                ),
                const SizedBox(height: 24),
                // Password input field
                TextField(
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter your Password',
                    border: const OutlineInputBorder(),
                    filled: true, // Set filled to true
                    fillColor:
                        Colors.grey[800], // Set desired dark background color
                    hintStyle: const TextStyle(
                        color: Colors.white70), // Customize hint text color
                    // You can further customize the input text color, cursor color, etc.
                  ),
                  style: const TextStyle(
                      color: Colors.white), // Customize input text color
                ),
                const SizedBox(height: 24),
                // Login button
                ElevatedButton(
                  onPressed: loginUser,
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(vertical: 12),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.blue, // Customize button color
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color:
                              Colors.white, // Customize loading indicator color
                        )
                      : const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                ),
                const SizedBox(height: 12),
                // Redirecting section
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to the signup screen
                        navigateToSignup();
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue, // Customize text color
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
