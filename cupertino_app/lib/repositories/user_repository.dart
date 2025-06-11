import 'package:uuid/uuid.dart';

import '../models/user.dart';

class UserRepository {
  final _users = <User>[];
  final _uuid  = const Uuid();

  Future<List<User>> fetchAllUsers() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_users);
  }

  Future<void> addUser(User user) async {
    _users.add(user);
  }

  Future<void> updateUser (User user) async {
    final idx = _users.indexWhere((u) => u.id  == user.id);
    if(idx != -1) _users[idx] = user;
  }

  Future<void> deleteUser (String id) async  {
    _users.removeWhere((u) => u.id ==  id); 
  }

  User  createNew({required String name, required String email}) {
    return User(id: _uuid.v4(), name: name, email: email);
  }
}