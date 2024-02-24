import 'package:flutter/material.dart';
import 'package:pet_paw/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget mobileScreenLayout;
  const ResponsiveLayout({
    Key? key,
    required this.mobileScreenLayout,
  }) : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    print('addData called');
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
    print(
        'refreshUser completed'); // Add this line to check if refreshUser has completed
    // Now you can proceed with any code that depends on user data.
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return widget.mobileScreenLayout;
      },
    );
  }
}
