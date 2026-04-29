import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String shopName;
  final String productName;
  final double oldPrice;
  final double newPrice;
  final String unit;
  double quantity;

  CartItem({
    required this.id,
    required this.shopName,
    required this.productName,
    required this.oldPrice,
    required this.newPrice,
    required this.unit,
    this.quantity = 1,
  });

  double get totalPrice => newPrice * quantity;
}

class CartProvider extends ChangeNotifier {
  final Map<String, List<CartItem>> _shopItems = {};

  Map<String, List<CartItem>> get shopItems => _shopItems;

  List<CartItem> get allItems =>
      _shopItems.values.expand((e) => e).toList();

  int get totalCount => allItems.length;

  void addItem(CartItem item) {
    _shopItems.putIfAbsent(item.shopName, () => []);
    final existing =
        _shopItems[item.shopName]!.where((e) => e.id == item.id).firstOrNull;
    if (existing != null) {
      existing.quantity += item.quantity;
    } else {
      _shopItems[item.shopName]!.add(item);
    }
    notifyListeners();
  }

  void removeItem(String shopName, String itemId) {
    _shopItems[shopName]?.removeWhere((e) => e.id == itemId);
    if (_shopItems[shopName]?.isEmpty ?? false) {
      _shopItems.remove(shopName);
    }
    notifyListeners();
  }

  void updateQuantity(String shopName, String itemId, double qty) {
    final item = _shopItems[shopName]
        ?.where((e) => e.id == itemId)
        .firstOrNull;
    if (item != null) {
      item.quantity = qty < 1 ? 1 : qty;
      notifyListeners();
    }
  }

  void clearAll() {
    _shopItems.clear();
    notifyListeners();
  }

  double shopTotal(String shopName) =>
      (_shopItems[shopName] ?? []).fold(0, (s, e) => s + e.totalPrice);
}