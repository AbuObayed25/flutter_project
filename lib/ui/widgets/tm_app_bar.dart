import 'package:flutter/material.dart';
import 'package:practice_2/ui/controllers/auth_controller.dart';
import 'package:practice_2/ui/screen/profile_screen.dart';
import 'package:practice_2/ui/screen/sign_in_screen.dart';
import '../utility/app_Colors.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({
    super.key,
    this.isProfileScreenOpen=false,
  });
  final bool isProfileScreenOpen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(isProfileScreenOpen){
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProfileScreen(),
          ),
        );
      },
      child: AppBar(
        backgroundColor: AppColors.themeColor,
        title: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AuthController.userData?.fullName??'',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    AuthController.userData?.email??'',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
                onPressed: () async {
                  await AuthController.clearUserData();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignInScreen(),
                      ),
                          (predicate) => false);
                },
                icon: Icon(Icons.logout))
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
