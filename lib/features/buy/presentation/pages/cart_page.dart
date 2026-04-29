import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconly/iconly.dart';
import 'package:lux_market/core/constants/app_colors.dart';
import 'package:lux_market/features/buy/presentation/widget/elevated_button_wg.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  static const _grad = LinearGradient(
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
    final cart = context.watch<CartProvider>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Colors.transparent,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            CircleAvatar(
              radius: 28,
              child: SvgPicture.asset("assets/home/savat.svg", width: 24, height: 24,),
              backgroundColor: AppColors.white,
            ),
            SizedBox(width: 12.w),
            Text(
              "Savat",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF3D3D3D),
              ),
            ),
          ],
        ),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: _grad),
        child: SafeArea(
          bottom: false,
          child: cart.shopItems.isEmpty
              ? _EmptyCart()
              : _FilledCart(cart: cart),
        ),
      ),
    );
  }
}
class _EmptyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16.h),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.vertical(top: Radius.circular(30.r)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 250.w,
                  height: 130.h,
                  child: SvgPicture.asset("assets/home/illustration.svg",),
                ),
                Text(
                  "Savatingiz bo'sh turibdi!",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2D2D2D),
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 44.w),
                  child: Text(
                    "Hech narsa tanlamadingizmi? Keling,\nyoqqan narsalarni savatga joylashtiramiz!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF888888),
                        height: 1.5),
                  ),
                ),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
class _FilledCart extends StatefulWidget {
  final CartProvider cart;
  const _FilledCart({required this.cart});

  @override
  State<_FilledCart> createState() => _FilledCartState();
}

class _FilledCartState extends State<_FilledCart> {
  final Set<String> _expanded = {};

