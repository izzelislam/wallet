import 'package:bank_sha/blocs/auth/auth_bloc.dart';
import 'package:bank_sha/blocs/payment_method/bloc/paymnet_method_bloc.dart';
import 'package:bank_sha/models/payment_method_model.dart';
import 'package:bank_sha/models/topup_form_model.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/pages/topup_amount_page.dart';
import 'package:bank_sha/ui/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopUpPage extends StatefulWidget {
  const TopUpPage({super.key});

  @override
  State<TopUpPage> createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  PaymentMethodModel? selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Top Up"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildCardAccount(),
            buildSelectBank(context),
          ],
        ),
      ),
      floatingActionButton: (selectedPaymentMethod != null) ? Container(
        margin: const EdgeInsets.all(24),
        child: CustomFilledButton(title: "Continue",
            onPressed: () {
              if(selectedPaymentMethod != null){
                Navigator.push(context, 
                  MaterialPageRoute(builder: (contex) => TopupAmountPage(data: TopUpFormModel(paymentMethodCode: selectedPaymentMethod!.code),))
                );
                // Navigator.pushNamed(context, "/topup-amount");
              }
            },
          ),
      ) : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildCardAccount() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Wallet",
            style: darkTextStyle.copyWith(fontSize: 18, fontWeight: semiBold),
          ),
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthSuccess) {
                return Row(
                  children: [
                    Image.asset(
                      "assets/img_wallet.png",
                      width: 80,
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.data.cardNumber!.replaceAllMapped(
                              RegExp(r".{4}"), (match) => "${match.group(0)} "),
                          style: darkTextStyle.copyWith(
                              fontWeight: medium, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          state.data.username!,
                          style: grayTextStyle.copyWith(
                              fontWeight: regular, fontSize: 12),
                        ),
                      ],
                    )
                  ],
                );
              }
              return Container();
            },
          )
        ],
      ),
    );
  }

  Widget buildSelectBank(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40, bottom: 57),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Bank",
            style: darkTextStyle.copyWith(fontSize: 18, fontWeight: semiBold),
          ),
          const SizedBox(
            height: 16,
          ),
          BlocProvider(
            create: (context) => PaymentMethodBloc()..add(PaymentMethodGet()),
            child: BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
              builder: (context, state) {
                if (state is PaymentMethodLoading){
                  return const Center(child: CircularProgressIndicator(),);
                }
                if (state is PaymentMethodFailed){
                  // print(state.e);
                  return const Center(child: CircularProgressIndicator(),);
                }

                if (state is PaymentMethodSuccess){
                  return Column(
                    children: state.data.map((e) => BankItemButton(
                      data: e, 
                      isSelected: e.id == selectedPaymentMethod?.id ,
                      onTap: (){
                        setState(() {
                          selectedPaymentMethod = e;
                        });
                    })).toList(),
                  );
                }

                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
