
import 'package:cupertino_app/models/user.dart';
import 'package:cupertino_app/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../locator.dart';

class UserListState {
  final List<User> users;
  final bool loading;
  final String? error;

  const UserListState({this.users = const [], this.loading =  false, this.error});
}

class UserListCubit extends Cubit<UserListState>{
  final _repo = locator<UserRepository>();

  UserListCubit(): super(const UserListState());

  Future<void> loadUsers () async {
    emit(const UserListState(loading: true));
    try {
      final users = await _repo.fetchAllUsers();
      emit(UserListState(users: users));
    } catch (e) {
      emit(UserListState(error: e.toString()));
    }
  }

  Future<void> deleteUser (String id) async {
    await _repo.deleteUser(id);
    loadUsers();
  }
}