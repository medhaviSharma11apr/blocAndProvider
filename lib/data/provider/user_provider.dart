import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../Model/userModel.dart';

class UserProvider {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://reqres.in/api/'));

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
