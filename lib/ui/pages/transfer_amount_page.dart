import 'package:bank_sha/blocs/auth/auth_bloc.dart';
import 'package:bank_sha/blocs/transfer/transfer_bloc.dart';
import 'package:bank_sha/models/transfer_form_model.dart';
import 'package:bank_sha/shared/method.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransferAmountPage extends StatefulWidget {
  final TransferFormModel data;

  const TransferAmountPage({super.key, required this.data});

  @override
  State<TransferAmountPage> createState() => _TransferAmountPageState();
}

class _TransferAmountPageState extends State<TransferAmountPage> {
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
        create: (context) => TransferBloc(),
        child: BlocConsumer<TransferBloc, TransferState>(
          listener: (context, state) {
            if (state is TransferSuccess){
              context.read<AuthBloc>().add(AuthUpdateBalance(-1 * int.parse(amounController.text.replaceAll(".", ""))));
              Navigator.pushNamedAndRemoveUntil(context, "/transfer-success", (route) => false);
            }

            if (state is TransferFailed){
              customSnackbar(context, state.e);
            }
          },
          builder: (context, state) {

            if (state is AuthLoading){
              return const Center(child: CircularProgressIndicator());
            }

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
                  title: "Continue",
                  onPressed: () async {
                    if (await Navigator.pushNamed(context, "/pin") == true) {
                      final authState = context.read<AuthBloc>().state;
                      String pin = '';

                      if (authState is AuthSuccess) {
                        // get pin from auth state
                        pin = authState.data.pin!;
                      }

                      context.read<TransferBloc>().add(PostTransfer(widget.data
                          .copyWith(
                              pin: pin,
                              amount:
                                  amounController.text.replaceAll('.', ''))));
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
