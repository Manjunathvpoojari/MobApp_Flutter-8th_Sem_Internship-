class ProductFile {
  final String name;
  final String path;
  final String type;
  final int size;
  final String url;
  final DateTime uploadedAt;

  ProductFile({
    required this.name,
    required this.path,
    required this.type,
    required this.size,
    required this.url,
    required this.uploadedAt,
  });
}
