class Product {
  int? id;
  String? productCategory;
  String? name;
  String? brand;
  String? description;
  int? basePrice;
  bool? inStock;
  int? stock;
  String? featuredImage;
  String? thumbnailImage;
  List<String>? storageOptions;
  List<String>? colorOptions;
  String? display;
  String? cPU;
  Camera? camera;

  Product(
      {this.id,
      this.productCategory,
      this.name,
      this.brand,
      this.description,
      this.basePrice,
      this.inStock,
      this.stock,
      this.featuredImage,
      this.thumbnailImage,
      this.storageOptions,
      this.colorOptions,
      this.display,
      this.cPU,
      this.camera});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productCategory = json['productCategory'];
    name = json['name'];
    brand = json['brand'];
    description = json['description'];
    basePrice = json['basePrice'];
    inStock = json['inStock'];
    stock = json['stock'];
    featuredImage = json['featuredImage'];
    thumbnailImage = json['thumbnailImage'];
    storageOptions = json['storageOptions']?.cast<String>();
    colorOptions = json['colorOptions']?.cast<String>();
    display = json['display'];
    cPU = json['CPU'];
    camera = json['camera'] != null ? Camera?.fromJson(json['camera']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['productCategory'] = productCategory;
    data['name'] = name;
    data['brand'] = brand;
    data['description'] = description;
    data['basePrice'] = basePrice;
    data['inStock'] = inStock;
    data['stock'] = stock;
    data['featuredImage'] = featuredImage;
    data['thumbnailImage'] = thumbnailImage;
    data['storageOptions'] = storageOptions;
    data['colorOptions'] = colorOptions;
    data['display'] = display;
    data['CPU'] = cPU;
    if (camera != null) {
      data['camera'] = camera?.toJson();
    }
    return data;
  }
}

class Camera {
  String? rearCamera;
  String? frontCamera;

  Camera({this.rearCamera, this.frontCamera});

  Camera.fromJson(Map<String, dynamic> json) {
    rearCamera = json['rearCamera'];
    frontCamera = json['frontCamera'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['rearCamera'] = rearCamera;
    data['frontCamera'] = frontCamera;
    return data;
  }
}
