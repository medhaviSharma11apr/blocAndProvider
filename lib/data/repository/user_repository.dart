import 'package:blocandprov/data/Model/userModel.dart'; // Corrected casing here
import 'package:blocandprov/data/provider/user_provider.dart';
import 'package:flutter/material.dart'; // Added missing import for BuildContext

abstract class IUserRepository {
  Future<User> getUsers(
     ); // Pass context if needed by provider
}

class UserRepository implements IUserRepository {
  final UserProvider userProvider;
  UserRepository(this.userProvider);

  @override
  Future<User> getUsers() {
    // Accept context
    // Pass the context to the provider's method
    return userProvider.getUsers();
  }
}
