import 'dart:io';
// ignore: unused_import
import 'dart:typed_data';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'product_model.dart';
import 'product_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
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
  String formatSize(int bytes) {
    if (bytes >= 1024 * 1024) {
      return "${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB";
    } else if (bytes >= 1024) {
      return "${(bytes / 1024).toStringAsFixed(1)} KB";
    } else {
      return "$bytes B";
    }
  }

  void showUploadOptions() {
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.photo_camera),
            title: const Text("Add Product Photo"),
            onTap: () {
              Navigator.pop(context);
              pickImage();
            },
          ),
          ListTile(
            leading: const Icon(Icons.picture_as_pdf, color: Colors.orange),
            title: const Text("Upload Price List"),
            onTap: () {
              Navigator.pop(context);
              uploadPdf();
            },
          ),
          ListTile(
            leading: const Icon(Icons.video_file, color: Colors.green),
            title: const Text("Add Product Video"),
            onTap: () {
              Navigator.pop(context);
              uploadVideo();
            },
          ),
        ],
      ),
    );
  }

  final service = ProductStorageService();
  List<ProductFile> files = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    fetchFiles();
  }

  // ================= FETCH =================
  Future<void> fetchFiles() async {
    final results = await Future.wait([
      service.list('products/images'),
      service.list('products/pdfs'),
      service.list('products/videos'),
    ]);

    List<ProductFile> temp = [];

    for (var list in results) {
      for (var file in list) {
        final path = file.name;

        temp.add(
          ProductFile(
            name: file.name,
            storagePath: path,
            type: file.name.split('.').last,
            size: file.metadata?['size'] ?? 0,
            url: service.getUrl(path),
          ),
        );
      }
    }

    setState(() => files = temp);
  }

  // ================= IMAGE =================
  void pickImage() {
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text("Camera"),
            onTap: () async {
              Navigator.pop(context);
              final img = await ImagePicker().pickImage(
                source: ImageSource.camera,
              );
              if (img != null) uploadImage(img);
            },
          ),
          ListTile(
            title: const Text("Gallery"),
            onTap: () async {
              Navigator.pop(context);
              final img = await ImagePicker().pickImage(
                source: ImageSource.gallery,
              );
              if (img != null) uploadImage(img);
            },
          ),
        ],
      ),
    );
  }

  Future<void> uploadImage(XFile file) async {
    setState(() => loading = true);

    final bytes = await file.readAsBytes();
    final path = "products/images/${file.name}";

    final storagePath = await service.uploadImage(path, bytes);

    setState(() {
      files.add(
        ProductFile(
          name: file.name,
          storagePath: storagePath,
          type: "image",
          size: bytes.length,
          url: service.getUrl(storagePath),
        ),
      );
      loading = false;
    });
  }

  // ================= PDF =================
  Future<void> uploadPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      withData: true,
    );

    if (result != null) {
      final file = result.files.first;

      final path = "products/pdfs/${file.name}";
      final storagePath = await service.uploadPdf(path, file.bytes!);

      setState(() {
        files.add(
          ProductFile(
            name: file.name,
            storagePath: storagePath,
            type: "pdf",
            size: file.size,
            url: service.getUrl(storagePath),
          ),
        );
      });
    }
  }

  // ================= VIDEO =================
  Future<void> uploadVideo() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      withData: false,
    );

    if (result != null) {
      final file = result.files.first;

      final path = "products/videos/${file.name}";
      final storagePath = await service.uploadVideo(path, File(file.path!));

      setState(() {
        files.add(
          ProductFile(
            name: file.name,
            storagePath: storagePath,
            type: "video",
            size: file.size,
            url: service.getUrl(storagePath),
          ),
        );
      });
    }
  }

  // ================= DELETE =================
  Future<void> deleteFile(ProductFile file) async {
    final confirm = await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete"),
        content: const Text("Remove this file from the shop?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Yes"),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await service.delete(file.storagePath);
      setState(() => files.remove(file));

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("File removed from shop")));
    }
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Shop Product Page")),
      body: Column(
        children: [
          Text("Ravi has uploaded ${files.length} files"),

          if (loading) const Text("Uploading..."),

          Expanded(
            child: files.isEmpty
                ? const Center(
                    child: Text(
                      "No products uploaded yet. Tap a button to add files.",
                    ),
                  )
                : ListView.builder(
                    itemCount: files.length,
                    itemBuilder: (_, i) {
                      final f = files[i];

                      return Card(
                        child: ListTile(
                          leading: f.type == "image"
                              ? CachedNetworkImage(
                                  imageUrl: f.url,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                )
                              : Icon(
                                  f.type == "pdf"
                                      ? Icons.picture_as_pdf
                                      : Icons.video_file,
                                  color: f.type == "pdf"
                                      ? Colors.orange
                                      : Colors.green,
                                ),
                          title: Text(
                            f.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  formatSize(f.size),
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                          onTap: () => launchUrl(Uri.parse(f.url)),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => deleteFile(f),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: ElevatedButton.icon(
          onPressed: showUploadOptions,
          icon: const Icon(Icons.upload),
          label: const Text("Upload"),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
