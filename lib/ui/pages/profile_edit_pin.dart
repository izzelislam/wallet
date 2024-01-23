import 'package:bank_sha/blocs/auth/auth_bloc.dart';
import 'package:bank_sha/shared/method.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/widgets/button.dart';
import 'package:bank_sha/ui/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileEditPinPage extends StatefulWidget {
  const ProfileEditPinPage({super.key});

  @override
  State<ProfileEditPinPage> createState() => _ProfileEditPinPageState();
}

class _ProfileEditPinPageState extends State<ProfileEditPinPage> {
  final oldController = TextEditingController(text: '');
  final newController = TextEditingController(text: '');

  bool validated(){
    if (oldController.text.isEmpty || newController.text.isEmpty){
      return false;
    }
    return  true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Pin"),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed){
            customSnackbar(context, state.e);
          }

          if (state is AuthSuccess){
            Navigator.pushNamed(context, "/profile-edit-success");
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
                child:Column(
                  children: [
                    CsutomTextField(title: "Old PIN", controller:  oldController, obsecure: true,),
                    const SizedBox(
                      height: 16,
                    ),
                    CsutomTextField(title: "New PIN", controller: newController, obsecure: true,),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomFilledButton(title: "Update Now", onPressed: (){
                      if (validated()){
                        context.read<AuthBloc>().add(AuthUpdatePin(oldController.text, newController.text));
                      }else{
                        customSnackbar(context, "Data harus terisi semua");
                      }
                    },)
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
