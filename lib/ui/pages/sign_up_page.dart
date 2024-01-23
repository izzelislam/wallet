import 'package:bank_sha/blocs/auth/auth_bloc.dart';
import 'package:bank_sha/models/sign_up_form_model.dart';
import 'package:bank_sha/shared/method.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/pages/sign_up_profile_page.dart';
import 'package:bank_sha/ui/widgets/button.dart';
import 'package:bank_sha/ui/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nameController = TextEditingController(text: '');
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');

  bool validate() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      customSnackbar(context, "Data harus terisi semua");
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailed){
          customSnackbar(context, state.e);
        }

        if (state is AuthCheckEmailSuccess){
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => SignUpProfilePage(
                data: SignUpFormModel(
                  name: nameController.text,
                  email: emailController.text,
                  password: passwordController.text
                ),
              )
            )
          );
        }

      },
      builder: (context, state) {

        if (state is AuthLoading){
          return const Center(child: CircularProgressIndicator(),);
        }

        return Scaffold(
          backgroundColor: lightBG,
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
              Container(
                width: 155,
                height: 50,
                margin: const EdgeInsets.only(top: 100, bottom: 100),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/img_logo_light.png"))),
              ),
              Text("Join Us to Unlock\nYour Growth",
                  style: darkTextStyle.copyWith(
                      fontSize: 20, fontWeight: semiBold)),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: whiteColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // email input
                    CsutomTextField(
                      title: "Full Name",
                      controller: nameController,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CsutomTextField(
                      title: "Email Address",
                      controller: emailController,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CsutomTextField(
                      title: "Password",
                      obsecure: true,
                      controller: passwordController,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomFilledButton(
                      title: "Continue",
                      onPressed: () {
                        var isvalidated = validate();
                        if (isvalidated) {
                          context.read<AuthBloc>().add(AuthCheckEmail(emailController.text));
                        }
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              CustomTextButton(
                title: "Sign In",
                onPressed: () {
                  Navigator.pushNamed(context, "/login");
                },
              )
            ],
          ),
        );
      },
    );
  }
}
