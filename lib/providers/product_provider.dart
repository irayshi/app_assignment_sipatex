import 'package:app_assignment_sipatex/models/product.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class ProductProvider {
  static ProductProvider get to => Get.find();

  final Database _db;
  ProductProvider({required Database db}) : _db = db;

  Future<List<int>> getAll({int limit = 20, int offset = 0}) async {
    final row = await _db.query(
      'products',
      columns: ['id'],
      limit: limit,
      offset: offset,
    );
    return row.map((e) => e['id'] as int).toList();
  }

  Future<Product> create({
    required String name,
    required int qty,
    required int shopId,
    required int price,
    required List<String> images,
  }) async {
    final id = await _db.insert('products', {
      'name': name,
      'qty': qty,
      'shop_id': shopId,
      'price': price,
      'rating': null,
      'images': '[]',
    });
    return Product(
      id: id,
      name: name,
      qty: qty,
      shopId: shopId,
      price: price,
      rating: null,
      images: [],
    );
  }

  Future<Product> get(int id) async {
    final row = await _db.query('products', where: 'id', whereArgs: [id]);
    if(row.isEmpty) throw 'Product tidak ditemukan';
    return Product.fromMap(row.first);
  }
}
