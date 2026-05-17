class ProductModel {

  final String id;
  final String name;
  final int views;
  final List<dynamic> tags;

  ProductModel({
    required this.id,
    required this.name,
    required this.views,
    required this.tags,
  });

  factory ProductModel.fromFirestore(
      Map<String, dynamic> data,
      String id,
      ) {

    return ProductModel(
      id: id,
      name: data['name'] ?? '',
      views: data['views'] ?? 0,
      tags: data['tags'] ?? [],
    );
  }
}