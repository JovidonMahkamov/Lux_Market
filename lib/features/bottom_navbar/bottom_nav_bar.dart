import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lux_market/features/bottom_navbar/nav_item_wg.dart';
import 'package:lux_market/features/buy/presentation/pages/buy_page.dart';
import 'package:lux_market/features/chat/presentation/pages/chat_page.dart';
import 'package:lux_market/features/home/presentation/pages/Home_page.dart';
import 'package:lux_market/features/profile/presentation/pages/profile_page.dart';

class BottomNavBarPage extends StatefulWidget {
  const BottomNavBarPage({super.key});

  @override
  State<BottomNavBarPage> createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  int currentIndex = 0;

  late final List<Widget> _pages = [
    HomePage(),
    ChatPage(),
    BuyPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        extendBody: true,
        body: IndexedStack(
          index: currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.75),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.9),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 24,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      BottomNavItem(
                        isSelected: currentIndex == 0,
                        icon: "assets/bottom_nav_bar/Home.svg",
                        label: 'Asosiy',
                        onTap: () => setState(() => currentIndex = 0),
                      ),
                      BottomNavItem(
                        isSelected: currentIndex == 1,
                        icon: "assets/bottom_nav_bar/Chat.svg",
                        label: 'Chat',
                        onTap: () => setState(() => currentIndex = 1),
                      ),
                      BottomNavItem(
                        isSelected: currentIndex == 2,
                        icon: "assets/bottom_nav_bar/Buy.svg",
                        label: 'Savat',
                        onTap: () => setState(() => currentIndex = 2),
                      ),
                      BottomNavItem(
                        isSelected: currentIndex == 3,
                        icon: "assets/bottom_nav_bar/Profile.svg",
                        label: 'Profil',
                        onTap: () => setState(() => currentIndex = 3),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}