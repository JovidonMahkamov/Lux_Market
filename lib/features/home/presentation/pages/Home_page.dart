import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconly/iconly.dart';
import 'package:lux_market/features/auth/presentation/widgets/text_field_wg.dart';
import 'package:lux_market/features/home/presentation/widgets/filter_bottom_sheet.dart';
import 'package:lux_market/features/home/presentation/widgets/shop_item_widget.dart';

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
            SizedBox(width: 15.w),
            CircleAvatar(radius: 26, backgroundColor: Colors.grey),
            SizedBox(width: 20.w),
            Text("Salom, Sevinch"),
          ],
        ),
        actions: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                "assets/home/Notification.svg",
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10.w),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: _backgroundGradient),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
            child: Column(
              children: [
                TextFieldWidgetBoard(
                  controller: searchController,
                  text: "Qidiruv",
                  obscureText: false,
                  readOnly: false,
                  prefixIcon: Icon(IconlyLight.search),
                  suffixIcon: IconButton(
                    onPressed: () {
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
                    icon: Icon(IconlyLight.filter),
                  ),
                ),
                SizedBox(height: 20.h,),
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
