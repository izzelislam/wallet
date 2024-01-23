import 'package:bank_sha/blocs/auth/auth_bloc.dart';
import 'package:bank_sha/blocs/topup/topup_bloc.dart';
import 'package:bank_sha/models/topup_form_model.dart';
import 'package:bank_sha/shared/method.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class TopupAmountPage extends StatefulWidget {
  final TopUpFormModel data;
  const TopupAmountPage({super.key, required this.data});

  @override
  State<TopupAmountPage> createState() => _TopupAmountPageState();
}

class _TopupAmountPageState extends State<TopupAmountPage> {
  final TextEditingController amounController =
      TextEditingController(text: '0');

  addAmount(String number) {
    if (amounController.text == '0') {
      amounController.text = "";
    }
    setState(() {
      amounController.text = amounController.text + number;
    });
  }

  deleteAmount() {
    if (amounController.text.isNotEmpty) {
      setState(() {
        amounController.text =
            amounController.text.substring(0, amounController.text.length - 1);
        if (amounController.text == '') {
          amounController.text = "0";
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();

    amounController.addListener(() {
      final text = amounController.text;
      amounController.value = amounController.value.copyWith(
          text:
              NumberFormat.currency(locale: 'id', decimalDigits: 0, symbol: '')
                  .format(int.parse(text.replaceAll('.', ''))));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBG,
      body: BlocProvider(
        create: (context) => TopupBloc(),
        child: BlocConsumer<TopupBloc, TopupState>(
          listener: (context, state) async {

            if (state is TopupFailed){
              customSnackbar(context, state.e);
            }

            if (state is TopupSuccess){
              await launchUrl(Uri.parse(state.url));
              context.read<AuthBloc>().add(AuthUpdateBalance(int.parse(amounController.text.replaceAll(".", ""))));
              Navigator.pushNamedAndRemoveUntil(
                  context, "/topup-success", (route) => false);
            }

          },
          builder: (context, state) {
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "Total Amount",
                    style: whiteTextStyle.copyWith(
                        fontWeight: semiBold, fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 67,
                ),
                Align(
                  child: SizedBox(
                    width: 200,
                    child: TextFormField(
                      controller: amounController,
                      cursorColor: grayColor,
                      maxLength: 6,
                      enabled: false,
                      style: whiteTextStyle.copyWith(
                        fontSize: 30,
                        fontWeight: medium,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Text(
                          "Rp",
                          style: whiteTextStyle.copyWith(
                              fontWeight: medium, fontSize: 30),
                        ),
                        disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: grayColor)),
                        // focusedBorder: UnderlineInputBorder(
                        //   borderSide: BorderSide(color: grayColor)
                        // ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 66,
                ),
                Wrap(
                  spacing: 40,
                  runSpacing: 40,
                  children: [
                    PinButton(
                        label: "1",
                        onPress: () {
                          addAmount("1");
                        }),
                    PinButton(
                        label: "2",
                        onPress: () {
                          addAmount("2");
                        }),
                    PinButton(
                        label: "3",
                        onPress: () {
                          addAmount("3");
                        }),
                    PinButton(
                        label: "4",
                        onPress: () {
                          addAmount("4");
                        }),
                    PinButton(
                        label: "5",
                        onPress: () {
                          addAmount("5");
                        }),
                    PinButton(
                        label: "6",
                        onPress: () {
                          addAmount("6");
                        }),
                    PinButton(
                        label: "7",
                        onPress: () {
                          addAmount("7");
                        }),
                    PinButton(
                        label: "8",
                        onPress: () {
                          addAmount("8");
                        }),
                    PinButton(
                        label: "9",
                        onPress: () {
                          addAmount("9");
                        }),
                    const SizedBox(
                      height: 60,
                      width: 60,
                    ),
                    PinButton(
                        label: "0",
                        onPress: () {
                          addAmount("0");
                        }),
                    GestureDetector(
                      onTap: () {
                        deleteAmount();
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: numberBG),
                        child: Center(
                          child: Icon(
                            Icons.arrow_back,
                            color: whiteColor,
                            size: 24,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomFilledButton(
                  title: "Checkout Now",
                  onPressed: () async {
                    if (await Navigator.pushNamed(context, "/pin") == true) {
                      final authState = context.read<AuthBloc>().state;
                      String pin = '';

                      if (authState is AuthSuccess){
                        // get pin from auth state
                        pin = authState.data.pin!;
                      }

                      context.read<TopupBloc>().add(TopUpPost(
                        widget.data.copyWith(
                          pin: pin,
                          amount: amounController.text.replaceAll('.', '')
                        )
                      ));
                    }
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomTextButton(
                  title: "Terms & Conditions",
                  onPressed: () {},
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
