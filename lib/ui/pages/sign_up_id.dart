import 'dart:convert';
import 'dart:io';

import 'package:bank_sha/blocs/auth/auth_bloc.dart';
import 'package:bank_sha/models/sign_up_form_model.dart';
import 'package:bank_sha/shared/method.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SignUpIdPage extends StatefulWidget {
  final SignUpFormModel data;

  const SignUpIdPage({super.key, required this.data});

  @override
  State<SignUpIdPage> createState() => _SignUpIdPageState();
}

class _SignUpIdPageState extends State<SignUpIdPage> {
  XFile? selectedImage;

  bool validate() {
    if (selectedImage == null) {
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
            return const Center(child: CircularProgressIndicator());
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
              Text("Verify Your\nAccount",
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final image = await selectImage();
                            setState(() {
                              selectedImage = image;
                            });
                          },
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: lightBG,
                                image: selectedImage == null
                                    ? null
                                    : DecorationImage(
                                        image: FileImage(
                                            File(selectedImage!.path)),
                                        fit: BoxFit.cover)),
                            child: selectedImage != null
                                ? null
                                : Center(
                                    child: Image.asset(
                                      "assets/ic_upload.png",
                                      width: 32,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Passport/ID Card",
                          style: darkTextStyle.copyWith(
                              fontWeight: medium, fontSize: 18),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomFilledButton(
                      title: "Continue",
                      onPressed: () {
                        if (validate()) {

                          context.read<AuthBloc>().add(AuthRegister(widget.data.copyWith(
                            ktp : 'data:image/png;base64,'+base64Encode(File(selectedImage!.path).readAsBytesSync())
                          )));

                        } else {
                          customSnackbar(context, "Gamba rtidakboleh kosong");
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
                title: "Skip for now",
                onPressed: () {
                  context.read<AuthBloc>().add(AuthRegister(widget.data));
                },
              )
            ],
          );
        },
      ),
    );
  }
}
