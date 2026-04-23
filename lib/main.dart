
import 'package:flutter/material.dart';
import 'package:lux_market/features/buy/presentation/pages/cart_provider.dart';
import 'package:provider/provider.dart';
import 'my_app.dart';

void main() async {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: const MyApp(),
    ),
  );
}