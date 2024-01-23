import 'package:bank_sha/blocs/user/user_bloc.dart';
import 'package:bank_sha/models/transfer_form_model.dart';
import 'package:bank_sha/models/user_model.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/pages/transfer_amount_page.dart';
import 'package:bank_sha/ui/widgets/button.dart';
import 'package:bank_sha/ui/widgets/recent_user_item.dart';
import 'package:bank_sha/ui/widgets/text_field.dart';
import 'package:bank_sha/ui/widgets/transfer_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransferPage extends StatefulWidget {
  const TransferPage({super.key});

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  final usernameCOntroller = TextEditingController(text: '');
  UserModel? selectedUser;

  late UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    userBloc = context.read<UserBloc>()..add(UserGetRecentUser());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transfer"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          const SizedBox(
            height: 30,
          ),
          Text(
            "Search",
            style: darkTextStyle.copyWith(fontWeight: semiBold, fontSize: 16),
          ),
          const SizedBox(
            height: 14,
          ),
          CsutomTextField(
            title: "By Username",
            isShowTitle: false,
            controller: usernameCOntroller,
            onFieldSubmitted: (value) {
              if (value.isNotEmpty) {
                userBloc.add(UserGetByUsername(value));
              } else {
                selectedUser = null;
                userBloc.add(UserGetRecentUser());
              }

              setState(() {});
            },
          ),
          usernameCOntroller.text.isEmpty ? buildRecentUser() : builResult(),
          const SizedBox(
            height: 80,
          ),
        ],
      ),
      floatingActionButton: (selectedUser != null)
          ? Container(
              margin: const EdgeInsets.all(24),
              child: CustomFilledButton(
                title: "Continue",
                onPressed: () {
                  // Navigator.pushNamed(context, "/transfer-amount");
                  Navigator.push(context, MaterialPageRoute(builder: 
                    (context) => TransferAmountPage(data: TransferFormModel(
                      sendTo: selectedUser!.username
                    ))
                  ));
                },
              ),
            )
          : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildRecentUser() {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent user",
            style: darkTextStyle.copyWith(fontWeight: semiBold, fontSize: 16),
          ),
          const SizedBox(
            height: 14,
          ),
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is UserSuccess) {
                return Column(
                  children: state.data
                      .map((e) => RecentUserItem(
                            userModel: e,
                            ontap: () {
                              Navigator.push(context, 
                                MaterialPageRoute(builder: 
                                  (context) => TransferAmountPage(data: TransferFormModel(
                                    sendTo: e.username
                                  ))
                                )
                              );
                            },
                          ))
                      .toList(),
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          )
        ],
      ),
    );
  }

  Widget builResult() {
    return Container(
      margin: EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Result",
            style: darkTextStyle.copyWith(fontWeight: semiBold, fontSize: 16),
          ),
          const SizedBox(
            height: 14,
          ),
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is UserSuccess) {
                return Wrap(
                  spacing: 17,
                  runSpacing: 17,
                  children: state.data.map((e) => TransferResult(
                    userModel: e,
                    isSelected: e.id == selectedUser?.id,
                    ontap: () {
                      setState(() {
                        selectedUser = e;
                      });
                    },
                  )).toList(),
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          )
        ],
      ),
    );
  }
}
