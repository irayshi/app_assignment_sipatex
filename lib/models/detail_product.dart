import 'dart:convert';

class DetailProduct {
  final int id;
  final String name;
  final int qty;
  final int shopId;
  final int shopName;
  final int shopImg;
  final int price;
  final double? rating;
  final List<String> images;
  final String description;
  final List<Review> reviews;

  const DetailProduct({
    required this.id,
    required this.name,
    required this.qty,
    required this.shopId,
    required this.price,
    this.rating,
    this.images = const [],
  });

  factory DetailProduct.fromMap(Map<String, dynamic> map) {
    return DetailProduct(
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

class Review {
  final int id;
  final int userId;
  final String userName;
  final String message;
  final String rating;
}
