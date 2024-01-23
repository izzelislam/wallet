import 'dart:convert';
import 'dart:io';

import 'package:bank_sha/models/sign_up_form_model.dart';
import 'package:bank_sha/shared/method.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/pages/sign_up_id.dart';
import 'package:bank_sha/ui/widgets/button.dart';
import 'package:bank_sha/ui/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignUpProfilePage extends StatefulWidget {
  final SignUpFormModel data;

  const SignUpProfilePage({super.key, required this.data});

  @override
  State<SignUpProfilePage> createState() => _SignUpProfilePageState();
}

class _SignUpProfilePageState extends State<SignUpProfilePage> {

  final pinController = TextEditingController(text: '');
  XFile? selectedImage;

  bool validate(){
    if (pinController.text.length != 6){
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.data.password);
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          Container(
            width: 155,
            height: 50,
            margin: const EdgeInsets.only(top: 100, bottom: 100),
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/img_logo_light.png"))
            ),
          ),
          Text("Join Us to Unlock\nYour Growth", style: darkTextStyle.copyWith(
            fontSize: 20,
            fontWeight: semiBold
          )),
          const SizedBox(height: 30,),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: whiteColor
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    // Container(
                    //   width: 120,
                    //   height: 120,
                    //   decoration: BoxDecoration(
                    //     shape: BoxShape.circle,
                    //     image: DecorationImage(
                    //       image: AssetImage("assets/img_profile.png"), 
                    //       fit: BoxFit.cover
                    //     ),
                    //   ),
                    // ),

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
                          image: selectedImage == null ? null :  DecorationImage(
                            image: FileImage(File(selectedImage!.path)), 
                            fit: BoxFit.cover
                          )
                        ),
                        child:selectedImage != null ? null : Center(
                          child: Image.asset("assets/ic_upload.png", width: 32,),
                        ),
                      ),
                    ),

                    SizedBox(height: 16,),
                    Text("Shayna Hanna", style: darkTextStyle.copyWith(
                      fontWeight: medium,
                      fontSize: 18
                    ),)
                  ],
                ),
                const SizedBox(height: 30,),
                CsutomTextField(
                  title: "Set PIN (6 digit number)",
                  obsecure: true,
                  controller: pinController,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 30,),
                CustomFilledButton(title: "Continue", onPressed: (){

                  if (validate()){
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => SignUpIdPage(
                          data: widget.data.copyWith(
                            pin: pinController.text,
                            profilePicture: selectedImage == null ? null : 'data:image/png;base64,' + base64Encode(File(selectedImage!.path).readAsBytesSync())
                          ),
                        )
                      )
                    );
                  // Navigator.pushNamed(context, "/register-id");z
                  }else {
                    customSnackbar(context, "Pin harus 6 digit");
                  }

                },)
              ],
            ),
          ),
        ],
      ),
    );
  }
}