import 'package:dio/dio.dart';

import '../model/userModel.dart';

class UserProvider {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://reqres.in/api/',
    headers: {
      'x-api-key': 'reqres-free-v1', // Add your custom header here
    },
  ));

  Future<User> getUsers() async {
    try {
      final response = await _dio.get('users?page=1');
      if (response.statusCode == 200) {
        final user = User.fromJson(response.data);
        return user;
      } else {
        return Future.error('Failed to load user');
      }
    } catch (e) {
      return Future.error(e.toString());
      // Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
