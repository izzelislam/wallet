import 'package:bank_sha/blocs/auth/auth_bloc.dart';
import 'package:bank_sha/models/user_edit_form_model.dart';
import 'package:bank_sha/shared/method.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/widgets/button.dart';
import 'package:bank_sha/ui/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final usernameController = TextEditingController(text: '');
  final fullnameController = TextEditingController(text: '');
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');

  bool validate(){
    if (usernameController.text.isEmpty || fullnameController.text.isEmpty || emailController.text.isEmpty || passwordController.text.isEmpty){
      return false;
    }

    return true;
  }

  @override
  void initState() {
    super.initState();

    final authState = context.read<AuthBloc>().state;

    if (authState is AuthSuccess) {
      usernameController.text = authState.data.username!;
      fullnameController.text = authState.data.name!;
      emailController.text = authState.data.email!;
      passwordController.text = authState.data.password!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed){
            customSnackbar(context, state.e);
          }

          if (state is AuthSuccess){
            Navigator.pushNamedAndRemoveUntil(context,
                              "/profile-edit-success", (route) => false);
          }

        },
        builder: (context, state) {

          if (state is AuthLoading){
            return const Center(child: CircularProgressIndicator(),);
          }

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: whiteColor),
                child: Column(
                  children: [
                    CsutomTextField(
                      title: "Username",
                      controller: usernameController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CsutomTextField(
                      title: "Fullname",
                      controller: fullnameController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CsutomTextField(
                      title: "Email Address",
                      controller: emailController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CsutomTextField(
                      title: "password",
                      obsecure: true,
                      controller: passwordController,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomFilledButton(
                        title: "Update Now",
                        onPressed: () {
                          if (validate()){
                            context.read<AuthBloc>().add(AuthUpdateUser(UserEditFormModel(name: fullnameController.text, username: usernameController.text, email: emailController.text, password: passwordController.text)));
                          }
                        })
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
