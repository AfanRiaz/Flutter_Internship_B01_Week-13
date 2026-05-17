import 'package:flutter/material.dart';

import '../models/product_model.dart';

class ProductTile extends StatelessWidget {

  final ProductModel product;
  final VoidCallback onTap;

  const ProductTile({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return Card(

      child: ListTile(

        title: Text(product.name),

        subtitle: Text(
          "Views : ${product.views}",
        ),

        trailing: const Icon(Icons.arrow_forward),

        onTap: onTap,
      ),
    );
  }
}