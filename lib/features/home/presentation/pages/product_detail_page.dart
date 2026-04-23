
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lux_market/core/routes/route_names.dart';
import 'package:lux_market/features/buy/presentation/pages/cart_provider.dart';
import 'package:lux_market/features/buy/presentation/widget/elevated_button_wg.dart';
import 'package:provider/provider.dart';

import 'package:lux_market/features/auth/presentation/widgets/elevated_wg.dart';
import 'package:lux_market/features/home/presentation/widgets/back_widget.dart';
import '../../../../core/constants/app_colors.dart';
import '../widgets/text_widget.dart';

class ProductDetailPage extends StatefulWidget {
  // Products page dan do'kon nomi uzatiladi
  final String shopName;

  const ProductDetailPage({
    super.key,
    this.shopName = "Royal Curtains",
  });

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

  int _selectedImage = 0;
  double _quantity = 2;

  static const String _productName = "Krem Klassik Parda";
  static const double _oldPrice = 12.50;
  static const double _newPrice = 10.00;
  static const String _unit = "metr";

  final List<String> _images = [
    "https://images.unsplash.com/photo-1505691938895-1758d7feb511",
    "https://images.unsplash.com/photo-1520607162513-77705c0f0d4a",
    "https://images.unsplash.com/photo-1484101403633-562f891dc89a",
    "https://images.unsplash.com/photo-1505691723518-36a5ac3be353",
  ];

