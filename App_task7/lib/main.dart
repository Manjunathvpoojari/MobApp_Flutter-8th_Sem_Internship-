import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'product_storage_service.dart';
import 'product_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://zebeimpvhckbylipxiat.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InplYmVpbXB2aGNrYnlsaXB4aWF0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzQyMzYxNTAsImV4cCI6MjA4OTgxMjE1MH0.B2tlP5L2FtJVo7qGfUbcDnyNOOL2Vnrw3wqClKvQ_PM',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ProductPage());
  }
}

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final service = ProductStorageService();
  final List<ProductFile> files = [];

  // IMAGE
  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (picked != null) {
      final bytes = await picked.readAsBytes();
      final path = "products/images/${picked.name}";

      await service.uploadImage(path, bytes);

      setState(() {
        files.add(
          ProductFile(
            name: picked.name,
            path: path,
            type: "image",
            size: bytes.length,
            url: service.getPublicUrl(path),
            uploadedAt: DateTime.now(),
          ),
        );
      });
    }
  }

  // PDF
  Future<void> uploadPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      withData: true,
    );

    if (result != null) {
      final file = result.files.first;

      final path = "products/pdfs/${file.name}";
      await service.uploadPdf(path, file.bytes!);

      setState(() {
        files.add(
          ProductFile(
            name: file.name,
            path: path,
            type: "pdf",
            size: file.size,
            url: service.getPublicUrl(path),
            uploadedAt: DateTime.now(),
          ),
        );
      });
    }
  }

  // VIDEO
  Future<void> uploadVideo() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      withData: false,
    );

    if (result != null) {
      final file = result.files.first;

      final path = "products/videos/${file.name}";
      await service.uploadVideo(path, File(file.path!));

      setState(() {
        files.add(
          ProductFile(
            name: file.name,
            path: path,
            type: "video",
            size: file.size,
            url: service.getPublicUrl(path),
            uploadedAt: DateTime.now(),
          ),
        );
      });
    }
  }

  // DELETE
  Future<void> deleteFile(ProductFile file) async {
    await service.deleteFile(file.path);
    setState(() => files.remove(file));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Shop Page")),
      body: Column(
        children: [
          Text("Total Files: ${files.length}"),

          Expanded(
            child: ListView.builder(
              itemCount: files.length,
              itemBuilder: (_, i) {
                final f = files[i];

                return ListTile(
                  leading: f.type == "image"
                      ? CachedNetworkImage(imageUrl: f.url)
                      : const Icon(Icons.insert_drive_file),
                  title: Text(f.name),
                  subtitle: Text("${f.size} bytes"),
                  onTap: () => launchUrl(Uri.parse(f.url)),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => deleteFile(f),
                  ),
                );
              },
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: pickImage, child: const Text("Image")),
              ElevatedButton(onPressed: uploadPdf, child: const Text("PDF")),
              ElevatedButton(
                onPressed: uploadVideo,
                child: const Text("Video"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
