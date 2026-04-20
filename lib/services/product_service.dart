import 'package:dio/dio.dart';
import 'api_client.dart';

class ProductService {
  static Future<List<dynamic>> getProducts({
    String? category,
    String? query,
  }) async {
    final response = await ApiClient.dio.get('/products', queryParameters: {
      if (category != null && category != 'All') 'category': category,
      if (query != null && query.isNotEmpty) 'query': query,
    });
    return response.data as List;
  }

  static Future<dynamic> createProduct({
    required String title,
    required double price,
    required String category,
    required String condition,
    required String description,
    required String location,
    required double latitude,
    required double longitude,
    required List<String> imagePaths, // local file paths
  }) async {
    await ApiClient.addAuthHeader();

    final formData = FormData();
    formData.fields.addAll([
      MapEntry('title', title),
      MapEntry('price', price.toString()),
      MapEntry('category', category),
      MapEntry('condition', condition),
      MapEntry('description', description),
      MapEntry('location', location),
      MapEntry('latitude', latitude.toString()),
      MapEntry('longitude', longitude.toString()),
    ]);
    for (final path in imagePaths) {
      formData.files.add(MapEntry(
        'images',
        await MultipartFile.fromFile(path),
      ));
    }

    final response = await ApiClient.dio.post('/products',
        data: formData,
        options: Options(contentType: 'multipart/form-data'));
    return response.data;
  }

  static Future<List<dynamic>> getMyListings() async {
    await ApiClient.addAuthHeader();
    final response = await ApiClient.dio.get('/products/my-listings');
    return response.data as List;
  }
}