import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconly/iconly.dart';
import 'package:lux_market/core/routes/route_names.dart';
import 'package:lux_market/features/auth/presentation/widgets/text_field_wg.dart';
import 'package:lux_market/features/home/presentation/widgets/filter_bottom_sheet.dart';
import 'package:lux_market/features/home/presentation/widgets/shop_item_widget.dart';

import '../../../../core/constants/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  static const _backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFFFF6F6),
      Color(0xFFC5B2FF),
      Color(0xFFC3B0FF),
      Color(0xFFE6C5FF),
      Color(0xFFFFFFFF),
    ],
    stops: [0.0, 0.3, 0.55, 0.8, 1.0],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            SizedBox(width: 5.w),
            CircleAvatar(radius: 28, backgroundColor: AppColors.white),
            SizedBox(width: 12.w),
            Text("Salom, Mijoz", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.darkGrey),),
          ],
        ),
        actions: [
          CircleAvatar(
            radius: 28,
            backgroundColor: AppColors.white,
            child: GestureDetector(
              onTap: () {Navigator.pushNamed(context, RouteNames.notificationPage);},
              child: SvgPicture.asset(
                "assets/home/Notification.svg",
                width: 28,
                height: 28,
              ),
            ),
          ),
          SizedBox(width: 20.w),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: _backgroundGradient),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWidgetBoard(
                        controller: searchController,
                        text: "Do’kon qidirish...",
                        obscureText: false,
                        readOnly: false,
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(12),
                          child: SvgPicture.asset(
                            "assets/home/search.svg",
                            width: 25,
                            height: 25,
                          ),
                        ),
                        height: 50.h,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) {
                            return FilterBottomSheet(
                              onSelected: (value) {
                                searchController.text = value;
                              },
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 50.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                          gradient: AppColors.buttonGradient,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: const Icon(
                          IconlyLight.filter,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return const ShopItemWidget(
                        title: "Royal Curtains",
                        category: "Parda Do'kon",
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
