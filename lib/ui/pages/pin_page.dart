import 'package:bank_sha/blocs/auth/auth_bloc.dart';
import 'package:bank_sha/shared/method.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PinPage extends StatefulWidget {
  const PinPage({super.key});

  @override
  State<PinPage> createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  String pin = '';
  final TextEditingController pinControlle = TextEditingController(text: '');

  addPin(String number){
    if (pinControlle.text.length < 6){
      setState(() {
        pinControlle.text = pinControlle.text + number;
      });
    }

    if (pinControlle.text.length == 6){
      if (pinControlle.text == pin){
        Navigator.pop(context, true);
      }else{
        customSnackbar(context, "PIN yang anda masukkan salah. Silakan coba lagi.");
      }
    }

  }

  deletePin(){
    if (pinControlle.text.isNotEmpty){
      setState(() {
        pinControlle.text = pinControlle.text.substring(0, pinControlle.text.length - 1);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;

    if (authState is AuthSuccess){
      pin = authState.data.pin!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBG,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 58),
          child: Column(
            children: [
              const SizedBox(height: 36,),
              Text("Sha PIN", style: whiteTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 20
              ),),
              const SizedBox(height: 72,),
              SizedBox(
                width: 200,
                child: TextFormField(
                  obscureText: true,
                  controller: pinControlle,
                  obscuringCharacter: "*",
                  cursorColor: grayColor,
                  maxLength: 6,
                  enabled: false,
                  style: whiteTextStyle.copyWith(
                    fontSize: 36,
                    fontWeight: medium,
                    letterSpacing: 16
                  ),
                  decoration: InputDecoration(
                    disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: grayColor)
                    ),
                    // focusedBorder: UnderlineInputBorder(
                    //   borderSide: BorderSide(color: grayColor)
                    // ),
                  ),
                ),
              ),
              const SizedBox(height: 66,),
              Wrap(
                spacing: 40,
                runSpacing: 40,
                children: [
                  PinButton(label: "1", onPress: (){
                    addPin("1");
                  }),
                  PinButton(label: "2", onPress: (){
                      addPin("2");
                  }),
                  PinButton(label: "3", onPress: (){
                      addPin("3");
                  }),
                  PinButton(label: "4", onPress: (){
                     addPin("4");
                  }),
                  PinButton(label: "5", onPress: (){
                     addPin("5");
                  }),
                  PinButton(label: "6", onPress: (){
                     addPin("6");
                  }),
                  PinButton(label: "7", onPress: (){
                     addPin("7");
                  }),
                  PinButton(label: "8", onPress: (){
                     addPin("8");
                  }),
                  PinButton(label: "9", onPress: (){
                     addPin("9");
                  }),
                  const SizedBox(height: 60, width: 60,),
                  PinButton(label: "0", onPress: (){
                     addPin("0");
                  }),
                  GestureDetector(
                    onTap: (){deletePin();},
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: numberBG
                      ),
                      child: Center(
                        child: Icon(Icons.arrow_back, color: whiteColor,size: 24,),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}