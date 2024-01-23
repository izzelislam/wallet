import 'package:bank_sha/blocs/auth/auth_bloc.dart';
import 'package:bank_sha/blocs/operator_card/operator_card_bloc.dart';
import 'package:bank_sha/models/operator_card_model.dart';
import 'package:bank_sha/shared/method.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/pages/package_data_page.dart';
import 'package:bank_sha/ui/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataProviderPage extends StatefulWidget {
  const DataProviderPage({super.key});

  @override
  State<DataProviderPage> createState() => _DataProviderPageState();
}

class _DataProviderPageState extends State<DataProviderPage> {
  
  OperatorCardModel? operatorSelected;

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Beli Data"),
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
      floatingActionButton: (operatorSelected != null) ? Container(
        margin: const EdgeInsets.all(24),
        child: CustomFilledButton(
            title: "Continue",
            onPressed: () {
              Navigator.push(context, 
                MaterialPageRoute(builder: 
                  (context) => PackageDataPage(operatorCard: operatorSelected!)
                )
              );
            },
          ),
      ) : null  ,
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
            "From Wallet",
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
                          "Balance: ${formatCurency(state.data.balance ?? 0)}",
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
            "Select Provider",
            style: darkTextStyle.copyWith(fontSize: 18, fontWeight: semiBold),
          ),
          const SizedBox(
            height: 16,
          ),
          BlocProvider(
            create: (context) => OperatorCardBloc()..add(GetOperatorCard()),
            child: BlocBuilder<OperatorCardBloc, OperatorCardState>(
              builder: (context, state) {

                if (state is OperatorCardLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is OperatorCardSuccess) {
                  return Column(
                    children: state.data.map((e) => BankButton(
                      data: e,
                      onTap: () {
                        setState(() {
                          operatorSelected = e;
                        });
                      },
                      isSelected: operatorSelected?.id == e.id
                    )).toList()
                  );
                }

                return Container();

              },
            ),
          ),
          const SizedBox(
            height: 14,
          ),
            
        ],
      ),
    );
  }
}
