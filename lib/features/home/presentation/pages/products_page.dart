import 'package:flutter/material.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
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
         title: CircleAvatar(
           radius: 20,
           child: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios_new_rounded)),
           backgroundColor: Color(0xffFEFEFE),
         ),
       ),
       body: Container(
         decoration: const BoxDecoration(gradient: _backgroundGradient),

       ),
     );
  }
}
