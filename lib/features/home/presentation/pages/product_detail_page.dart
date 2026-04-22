import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lux_market/features/auth/presentation/widgets/elevated_wg.dart';
import 'package:lux_market/features/home/presentation/widgets/back_widget.dart';

import '../../../../core/constants/app_colors.dart';
import '../widgets/text_widget.dart';

class ProductDetailPage extends StatefulWidget {
  ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
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
  int selectedImage = 0;
  double quantity = 2;


  final List<String> images = [
    "https://images.unsplash.com/photo-1505691938895-1758d7feb511",
    "https://images.unsplash.com/photo-1520607162513-77705c0f0d4a",
    "https://images.unsplash.com/photo-1484101403633-562f891dc89a",
    "https://images.unsplash.com/photo-1505691723518-36a5ac3be353",
  ];

  void _showQuantityDialog() {
    TextEditingController controller =
    TextEditingController(text: quantity.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Miqdorni kiriting"),
          content: TextField(
            controller: controller,
            keyboardType:
            const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              hintText: "Masalan: 2.5",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Bekor qilish"),
            ),
            TextButton(
              onPressed: () {
                double? newQuantity = double.tryParse(controller.text);

                if (newQuantity != null && newQuantity > 0) {
                  setState(() {
                    quantity = newQuantity;
                  });
                }

                Navigator.pop(context);
              },
              child: const Text("Saqlash"),
            ),
          ],
        );
      },
    );
  }
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
            BackWidget(),
            SizedBox(width: 12),
            const Text(
              "Mahsulotni ko‘rish",
              style: TextStyle(
                color: AppColors.darkGrey,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),

      body: Container(
        decoration: const BoxDecoration(gradient: _backgroundGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Stack(
                    children: [
                      Container(
                        height: 260.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          image: DecorationImage(
                            image: NetworkImage(images[selectedImage]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Positioned.fill(
                        child: Center(
                          child: Icon(
                            Icons.play_circle_fill,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 5.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            "${selectedImage + 1}/${images.length}",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 70.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedImage = index;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 10.w),
                          width: 70.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: selectedImage == index
                                  ? Colors.deepPurple
                                  : Colors.transparent,
                              width: 2,
                            ),
                            image: DecorationImage(
                              image: NetworkImage(images[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 20.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30.r),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
                      left: 6,
                      right: 6,
                      bottom: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Krem Klassik Parda",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: AppColors.darkGrey,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        const Text(
                          "Yumshoq mato, zamonaviy dizayn. Uyingiz uchun mukammal tanlov.",
                          style: TextStyle(
                            color: AppColors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/home/Tick.svg",
                              width: 26,
                              height: 26,
                            ),
                            SizedBox(width: 6),
                            Text(
                              "Ishlab chiqarilgan:",
                              style: TextStyle(
                                color: AppColors.darkGrey,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1,
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              "Turkiya",
                              style: TextStyle(
                                color: AppColors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        Divider(height: 30.h, color: Color(0xffE5E5E5)),
                        const TextWidget(text: 'Narx', fontSize: 20, fontWeight: FontWeight.w500,),

                        SizedBox(height: 8.h),

                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.purple),
                            color: Color(0xffFCFAFF),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              TextWidget(text: 'Metr', fontSize: 18, fontWeight: FontWeight.w400,),
                              SizedBox(height: 4),
                              Text(
                                "\$12.50",
                                style: TextStyle(
                                  color: AppColors.darkGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(height: 30.h, color: Color(0xffE5E5E5)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWidget(text: 'Miqdor', fontSize: 20, fontWeight: FontWeight.w500,),
                            ElevatedWidget(
                              size: 140.w,
                              onPressed: () {
                                _showQuantityDialog();
                              },
                              text: "Qo’lda kiritish",
                              textColor: Colors.white,
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3EBFF),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                onPressed: () {
                                  setState(() {
                                    if (quantity > 1) quantity--;
                                  });
                                },
                                icon: const Icon(
                                  Icons.remove,
                                  color: AppColors.blue,
                                ),
                              ),

                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                height: 30,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  quantity.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),

                              IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                onPressed: () {
                                  setState(() {
                                    quantity++;
                                  });
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: AppColors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(height: 30.h, color: Color(0xffE5E5E5)),
                        Text(
                          "\$${(quantity * 12.5).toStringAsFixed(2)}",
                          style: TextStyle(
                            color: AppColors.darkGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.purple),
                            color: Color(0xffFCFAFF),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(text: '$quantity Metr', fontSize: 18, fontWeight: FontWeight.w400,),
                              const SizedBox(height: 4),
                              Text(
                                "\$${(quantity * 12.5).toStringAsFixed(2)}",
                                style: TextStyle(
                                  color: AppColors.darkGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(height: 30.h, color: Color(0xffE5E5E5)),
                        Row(
                          children: [
                            const TextWidget(text: 'Sotuvda:', fontSize: 20, fontWeight: FontWeight.w500,),
                            SizedBox(width: 8.w,),
                            Text("Bor", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.blue),)
                          ],
                        ),
                        Divider(height: 30.h, color: Color(0xffE5E5E5)),
                        Row(
                          children: [
                            const TextWidget(text: 'Tikuv xizmati:', fontSize: 20, fontWeight: FontWeight.w500,),
                            SizedBox(width: 8.w,),
                            Text("Bor", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.blue),)
                          ],
                        ),
                        Divider(height: 30.h, color: Color(0xffE5E5E5)),
                        Row(
                          children: [
                            const TextWidget(text: 'Yetkazib berish xizmati:', fontSize: 20, fontWeight: FontWeight.w500,),
                            SizedBox(width: 8.w,),
                            Text("Yo'q", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.red),)
                          ],
                        ),
                        Divider(height: 30.h, color: Color(0xffE5E5E5)),
],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(top: 14, bottom: 40, left: 20, right: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)],
        ),
        child: Row(
          children: [
            Container(
              height: 50.h,
              width: 50.w,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.purple),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Stack(
                children: [
                  Center(child: SvgPicture.asset("assets/home/Buy.svg", width: 28, height: 28,)),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: CircleAvatar(
                      radius: 9,
                      backgroundColor: Colors.red,
                      child: Text(
                        "1",
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: 20.w),
            Expanded(child: ElevatedWidget(onPressed: (){}, text: "Savatga qo’shish", textColor: Colors.white))
          ],
        ),
      ),
    );
  }
}
