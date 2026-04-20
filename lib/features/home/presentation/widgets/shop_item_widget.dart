import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShopItemWidget extends StatelessWidget {
  final String title;
  final String category;

  const ShopItemWidget({
    super.key,
    required this.title,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 18.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: Row(
        children: [
          Container(
            width: 70.w,
            height: 70.w,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Icon(Icons.favorite,
                        size: 18.sp,
                        color: Colors.pinkAccent),

                    SizedBox(width: 6.w),

                    Text(
                      category,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),

          /// button
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 10.h,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFE6D9FF),
                  Color(0xFFD2C2FF),
                ],
              ),
            ),
            child: Text(
              "Ko'rish",
              style: TextStyle(
                color: const Color(0xFF6A85F1),
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
          )
        ],
      ),
    );
  }
}