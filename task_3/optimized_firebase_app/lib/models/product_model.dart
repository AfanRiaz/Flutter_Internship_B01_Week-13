class ProductModel {

  final String id;
  final String name;
  final String category;
  final bool isAvailable;
  final int views;
  final List<dynamic> tags;

  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.isAvailable,
    required this.views,
    required this.tags,
  });

  factory ProductModel.fromFirestore(
      Map<String, dynamic> data,
      String documentId,
      ) {

    return ProductModel(
      id: documentId,
      name: data['name'] ?? '',
      category: data['category'] ?? '',
      isAvailable: data['isAvailable'] ?? false,
      views: data['views'] ?? 0,
      tags: data['tags'] ?? [],
    );
  }
}