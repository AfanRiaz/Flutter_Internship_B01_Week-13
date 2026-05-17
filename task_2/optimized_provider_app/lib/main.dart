import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/cart_provider.dart';
import 'provider/favorite_provider.dart';
import 'provider/product_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductProvider()..loadInitialProducts(),
        ),

        // Lazy initialization
        ChangeNotifierProvider(
          lazy: true,
          create: (_) => FavoriteProvider(),
        ),

        ChangeNotifierProvider(
          lazy: true,
          create: (_) => CartProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Optimized Provider App',
        theme: ThemeData(
          primarySwatch: Colors.green,
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}