import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../services/firestore_service.dart';
import '../widgets/product_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final FirestoreService firestoreService =
  FirestoreService();

  List<ProductModel> products = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    loadProducts();
  }

  // =========================
  // LOAD PRODUCTS
  // =========================

  Future<void> loadProducts() async {

    setState(() {
      isLoading = true;
    });

    List<ProductModel> fetchedProducts =
    await firestoreService.fetchProducts();

    products.addAll(fetchedProducts);

    setState(() {
      isLoading = false;
    });
  }

  // =========================
  // INCREMENT VIEWS
  // =========================

  Future<void> increaseViews(String id) async {

    await firestoreService.incrementViews(id);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Views Increased"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: const Text("Optimized Firestore App"),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {

          await firestoreService.batchInsert();

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Batch Insert Success"),
            ),
          );
        },

        child: const Icon(Icons.add),
      ),

      body: Column(
        children: [

          Expanded(
            child: ListView.builder(
              itemCount: products.length,

              itemBuilder: (context, index) {

                return ProductTile(

                  product: products[index],

                  onTap: () async {

                    setState(() {
                    });
                    await increaseViews(
                      products[index].id,
                    );
                  },
                );
              },
            ),
          ),

          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(10),
              child: CircularProgressIndicator(),
            ),

          ElevatedButton(
            onPressed: loadProducts,
            child: const Text("Load More"),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}