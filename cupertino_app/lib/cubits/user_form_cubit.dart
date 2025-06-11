
import 'package:cupertino_app/locator.dart';
import 'package:cupertino_app/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/user.dart';

class UserFormState {
  final bool submitting;
  final String? error;

  const UserFormState({this.submitting = false, this.error});
}

class UserFormCubit extends Cubit<UserFormState>{
  final _repo = locator<UserRepository>();

  UserFormCubit():  super(const UserFormState());

  Future<void> submitCreate(String name, String email) async {
    emit(const UserFormState(submitting: true));

    try {
      final user = _repo.createNew(name: name, email: email);
      await _repo.addUser(user);
      emit(const UserFormState());
    } catch (e) {
      emit(UserFormState(error: e.toString()));
    }
  }

  Future<void> submitUpdate(User user, String name, String email) async{
    emit(const UserFormState(submitting: true));

    try {
      final updatedUser = user.copyWith(name: name, email: email);
      await _repo.updateUser(updatedUser);
      emit(const UserFormState());
    } catch(e) {
      emit(UserFormState(error: e.toString()));
    }
  }
}