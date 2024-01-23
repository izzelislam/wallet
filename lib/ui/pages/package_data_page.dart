import 'package:bank_sha/blocs/auth/auth_bloc.dart';
import 'package:bank_sha/blocs/data_plan/data_plan_bloc.dart';
import 'package:bank_sha/models/data_plan_form_model.dart';
import 'package:bank_sha/models/data_plan_model.dart';
import 'package:bank_sha/models/operator_card_model.dart';
import 'package:bank_sha/shared/method.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/widgets/button.dart';
import 'package:bank_sha/ui/widgets/package_data_card.dart';
import 'package:bank_sha/ui/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PackageDataPage extends StatefulWidget {
  final OperatorCardModel operatorCard;

  const PackageDataPage({super.key, required this.operatorCard});

  @override
  State<PackageDataPage> createState() => _PackageDataPageState();
}

class _PackageDataPageState extends State<PackageDataPage> {
  final phoneController = TextEditingController(text: '');

  DataPlanModel? selectedDataplan;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DataPlanBloc(),
      child: BlocConsumer<DataPlanBloc, DataPlanState>(
        listener: (context, state) {
          if (state is DataPlanSuccess) {
            context
                .read<AuthBloc>()
                .add(AuthUpdateBalance(-1 * selectedDataplan!.price!));
            Navigator.pushNamedAndRemoveUntil(
                context, "/data-success", (route) => false);
          }

          if (state is DataPlanFailed) {
            customSnackbar(context, state.message);
          }
        },
        builder: (context, state) {

          if (state is DataPlanLoading) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()),);
          }

          return Scaffold(
            appBar: AppBar(
              title: Text("Paket Data"),
            ),
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Paket Data",
                  style: darkTextStyle.copyWith(
                      fontWeight: semiBold, fontSize: 16),
                ),
                const SizedBox(
                  height: 14,
                ),
                CsutomTextField(
                  title: "+628",
                  isShowTitle: false,
                  controller: phoneController,
                ),
                buildSelectPackage(),
                const SizedBox(
                  height: 55,
                ),
              ],
            ),
            floatingActionButton:
                (selectedDataplan != null && phoneController.text.isNotEmpty)
                    ? Container(
                        margin: const EdgeInsets.all(24),
                        child: CustomFilledButton(
                          title: "Continue",
                          onPressed: () async {
                            if (await Navigator.pushNamed(context, "/pin") ==
                                true) {
                              final authState = context.read<AuthBloc>().state;
                              String pin = '';

                              if (authState is AuthSuccess) {
                                // get pin from auth state
                                pin = authState.data.pin!;
                              }

                              context.read<DataPlanBloc>().add(PostDataPlant(
                                  DataPlanFormModel(
                                      dataPlanId: selectedDataplan?.id,
                                      phoneNumber: phoneController.text,
                                      pin: pin)));
                            }
                          },
                        ),
                      )
                    : null,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        },
      ),
    );
  }

  Widget buildSelectPackage() {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Package",
            style: darkTextStyle.copyWith(fontWeight: semiBold, fontSize: 16),
          ),
          const SizedBox(
            height: 14,
          ),
          Wrap(
            spacing: 18,
            runSpacing: 18,
            children: widget.operatorCard.dataPlans!
                .map(
                  (e) => PackageDataCard(
                    data: e,
                    isSelected: e.id == selectedDataplan?.id,
                    ontap: () {
                      setState(() {
                        selectedDataplan = e;
                      });
                    },
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
