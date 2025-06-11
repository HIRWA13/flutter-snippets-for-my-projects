import 'package:cupertino_app/cubits/user_list_cubit.dart';
import 'package:cupertino_app/screens/user_form_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Users'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.add),
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (_) => UserFormPage()),
            ).then((_) => context.read<UserListCubit>().loadUsers());
          },
        ),
      ),
      child: BlocBuilder<UserListCubit, UserListState>(
        builder: (context, state) {
          if (state.loading) {
            return Center(child: CupertinoActivityIndicator());
          }

          if (state.error != null) {
            return Center(child: Text('Error: ${state.error}'));
          }

          final users = state.users;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (_, i) {
              final u = users[i];
              return CupertinoListTile(
                title: Text(u.name),
                subtitle: Text(u.email),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Icon(CupertinoIcons.pencil),
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (_) => UserFormPage(user: u),
                          ),
                        ).then(
                          (_) => context.read<UserListCubit>().loadUsers(),
                        );
                      },
                    ),
                    CupertinoButton(child: Icon(CupertinoIcons.delete), onPressed: () {
                      context.read<UserListCubit>().deleteUser(u.id);
                    })
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
