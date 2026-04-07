import 'dart:convert';

class Product {
  final int id;
  final String name;
  final int qty;
  final int shopId;
  final int price;
  final double? rating;
  final List<String> images;

  const Product({
    required this.id,
    required this.name,
    required this.qty,
    required this.shopId,
    required this.price,
    this.rating,
    this.images = const [],
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      name: map['name'] as String,
      qty: map['qty'] as int,
      shopId: map['shopId'] as int,
      price: map['price'] as int,
      rating: map['rating'] as double?,
      images: jsonDecode(map['rating'] as String) as List<String>,
    );
  }
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'qty': qty,
      'shop_id': shopId,
      'price': price,
      'rating': rating,
      'images': jsonEncode(images),
    };
  }
}
