import '../models/models.dart';

class FakeApiService {

  static const List<String> images = [
    'assets/pic1.png',
    'assets/pic2.png',
    'assets/pic3.png',
  ];

  static Future<List<ProductModel>> fetchProducts(int page) async {

    await Future.delayed(const Duration(seconds: 2));

    return List.generate(10, (index) {

      int itemNumber = (page * 10) + index;

      return ProductModel(
        id: '$itemNumber',
        name: 'Product $itemNumber',
        price: (itemNumber + 1) * 50,

        // Different images
        imagePath: images[index % images.length],
      );
    });
  }
}