import 'package:cupertino_app/cubits/user_form_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/user.dart';

class UserFormPage extends StatefulWidget {
  final User? user;
  const UserFormPage({super.key, this.user});

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  String? nameError;
  String? emailError;

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      nameCtrl.text = widget.user!.name;
      emailCtrl.text = widget.user!.email;
    }
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    super.dispose();
  }

  bool validateInputs() {
    bool isValid = true;
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    setState(() {
      nameError = null;
      emailError = null;

      if (nameCtrl.text.trim().isEmpty) {
        nameError = 'Name cannot be empty';
        isValid = false;
      }

      final email = emailCtrl.text.trim();
      if (email.isEmpty) {
        emailError = 'Email cannot be empty';
        isValid = false;
      } else if (!emailRegex.hasMatch(email)) {
        emailError = 'Please enter a valid email address';
        isValid = false;
      }
    });

    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.user != null;

    return BlocProvider(
      create: (_) => UserFormCubit(),
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(isEditing ? 'Edit User' : 'Add User'),
          previousPageTitle: 'Users',
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: BlocListener<UserFormCubit, UserFormState>(
              listener: (context, state) {
                if (!state.submitting && state.error == null) {
                  Navigator.pop(context);
                } else if (state.error != null) {
                  showCupertinoDialog(
                    context: context,
                    builder:
                        (_) => CupertinoAlertDialog(
                          title: Text('Error'),
                          content: Text(state.error!),
                          actions: [
                            CupertinoDialogAction(
                              child: Text('Ok'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                  );
                }
              },
              child: Column(
                children: [
                  CupertinoTextField(
                    controller: nameCtrl,
                    placeholder: 'User Name',
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            nameError != null
                                ? CupertinoColors.systemRed
                                : CupertinoColors.systemGrey,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  if (nameError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0, left: 4.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          nameError!,
                          style: const TextStyle(
                            color: CupertinoColors.systemRed,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: 16),
                  CupertinoTextField(
                    controller: emailCtrl,
                    placeholder: 'User Email',
                    keyboardType: TextInputType.emailAddress,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            emailError != null
                                ? CupertinoColors.systemRed
                                : CupertinoColors.systemGrey,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  if (emailError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0, left: 4.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          emailError!,
                          style: const TextStyle(
                            color: CupertinoColors.systemRed,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: 32),
                  BlocBuilder<UserFormCubit, UserFormState>(
                    builder: (context, state) {
                      return CupertinoButton.filled(
                        onPressed:
                            state.submitting
                                ? null
                                : () {
                                  if (validateInputs()) {
                                    final cubit = context.read<UserFormCubit>();
                                    final name = nameCtrl.text.trim();
                                    final email = emailCtrl.text.trim();

                                    if (isEditing) {
                                      cubit.submitUpdate(
                                        widget.user!,
                                        name,
                                        email,
                                      );
                                    } else {
                                      cubit.submitCreate(name, email);
                                    }
                                  }
                                },
                        child:
                            state.submitting
                                ? CupertinoActivityIndicator()
                                : Text(isEditing ? 'Update' : 'Create'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
