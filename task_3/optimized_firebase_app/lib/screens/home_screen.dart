import 'package:flutter/material.dart';

// Deferred Import
import 'profile_screen.dart' deferred as profile;

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {

  bool isLoading = false;

  // =========================
  // LOAD PROFILE FEATURE
  // =========================

  Future<void> openProfile() async {

    setState(() {
      isLoading = true;
    });

    // Lazy Load Screen
    await profile.loadLibrary();

    setState(() {
      isLoading = false;
    });

    // Navigate
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
        const profile.ProfileScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Deferred Loading App",
        ),
      ),

      body: Center(

        child: isLoading

            ? const CircularProgressIndicator()

            : ElevatedButton(

          onPressed: openProfile,

          child: const Text(
            "Open Profile Screen",
          ),
        ),
      ),
    );
  }
}