  @override
  Widget build(BuildContext context) {
    final shops = widget.cart.shopItems.keys.toList();

    return Column(
      children: [
        SizedBox(height: 16.h),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF8F8F8),
              borderRadius:
              BorderRadius.vertical(top: Radius.circular(30.r)),
            ),
            child: Column(
              children: [
                Padding(
                  padding:
                  EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 0),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        horizontal: 14.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(
                          color: const Color(0xFFE0D5FF), width: 1.2),
                    ),
                    child: Text(
                      "Do'konlar bilan chat orqali narxni kelishib olishingiz mumkin.",
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.error,
                          letterSpacing: 1,
                      ),


                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Mening Savatim:",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.darkGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.fromLTRB(
                        16.w, 0, 16.w, 120.h),
                    itemCount: shops.length,
                    itemBuilder: (_, i) {
                      final shop = shops[i];
                      final items =
                      widget.cart.shopItems[shop]!;
                      final isExp = _expanded.contains(shop);
                      return _ShopBlock(
                        shopName: shop,
                        items: items,
                        total: widget.cart.shopTotal(shop),
                        isExpanded: isExp,
                        onToggle: () => setState(() => isExp
                            ? _expanded.remove(shop)
                            : _expanded.add(shop)),
                        onRemoveItem: (id) =>
                            widget.cart.removeItem(shop, id),
                        onChangeQty: (id, qty) =>
                            widget.cart
                                .updateQuantity(shop, id, qty),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
class _ShopBlock extends StatelessWidget {
  final String shopName;
  final List<CartItem> items;
  final double total;
  final bool isExpanded;
  final VoidCallback onToggle;
  final void Function(String) onRemoveItem;
  final void Function(String, double) onChangeQty;

  const _ShopBlock({
    required this.shopName,
    required this.items,
    required this.total,
    required this.isExpanded,
    required this.onToggle,
    required this.onRemoveItem,
    required this.onChangeQty,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding:
            EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 10.h),
            child: Row(
              children: [
                Expanded(
                  child: Text(shopName,
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF2D2D2D))),
                ),
                ElevatedButtonWg(onPressed: (){}, text: "Bog'lanish", textColor: AppColors.white, width: 120,height: 36,)
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF0F0F0)),
          GestureDetector(
            onTap: onToggle,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 14.w, vertical: 12.h),
              child:  Row(
                    children: [
                      Text("Jami narx:",
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.darkGrey)),
                      SizedBox(width: 8.w),
                      Text(
                        "\$${total.toStringAsFixed(2)}",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blue,
                      ),),
                      const Spacer(),
                      Icon(
                        isExpanded
                            ? IconlyLight.arrow_down_2
                            : IconlyLight.arrow_up_2,
                        color: const Color(0xFFAAAAAA),
                      ),
                    ],
                  ),
                ),
          ),
          // Mahsulotlar ro'yxati
          if (isExpanded) ...[
            const Divider(height: 1, color: Color(0xFFF5F5F5)),
            Container(
              color: const Color(0xFFFAFAFA),
              child: Column(
                children: items
                    .map((item) => _CartItemRow(
                  item: item,
                  onRemove: () =>
                      onRemoveItem(item.id),
                  onChangeQty: (qty) =>
                      onChangeQty(item.id, qty),
                ))
                    .toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
class _CartItemRow extends StatelessWidget {
  final CartItem item;
  final VoidCallback onRemove;
  final void Function(double) onChangeQty;

  const _CartItemRow({
    required this.item,
    required this.onRemove,
    required this.onChangeQty,
  });

  void _showQtyDialog(BuildContext ctx) {
    final ctrl =
    TextEditingController(text: item.quantity.toString());
    showDialog(
      context: ctx,
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
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Bekor")),
          TextButton(
            onPressed: () {
              final v = double.tryParse(ctrl.text);
              if (v != null && v > 0) onChangeQty(v);
              Navigator.pop(ctx);
            },
            child: const Text("Saqlash"),
          ),
        ],
      ),
    );
  }

  String _fmt(double v) =>
      v % 1 == 0 ? v.toInt().toString() : v.toStringAsFixed(1);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rasm
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: const Color(0xFFEEEEEE),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: const Icon(Icons.image,
                color: Colors.grey, size: 28),
          ),
          SizedBox(width: 12.w),
          // Ma'lumotlar
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Sotuvda bor",
                    style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF4C69FF))),
                SizedBox(height: 2.h),
                Text(item.productName,
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF2D2D2D))),
                SizedBox(height: 4.h),
                Row(children: [
                  Text(
                    "\$${item.oldPrice.toStringAsFixed(2)}",
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.red,
                        decoration: TextDecoration.lineThrough),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    "\$${item.newPrice.toStringAsFixed(2)}/ ${item.unit}",
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF2D2D2D),
                        fontWeight: FontWeight.w500),
                  ),
                ]),
                SizedBox(height: 4.h),
                Text(
                  "Miqdor: ${_fmt(item.quantity)}/${item.unit}",
                  style: TextStyle(
                      fontSize: 11.sp,
                      color: const Color(0xFF888888)),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 6.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3EBFF),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (item.quantity > 1)
                          onChangeQty(item.quantity - 1);
                      },
                      child: SizedBox(
                        width: 24.w,
                        height: 24.w,
                        child: Icon(Icons.remove,
                            size: 14.sp,
                            color: const Color(0xFF4C69FF)),
                      ),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 8.w),
                      child: Text(_fmt(item.quantity),
                          style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500)),
                    ),
                    GestureDetector(
                      onTap: () =>
                          onChangeQty(item.quantity + 1),
                      child: SizedBox(
                        width: 24.w,
                        height: 24.w,
                        child: Icon(Icons.add,
                            size: 14.sp,
                            color: const Color(0xFF4C69FF)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6.h),
              GestureDetector(
                onTap: () => _showQtyDialog(context),
                child: Text(
                  "Qo'lda kiritish",
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.blue,
                      decoration: TextDecoration.underline),
                ),
              ),
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: onRemove,
                child: Icon(IconlyBold.delete,
                    color: AppColors.error,
                    size: 20.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
