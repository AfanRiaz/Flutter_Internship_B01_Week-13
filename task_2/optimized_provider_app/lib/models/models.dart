class ProductModel {
  final String id;
  final String name;
  final int price;
  final String imagePath;
  final bool isFavorite;
  final int quantity;

  const ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
    this.isFavorite = false,
    this.quantity = 1,
  });

  ProductModel copyWith({
    String? id,
    String? name,
    int? price,
    String? imagePath,
    bool? isFavorite,
    int? quantity,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      imagePath: imagePath ?? this.imagePath,
      isFavorite: isFavorite ?? this.isFavorite,
      quantity: quantity ?? this.quantity,
    );
  }
}