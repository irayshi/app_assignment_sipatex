class CreateProduct {
  final int id;
  final String name;
  final int price;
  final List<String> images;
  final String description;
  final int totalSales;
  final int totalViews;
  final int totalFavorites;
  final int qty;

  const CreateProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.images,
    required this.description,
    this.totalSales = 0,
    this.totalViews = 0,
    this.totalFavorites = 0,
    required this.qty,
  });

  factory CreateProduct.fromMap(Map<String, dynamic> map) {
    return CreateProduct(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      images: map['images'],
      description: map['description'],
      qty: map['qty'],
    );
  }
}
