import 'dart:convert';

import 'package:app_assignment_sipatex/models/create_product.dart';
import 'package:app_assignment_sipatex/models/detail_product.dart';
import 'package:app_assignment_sipatex/models/product.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class ProductProvider {
  static ProductProvider get to => Get.find();

  final Database _db;
  ProductProvider({required Database db}) : _db = db;

  Future<List<Product>> getAll({
    required int userId,
    int limit = 20,
    int offset = 0,
  }) async {
    final row = await _db.rawQuery(
      '''
      SELECT 
        products.id,
        products.name,
        products.total_sales,
        products.price,
        products.img,
        shops.address,
        favorite.id AS favorite_id,
        products.rating
      FROM products
      JOIN shops ON shops.id = products.shop_id
      LEFT JOIN favorite 
        ON favorite.product_id = products.id 
        AND favorite.user_id = ?
      LIMIT $limit OFFSET $offset
      ''',
      [userId],
    );
    return row.map(Product.fromMap).toList();
  }

  Future<CreateProduct> create({
    required String name,
    required int qty,
    required int shopId,
    required int price,
    required List<String> images,
    required String description,
  }) async {
    if (images.isEmpty) throw 'wajib upload foto product';
    final id = await _db.insert('products', {
      'name': name,
      'qty': qty,
      'shop_id': shopId,
      'price': price,
      'images': jsonEncode(images),
      'description': description,
    });
    return CreateProduct(
      id: id,
      name: name,
      price: price,
      images: images,
      description: description,
      qty: qty,
    );
  }

  // TODO
  Future<DetailProduct> get(int id) async {
    final row = await _db.query('products', where: 'id', whereArgs: [id]);
    if (row.isEmpty) throw 'Product tidak ditemukan';
    return DetailProduct.fromMap(row.first);
  }
}
