import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_media_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:social_media_app/features/home/presentation/components/my_drawer_tile.dart';
import 'package:social_media_app/features/profile/presentation/profile_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const SizedBox(height: 50),

              // Logo
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.primaryFixed,
              ),

              Divider(
                color: Theme.of(context).colorScheme.secondary,
              ),

              // Home tile
              MyDrawerTile(
                title: 'Home',
                icon: Iconsax.home,
                onTap: () => Navigator.of(context).pop(),
              ),

              // Profile tile
              MyDrawerTile(
                title: 'Profile',
                icon: Iconsax.profile_circle,
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const ProfilePage();
                      },
                    ),
                  );
                },
              ),

              // Search tile
              MyDrawerTile(
                title: 'Search',
                icon: Iconsax.search_normal,
                onTap: () {},
              ),

              // Settings tile
              MyDrawerTile(
                title: 'Settings',
                icon: Iconsax.setting,
                onTap: () {},
              ),

              const Spacer(),

              // Logout tile
              MyDrawerTile(
                title: 'Logout',
                icon: Iconsax.logout,
                onTap: () => context.read<AuthCubit>()..logout(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
