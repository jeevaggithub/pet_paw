import 'package:flutter/material.dart';
import 'package:pet_paw/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:user_profile_avatar/user_profile_avatar.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
        appBar: AppBar(
          title: Text(user.userName),
        ),
        body: Center(
          child: UserProfileAvatar(
            avatarUrl: user.photoUrl,
            onAvatarTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Tapped on avatar'),
                ),
              );
            },
            notificationCount: 10,
            notificationBubbleTextStyle: const TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            avatarSplashColor: Colors.purple,
            radius: 100,
            isActivityIndicatorSmall: false,
            avatarBorderData: AvatarBorderData(
              borderColor: Colors.black54,
              borderWidth: 5.0,
            ),
          ),
        ));
  }
}
