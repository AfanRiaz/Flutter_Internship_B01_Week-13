import 'dart:convert';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cached_network_image/cached_network_image.dart';


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
  List<String> images = [];
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
              mainAxisSpacing: 10,
            ),
            itemCount: images.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index){
              return ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: images[index],fit: BoxFit.cover,
                  placeholder: (context, images){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  errorWidget: (context, images, error){
                    return Icon(Icons.error_outline);
                  },
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //Pick Image from gallery
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
  //compress image
  Future<void> compressFile(String path) async{
    final compressedImag = await FlutterImageCompress.compressAndGetFile(
      path, '${path}_comp.jpg',
      quality: 60,
    );
    if(compressedImag != null) {
       await uploadToImgBB(compressedImag.path);
    }
  }
  Future<void> uploadToImgBB(String imagePath) async{
    const String apiKey = '213b33cf8401e1c6d240cc08e8615692';
    final url = Uri.parse('https://api.imgbb.com/1/upload?key=$apiKey',);
    final request = http.MultipartRequest(
      'POST',
      url,
    );
    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        imagePath
      )
    );
    final response = await request.send();

    if(response.statusCode == 200){
      final responseData = await response.stream.bytesToString();
      final jsonData = jsonDecode(responseData);
      final imageUrl = jsonData['data']['display_url'];
      setState(() {
        images.add(imageUrl);
      });
      Fluttertoast.showToast(msg: imageUrl);
    }
    else{
      Fluttertoast.showToast(msg: 'Error Occurred');
    }
  }
}