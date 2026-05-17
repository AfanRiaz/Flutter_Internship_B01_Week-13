import 'package:flutter/material.dart';
import 'package:optimized_provider_app/provider/cart_provider.dart';
import 'package:optimized_provider_app/provider/product_provider.dart';
import 'package:optimized_provider_app/screens/checkout_screen.dart';
import 'package:optimized_provider_app/widgets/product_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {

      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300) {

        context.read<ProductProvider>().fetchMoreProducts();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final cartCount = context.select<CartProvider, int>(
          (provider) => provider.cartCount,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Grocery Store'),

        actions: [

          Stack(
            children: [

              IconButton(
                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CheckoutScreen(),
                    ),
                  );
                },

                icon: const Icon(Icons.shopping_cart),
              ),

              Positioned(
                right: 5,
                top: 5,

                child: CircleAvatar(
                  radius: 10,

                  child: Text(
                    '$cartCount',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {

          return GridView.builder(

            controller: _scrollController,

            padding: const EdgeInsets.all(10),

            physics: const BouncingScrollPhysics(),

            itemCount: productProvider.products.length +
                (productProvider.isLoading ? 1 : 0),

            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(

              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.75,
            ),

            itemBuilder: (context, index) {

              if (index >= productProvider.products.length) {

                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final product = productProvider.products[index];

              return ProductCard(product: product);
            },
          );
        },
      ),
    );
  }
}