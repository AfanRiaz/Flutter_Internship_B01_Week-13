import 'package:flutter/material.dart';
import 'package:optimized_provider_app/models/models.dart';
import 'package:optimized_provider_app/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {

  final ProductModel product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {

    return Card(

      child: Padding(

        padding: const EdgeInsets.all(10),

        child: Column(

          children: [

            Expanded(
              child: Image.asset(
                product.imagePath,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              product.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            Text("Rs ${product.price}"),

            const SizedBox(height: 10),

            ElevatedButton(

              onPressed: () {

                context
                    .read<CartProvider>()
                    .addToCart(product);
              },

              child: const Text("Add To Cart"),
            ),
          ],
        ),
      ),
    );
  }
}