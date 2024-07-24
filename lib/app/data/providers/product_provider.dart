import 'dart:convert';

import 'package:app_assignment_sipatex/app/data/databases/database_helper.dart';
import 'package:app_assignment_sipatex/app/data/models/product_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

class ProductProvider extends GetxController {
  static ProductProvider get to => Get.find();
  late Database _database;
  final baseUrl = 'https://dummyapi.online/api';
  final products = <Product>[].obs;

  @override
  Future<void> onInit() async {
    _database = await DatabaseHelper().database;
    products.value = await _getLocal();
    if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
      return;
    }
    final dataApi = await _getApi();

    if (_productExists(products, dataApi)) return;
    for (var product in dataApi) {
      create(product);
    }
    products.value = await _getLocal();

    super.onInit();
  }

  Future<List<Product>> _getApi() async {
    final response = await http.get(
      Uri.parse('$baseUrl/products'),
    );
    final List data = jsonDecode(response.body);
    return data.map((e) => Product.fromJson(e)).toList();
  }

  Future<List<Product>> _getLocal() async {
    var data = await _database.query('products');

    return data.map((e) {
      final mutableE = Map<String, dynamic>.from(e);
      mutableE['storageOptions'] = jsonDecode(mutableE['storageOptions']);
      mutableE['colorOptions'] = jsonDecode(mutableE['colorOptions']);
      mutableE['camera'] = jsonDecode(mutableE['camera']);
      mutableE['inStock'] = mutableE['inStock'] == 1;
      return Product.fromJson(mutableE);
    }).toList();
  }

  void create(Product product) async {
    final data = {
      'id': product.id,
      'productCategory': product.productCategory,
      'name': product.name,
      'brand': product.brand,
      'description': product.description,
      'basePrice': product.basePrice,
      'inStock': product.inStock ? 1 : 0,
      'stock': product.stock,
      'featuredImage': product.featuredImage,
      'thumbnailImage': product.thumbnailImage,
      'storageOptions': jsonEncode(product.storageOptions),
      'colorOptions': jsonEncode(product.colorOptions),
      'display': product.display,
      'CPU': product.cPU,
      'GPU': product.gPU,
      'camera': jsonEncode(product.camera?.toJson()),
    };
    await _database.insert('products', data);
  }

  void edit(Product product) async {
    final data = {
      'id': product.id,
      'productCategory': product.productCategory,
      'name': product.name,
      'brand': product.brand,
      'description': product.description,
      'basePrice': product.basePrice,
      'inStock': product.inStock ? 1 : 0,
      'stock': product.stock,
      'featuredImage': product.featuredImage,
      'thumbnailImage': product.thumbnailImage,
      'storageOptions': jsonEncode(product.storageOptions),
      'colorOptions': jsonEncode(product.colorOptions),
      'display': product.display,
      'CPU': product.cPU,
      'GPU': product.gPU,
      'camera': jsonEncode(product.camera?.toJson()),
    };
    await _database.update(
      'products',
      data,
      where: 'id = ?',
      whereArgs: [product.id!],
    );
  }

  bool _productExists(List<Product> dataLocal, List<Product> dataApi) {
    return dataApi.any(
      (productApi) {
        final productLocal =
            dataLocal.map((productLokal) => productLokal.name).toList();

        return productLocal.contains(productApi.name);
      },
    );
  }

  void delete(int id) async {
    await _database.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
