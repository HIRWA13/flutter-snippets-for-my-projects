import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;

  const User({required this.id, required this.name, required this.email});

  User copyWith({String? name, String? email}) {
    return User(id: id, name: name ?? this.name, email: email ?? this.email);
  }

  @override
  List<Object?> get props => [id, name, email];
}