  // Miqdor dialog
  void _showQuantityDialog() {
    final ctrl = TextEditingController(text: _quantity.toString());
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)),
        title: const Text("Miqdorni kiriting"),
        content: TextField(
          controller: ctrl,
          keyboardType:
          const TextInputType.numberWithOptions(decimal: true),
          decoration:
          const InputDecoration(hintText: "Masalan: 2.5"),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Bekor qilish")),
          TextButton(
            onPressed: () {
              final v = double.tryParse(ctrl.text);
              if (v != null && v > 0)
                setState(() => _quantity = v);
              Navigator.pop(context);
            },
            child: const Text("Saqlash"),
          ),
        ],
      ),
    );
  }
  void _addToCart() {
    context.read<CartProvider>().addItem(
      CartItem(
        id: "${widget.shopName}_$_productName",
        shopName: widget.shopName,
        productName: _productName,
        oldPrice: _oldPrice,
        newPrice: _newPrice,
        unit: _unit,
        quantity: _quantity,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF9B6FE8),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.symmetric(
            horizontal: 20.w, vertical: 12.h),
        duration: const Duration(seconds: 2),
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline,
                color: Colors.white, size: 20),
            SizedBox(width: 8.w),
            Text("Savatga qo'shildi!",
                style: TextStyle(
                    fontSize: 14.sp, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  String _fmt(double v) =>
      v % 1 == 0 ? v.toInt().toString() : v.toStringAsFixed(1);

  @override
  Widget build(BuildContext context) {
    final cartCount =
        context.watch<CartProvider>().totalCount;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            BackWidget(),
            const SizedBox(width: 12),
            const Text(
              "Mahsulotni ko'rish",
              style: TextStyle(
                color: AppColors.darkGrey,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration:
        const BoxDecoration(gradient: _backgroundGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Asosiy rasm
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Stack(
                    children: [
                      Container(
                        height: 260.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(20.r),
                          image: DecorationImage(
                            image: NetworkImage(
                                _images[_selectedImage]),
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
                              horizontal: 10.w, vertical: 5.h),
                          decoration: BoxDecoration(
                            color:
                            Colors.black.withOpacity(0.5),
                            borderRadius:
                            BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            "${_selectedImage + 1}/${_images.length}",
                            style: const TextStyle(
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Mini rasmlar
                SizedBox(
                  height: 70.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _images.length,
                    padding:
                    EdgeInsets.symmetric(horizontal: 16.w),
                    itemBuilder: (_, index) => GestureDetector(
                      onTap: () =>
                          setState(() => _selectedImage = index),
                      child: Container(
                        margin: EdgeInsets.only(right: 10.w),
                        width: 70.w,
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(12.r),
                          border: Border.all(
                            color: _selectedImage == index
                                ? Colors.deepPurple
                                : Colors.transparent,
                            width: 2,
                          ),
                          image: DecorationImage(
                            image: NetworkImage(_images[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                // Info karta
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30.r)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 16, left: 6, right: 6, bottom: 16),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        const Text(
                          _productName,
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
                            letterSpacing: 1,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Row(children: [
                          SvgPicture.asset("assets/home/Tick.svg",
                              width: 26, height: 26),
                          const SizedBox(width: 6),
                          const Text("Ishlab chiqarilgan:",
                              style: TextStyle(
                                  color: AppColors.darkGrey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1)),
                          const SizedBox(width: 6),
                          const Text("Turkiya",
                              style: TextStyle(
                                  color: AppColors.blue,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500)),
                        ]),
                        Divider(
                            height: 30.h,
                            color: const Color(0xffE5E5E5)),
                        const TextWidget(
                            text: 'Narx',
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                        SizedBox(height: 8.h),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.purple),
                            color: const Color(0xffFCFAFF),
                            borderRadius:
                            BorderRadius.circular(12.r),
                          ),
                          child: const Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                  text: 'Metr',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                              SizedBox(height: 4),
                              Text("\$$_oldPrice",
                                  style: TextStyle(
                                      color: AppColors.darkGrey,
                                      fontSize: 16)),
                            ],
                          ),
                        ),
                        Divider(
                            height: 30.h,
                            color: const Color(0xffE5E5E5)),
                        // Miqdor
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            const TextWidget(
                                text: 'Miqdor',
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                            ElevatedButtonWg(
                              width: 150.w,
                              height: 40,
                              onPressed: _showQuantityDialog,
                              text: "Qo'lda kiritish",
                              textColor: Colors.white,
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3EBFF),
                            borderRadius:
                            BorderRadius.circular(25),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                padding: EdgeInsets.zero,
                                constraints:
                                const BoxConstraints(),
                                onPressed: () {
                                  if (_quantity > 1)
                                    setState(
                                            () => _quantity--);
                                },
                                icon: const Icon(Icons.remove,
                                    color: AppColors.blue),
                              ),
                              Container(
                                padding:
                                const EdgeInsets.symmetric(
                                    horizontal: 12),
                                height: 30,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(6),
                                ),
                                child: Text(_fmt(_quantity),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight:
                                        FontWeight.w400)),
                              ),
                              IconButton(
                                padding: EdgeInsets.zero,
                                constraints:
                                const BoxConstraints(),
                                onPressed: () =>
                                    setState(() => _quantity++),
                                icon: const Icon(Icons.add,
                                    color: AppColors.blue),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                            height: 30.h,
                            color: const Color(0xffE5E5E5)),
                        Text(
                          "\$${(_quantity * _oldPrice).toStringAsFixed(2)}",
                          style: const TextStyle(
                              color: AppColors.darkGrey,
                              fontSize: 16),
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.purple),
                            color: const Color(0xffFCFAFF),
                            borderRadius:
                            BorderRadius.circular(12.r),
                          ),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                  text:
                                  '${_fmt(_quantity)} $_unit',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                              const SizedBox(height: 4),
                              Text(
                                "\$${(_quantity * _oldPrice).toStringAsFixed(2)}",
                                style: const TextStyle(
                                    color: AppColors.darkGrey,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                            height: 30.h,
                            color: const Color(0xffE5E5E5)),
                        Row(children: [
                          const TextWidget(
                              text: 'Sotuvda:',
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                          SizedBox(width: 8.w),
                          const Text("Bor",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.blue)),
                        ]),
                        Divider(
                            height: 30.h,
                            color: const Color(0xffE5E5E5)),
                        Row(children: [
                          const TextWidget(
                              text: 'Tikuv xizmati:',
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                          SizedBox(width: 8.w),
                          const Text("Bor",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.blue)),
                        ]),
                        Divider(
                            height: 30.h,
                            color: const Color(0xffE5E5E5)),
                        Row(children: [
                          const TextWidget(
                              text: 'Yetkazib berish xizmati:',
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                          SizedBox(width: 8.w),
                          const Text("Yo'q",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red)),
                        ]),
                        Divider(
                            height: 30.h,
                            color: const Color(0xffE5E5E5)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // Bottom bar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(
            top: 14, bottom: 40, left: 20, right: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 10, color: Colors.black12)
          ],
        ),
        child: Row(
          children: [
            // Savat ikonkasi + badge
            Stack(
              children: [
                GestureDetector(
                  onTap: (){Navigator.pushNamed(
                    context,
                    RouteNames.bottomNavBar,
                    arguments: 2,
                  );},
                  child: Container(
                    height: 50.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                      border:
                      Border.all(color: AppColors.purple),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                          "assets/home/Buy.svg",
                          width: 28,
                          height: 28),
                    ),
                  ),
                ),
                if (cartCount > 0)
                  Positioned(
                    right: 6,
                    top: 6,
                    child: CircleAvatar(
                      radius: 9,
                      backgroundColor: Colors.red,
                      child: Text("$cartCount",
                          style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white)),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: ElevatedWidget(
                onPressed: _addToCart,
                text: "Savatga qo'shish",
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}