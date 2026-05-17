import 'package:flutter/material.dart';
import 'package:optimized_provider_app/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final cartProvider = context.watch<CartProvider>();

    return Scaffold(

      appBar: AppBar(
        title: const Text("Checkout"),
        centerTitle: true,
      ),

      body: cartProvider.cartItems.isEmpty

          ? const Center(
        child: Text(
          "Cart is Empty",
          style: TextStyle(fontSize: 20),
        ),
      )

          : ListView.builder(

        itemCount: cartProvider.cartItems.length,

        itemBuilder: (context, index) {

          final product = cartProvider.cartItems[index];

          return Card(

            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),

            child: ListTile(

              leading: Image.asset(
                product.imagePath,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),

              title: Text(product.name),

              subtitle: Text(
                "Rs ${product.price}",
              ),

              trailing: IconButton(

                onPressed: () {

                  context
                      .read<CartProvider>()
                      .removeFromCart(product);
                },

                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}