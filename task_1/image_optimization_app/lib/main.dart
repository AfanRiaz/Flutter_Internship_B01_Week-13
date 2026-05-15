import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<File> images = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Uploading App'),
      ),
      body: images.isEmpty? Center(child: Text('No image to show')) : Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10
            ),
            itemCount: images.length,
            itemBuilder: (context, index){
              return ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                child: Image.file(images[index],fit: BoxFit.cover,),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final picker = ImagePicker();
          final XFile? pickedImage = await picker.pickImage(
            source: ImageSource.gallery,
          );
          if(pickedImage !=null){
            compressFile(pickedImage.path);
          }

        },
        child: const Icon(Icons.image, size: 40),
      ),
    );
  }
  Future<void> compressFile(String path) async{
    final compressedImag = await FlutterImageCompress.compressAndGetFile(
      path, '${path}_comp.jpg',
      quality: 60,
    );
    if(compressedImag != null) {
      setState(() {
        images.add(File(compressedImag.path));
      });
    }
  }
}