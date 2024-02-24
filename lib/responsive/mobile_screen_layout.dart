import 'package:flutter/material.dart';
import 'package:pet_paw/screens/add_post_screen.dart';
import 'package:pet_paw/screens/feed_screen.dart';
import 'package:pet_paw/screens/search_screen.dart';
import 'package:pet_paw/utils/colors.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  late PageController pageController;
  int _page = 0;

  final List<Widget> _screens = [
    const FeedScreen(),
    const SearchScreen(),
    const AddPostScreen(),
  ];

  void onNavigationTapped(int page) {
    setState(() {
      _page = page;
    });
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pet Paw', // Change to your app name
          style: TextStyle(
            color: Colors.black, // Customize text color
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor:
            mobileBackgroundColor, // Customize app bar background color
        centerTitle: true,
        elevation: 0,
      ),
      body: PageView(
        onPageChanged: onPageChanged,
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:
            secondaryColor, // Customize bottom navigation bar background color
        selectedItemColor: primaryColor, // Customize selected item color
        unselectedItemColor: Colors.black, // Customize unselected item color
        currentIndex: _page,
        onTap: onNavigationTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Feeds',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Post',
          ),
        ],
      ),
    );
  }
}
