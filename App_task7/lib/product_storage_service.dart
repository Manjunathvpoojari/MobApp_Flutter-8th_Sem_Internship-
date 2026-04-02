import 'dart:io';
import 'dart:typed_data'; // ✅ ADD THIS
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductStorageService {
  final _bucket = Supabase.instance.client.storage.from('Shop_Product');

  Future<String> uploadImage(String path, Uint8List bytes) async {
    return await _bucket.uploadBinary(path, bytes);
  }

  Future<String> uploadPdf(String path, Uint8List bytes) async {
    return await _bucket.uploadBinary(path, bytes);
  }

  Future<String> uploadVideo(String path, File file) async {
    // IMPORTANT: video is large → don't load into memory
    return await _bucket.upload(path, file);
  }

  String getPublicUrl(String path) {
    return _bucket.getPublicUrl(path);
  }

  Future<void> deleteFile(String path) async {
    await _bucket.remove([path]);
  }

  Future<List<FileObject>> listFiles(String folder) async {
    return await _bucket.list(path: folder);
  }
}
