import 'package:dio/dio.dart';
import 'http_services.dart';

class DioService extends HttpService {
  late Dio dio;

  DioService(super.url) {
    dio = Dio(BaseOptions(baseUrl: url));
  }

  @override
  Future get(String path) async {
    try {
      final response = await dio.get(path);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  @override
  Future post(String path, data) async {
    try {
      final response = await dio.post(path, data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception('Failed to post data');
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  @override
  Future put(String path, data) async {
    try {
      final response = await dio.put(path, data: data);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to update data');
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  @override
  Future patch(String path, data) async {
    try {
      final response = await dio.patch(path, data: data);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to patch data');
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  @override
  Future delete(String path) async {
    try {
      final response = await dio.delete(path);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to delete data');
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
