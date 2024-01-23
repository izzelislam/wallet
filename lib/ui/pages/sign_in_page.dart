import 'package:bank_sha/blocs/auth/auth_bloc.dart';
import 'package:bank_sha/models/sign_in_form_model.dart';
import 'package:bank_sha/shared/method.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/widgets/button.dart';
import 'package:bank_sha/ui/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');

  bool validate(){
    if (emailController.text.isEmpty || passwordController.text.isEmpty){
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          
          if (state is AuthFailed){
            customSnackbar(context, state.e);
          }

          if (state is AuthSuccess){
            Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
          }

        },
        builder: (context, state) {

          if (state is AuthLoading){
            return const Center(child: CircularProgressIndicator(),);
          }

          return ListView(
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
              Text("Sign In &\nGrow Your Finance",
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
                      height: 8,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text("Forgoot Password", style: blueTextStyle),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomFilledButton(
                      title: "Sign In",
                      onPressed: () {
                        if (validate()){
                          context.read<AuthBloc>().add(AuthLogin(SignInFormModel(
                            email: emailController.text,
                            password: passwordController.text
                          )));
                        }else{
                          customSnackbar(context, "Email dan Password wajib diisi.");
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
                title: "Create New Account",
                onPressed: () {
                  Navigator.pushNamed(context, "/register");
                },
              )
            ],
          );
        },
      ),
    );
  }
}
