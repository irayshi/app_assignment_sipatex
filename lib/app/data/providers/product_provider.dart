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
  void onInit() async {
    _database = await DatabaseHelper().database;
    initProduct();
    super.onInit();
  }

  void initProduct() async {
    products.value = await _getLocal();
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return;
    }
    final dataApi = await _getApi();
    final missingProducts = _getMissingProducts(products, dataApi);
    if (missingProducts.isNotEmpty) {
      for (final product in missingProducts) {
        create(product);
      }
    }
  }

  List<Product> _getMissingProducts(
    List<Product> dataLocal,
    List<Product> dataApi,
  ) {
    final productLocalNames =
        dataLocal.map((product) => product.name.toLowerCase()).toList();

    return dataApi
        .where((productApi) =>
            !productLocalNames.contains(productApi.name.toLowerCase()))
        .toList();
  }

  Future<List<Product>> _getApi() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products'),
      );
      final List data = jsonDecode(response.body);
      return data.map((e) => Product.fromJson(e)).toList();
    } catch (e) {
      Get.rawSnackbar(message: 'Error: saat mengambil data api');
      rethrow;
    }
  }

  Future<List<Product>> _getLocal() async {
    try {
      var data = await _database.query('products');
      return data.map((e) {
        final mutableE = Map<String, dynamic>.from(e);
        mutableE['storageOptions'] = jsonDecode(mutableE['storageOptions']);
        mutableE['colorOptions'] = jsonDecode(mutableE['colorOptions']);
        mutableE['camera'] = jsonDecode(mutableE['camera']);
        mutableE['inStock'] = mutableE['inStock'] == 1;
        return Product.fromJson(mutableE);
      }).toList();
    } catch (e) {
      Get.rawSnackbar(
          message:
              'Error: saat mengambil data products dari database. Mohon refresh halaman!');
      rethrow;
    }
  }

  Future<void> create(Product product) async {
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
    initProduct();
  }

  Future<void> edit(Product product) async {
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
    initProduct();
  }

  Future<void> delete(int id) async {
    await _database.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
    initProduct();
  }

  Future<bool> productExists(String productName) async {
    final products = await _database.query(
      'products',
      where: 'name = ?',
      whereArgs: [productName],
    );
    return products.isEmpty ? false : true;
  }
}
