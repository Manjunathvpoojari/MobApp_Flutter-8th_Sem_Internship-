import 'dart:io';
import 'dart:typed_data';
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
    // withData: false → video is large, avoids loading into RAM
    return await _bucket.upload(path, file);
  }

  String getUrl(String path) {
    return _bucket.getPublicUrl(path);
  }

  Future<void> delete(String path) async {
    await _bucket.remove([path]);
  }

  Future<List<FileObject>> list(String path) async {
    return await _bucket.list(path: path);
  }
}
