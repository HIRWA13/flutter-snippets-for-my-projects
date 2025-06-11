import 'package:cupertino_app/cubits/user_list_cubit.dart';
import 'package:cupertino_app/locator.dart';
import 'package:cupertino_app/screens/user_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'User Management',
      home: BlocProvider(
        create: (_) => UserListCubit()..loadUsers(),
        child: UserListPage(),
      ),
    );
  }
}
