
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_shop/widgets_global/router.dart';

import '../riverpod/bottom_nav_bar_provider.dart';
import 'bottom_nav_bar.dart';

class ShellRouteScaffold extends ConsumerStatefulWidget {
  final Widget child;
  const ShellRouteScaffold({super.key, required this.child});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ShellRouteScaffoldState();
}

class _ShellRouteScaffoldState extends ConsumerState<ShellRouteScaffold> {

  @override
  void initState(){
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  void indexUpdate(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final route = router.routerDelegate.currentConfiguration.last.route.path;
      switch (route) {
        case '/':
          ref.read(selectedNavbarIndexProvider.notifier).setIndex(0);
          break;
        case '/favorites':
          ref.read(selectedNavbarIndexProvider.notifier).setIndex(1);
          break;
        case '/account':
          ref.read(selectedNavbarIndexProvider.notifier).setIndex(2);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    indexUpdate();

    return Consumer(
      builder: (context, ref, child) {
        bool visibleNavbar = ref.watch(visibleNavbarProvider);
        return Scaffold(
          body: widget.child,
          bottomNavigationBar: visibleNavbar ? const BottomNavBar() : null,
        );
      }
    );
  }
}