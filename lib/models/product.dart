class Product {
  final int id;
  final String name;
  final int totalSales;
  final int price;
  final String img;
  final String address;
  final String? favoriteId;
  final double? rating;

  const Product({
    required this.id,
    required this.name,
    this.totalSales = 0,
    required this.price,
    required this.img,
    required this.address,
    required this.favoriteId,
    required this.rating,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      totalSales: map['total_sales'],
      price: map['price'],
      img: map['img'],
      address: map['address'],
      favoriteId: map['favorite_id'],
      rating: map['rating'],
    );
  }
}
