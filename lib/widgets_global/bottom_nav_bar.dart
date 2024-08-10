import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:badges/badges.dart' as badges;

import '../constants/text_styles.dart';
import '../riverpod/bottom_nav_bar_provider.dart';
import '../riverpod/favorites_badges_provider.dart';



class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, child) {

        final currentIndex = ref.watch(selectedNavbarIndexProvider);
        int badgeCount = ref.watch(favoritesBadgesProvider);

        return GNav(
          selectedIndex: currentIndex,
          backgroundColor: Colors.white,
          textStyle: black(14),
          tabMargin: const EdgeInsets.only(bottom: 10),
          activeColor: Colors.black87,
          color: Colors.grey.shade400,
          iconSize: 27,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          duration: const Duration(milliseconds: 400),
          tabBackgroundColor: Colors.transparent,
          tabs: [
            // главная
            GButton(
              icon: MdiIcons.shoppingOutline,
            ),
            // избранное
            GButton(
              icon: MdiIcons.heartOutline,
              leading: badges.Badge(
                badgeAnimation: const badges.BadgeAnimation.scale(),
                showBadge: badgeCount == 0 ? false : true,
                badgeContent: Text(badgeCount.toString(), style: const TextStyle(color: Colors.white)),
                child: Icon(
                  MdiIcons.heartOutline,
                  color: currentIndex == 1 ? Colors.black87 : Colors.grey.shade400,
                ),
              )
            ),
            // аккаунт
            GButton(
              icon: MdiIcons.account,
            ),
          ],
          onTabChange: (index) {
            // ref.read(selectedNavbarIndexProvider.notifier).setIndex(index);
            switch (index) {
              case 0:
                GoRouter.of(context).push('/');
                break;
              case 1:
                GoRouter.of(context).push('/favorites');
                break;
              case 2:
                GoRouter.of(context).push('/account');
                break;
            }
          },
        );
      }
    );
  }

}
