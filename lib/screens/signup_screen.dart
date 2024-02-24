import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_paw/resources/auth_method.dart';
import 'package:pet_paw/responsive/mobile_screen_layout.dart';
import 'package:pet_paw/responsive/responsive_layout_screen.dart';
import 'package:pet_paw/screens/login_screen.dart';
import 'package:pet_paw/utils/utils.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  void signupUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethod().signupUser(
      email: _emailController.text,
      password: _passwordController.text,
      bio: _bioController.text,
      userName: _usernameController.text,
      file: _image!,
    );
    if (res != 'success') {
      setState(() {
        isLoading = false;
      });
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
          ),
        ),
      );
    }
    print(res);
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void navigateToLogin(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            width: double.infinity,
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
                // Profile picture selection
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : const CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(
                                'https://www.shutterstock.com/image-vector/no-user-profile-picture-hand-260nw-99335579.jpg'),
                          ),
                    Positioned(
                      left: 80,
                      bottom: -10,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(Icons.add_a_photo),
                        color: Colors.blue, // Customize with your color scheme
                      ),
                    ),
                  ],
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
                // Bio text field
                TextField(
                  controller: _bioController,
                  keyboardType: TextInputType.text,
                  maxLines: 3, // Increase input area
                  decoration: InputDecoration(
                    hintText: 'Enter your Bio',
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
                // User name text field
                TextField(
                  controller: _usernameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Enter your user name',
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
                // Sign up button
                ElevatedButton(
                  onPressed: signupUser,
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
                          'Sign Up',
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
                      "Already have an account? ",
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () => navigateToLogin(context),
                      child: const Text(
                        "Log in",
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
        ],
      ),
    );
  }
}
