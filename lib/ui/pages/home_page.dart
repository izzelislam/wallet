import 'package:bank_sha/blocs/auth/auth_bloc.dart';
import 'package:bank_sha/blocs/tips/tips_bloc.dart';
import 'package:bank_sha/shared/method.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/widgets/latest_item_card.dart';
import 'package:bank_sha/ui/widgets/service_button.dart';
import 'package:bank_sha/ui/widgets/tips_card.dart';
import 'package:bank_sha/ui/widgets/user_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          buildProfile(context),
          buildWalletCard(),
          buildLevel(),
          buildService(context),
          buildLatestTransaction(),
          buildSendAgain(),
          buildTip(),
          const SizedBox(
            height: 50,
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: lightBG,
        shape: const CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        notchMargin: 6,
        elevation: 0,
        child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            backgroundColor: whiteColor,
            selectedItemColor: blueColor,
            unselectedItemColor: blackColor,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedLabelStyle:
                blueTextStyle.copyWith(fontSize: 10, fontWeight: medium),
            unselectedLabelStyle:
                darkTextStyle.copyWith(fontWeight: medium, fontSize: 10),
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/ic_overview.png",
                    width: 20,
                    color: blueColor,
                  ),
                  label: "Overview"),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/ic_history.png",
                    width: 20,
                  ),
                  label: "History"),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/ic_statistic.png",
                    width: 20,
                  ),
                  label: "Statistic"),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/ic_reward.png",
                    width: 20,
                  ),
                  label: "Reward"),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: purpleColor,
        child: Image.asset(
          "assets/ic_plus_circle.png",
          width: 24,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildProfile(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/profile");
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            return Container(
              margin: const EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(state.data.username!,
                          style: grayTextStyle.copyWith(fontSize: 16)),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(state.data.username!,
                          style: darkTextStyle.copyWith(
                              fontSize: 20, fontWeight: semiBold)),
                    ],
                  ),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: state.data.profilePicture == null
                                ? const AssetImage("assets/img_profile.png")
                                : NetworkImage(state.data.profilePicture!)
                                    as ImageProvider)),
                    child: state.data.verivied == 1
                        ? Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: whiteColor),
                              child: Center(
                                  child: Icon(
                                Icons.check_circle,
                                color: greenColor,
                                size: 14,
                              )),
                            ),
                          )
                        : null,
                  )
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget buildWalletCard() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          return Container(
            width: double.infinity,
            height: 220,
            margin: const EdgeInsets.only(top: 30),
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                image: const DecorationImage(
                    image: AssetImage("assets/img_bg_card.png"),
                    fit: BoxFit.cover)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.data.username!,
                  style:
                      whiteTextStyle.copyWith(fontSize: 18, fontWeight: medium),
                ),
                const SizedBox(
                  height: 28,
                ),
                Text(
                    "**** **** **** ${state.data.cardNumber!.substring(12, 16)} ",
                    style: whiteTextStyle.copyWith(
                        fontSize: 18, fontWeight: medium, letterSpacing: 6)),
                const SizedBox(
                  height: 21,
                ),
                Text("Balance",
                    style: whiteTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: medium,
                    )),
                Text(formatCurency(state.data.balance ?? 0),
                    style: whiteTextStyle.copyWith(
                      fontSize: 24,
                      fontWeight: semiBold,
                    )),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget buildLevel() {
    return Container(
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
            color: whiteColor, borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Level 1",
                  style:
                      darkTextStyle.copyWith(fontWeight: medium, fontSize: 14),
                ),
                Spacer(),
                Text(
                  "55%",
                  style:
                      greenTextStyle.copyWith(fontWeight: bold, fontSize: 14),
                ),
                Text(
                  "of Rp.20.000",
                  style:
                      darkTextStyle.copyWith(fontWeight: medium, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(55),
              child: LinearProgressIndicator(
                value: 0.55,
                valueColor: AlwaysStoppedAnimation(greenColor),
                backgroundColor: lightBG,
                minHeight: 5,
              ),
            )
          ],
        ));
  }

  Widget buildService(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Do Something",
            style: darkTextStyle.copyWith(fontWeight: semiBold, fontSize: 16),
          ),
          const SizedBox(
            height: 14,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ServiceButton(
                icon: "assets/ic_topup.png",
                title: "Top Up",
                ontap: () {
                  Navigator.pushNamed(context, "/topup");
                },
              ),
              ServiceButton(
                icon: "assets/ic_send.png",
                title: "Send",
                ontap: () {
                  Navigator.pushNamed(context, "/transfer");
                },
              ),
              ServiceButton(
                icon: "assets/ic_withdraw.png",
                title: "Withdraw",
                ontap: () {},
              ),
              ServiceButton(
                icon: "assets/ic_more.png",
                title: "More",
                ontap: () {
                  showDialog(
                      context: context, builder: (context) => MoreDialog());
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildLatestTransaction() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Latest Transactions",
            style: darkTextStyle.copyWith(fontWeight: semiBold, fontSize: 16),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: whiteColor),
            child: Column(
              children: [
                LatestItemCard(
                    iconUrl: "assets/ic_transaction_category1.png",
                    title: "Top Up",
                    time: "yesterday",
                    amount: "+ 450.000"),
                LatestItemCard(
                    iconUrl: "assets/ic_transaction_category2.png",
                    title: "Cashback",
                    time: "Sep 11",
                    amount: "+ 22.000"),
                LatestItemCard(
                    iconUrl: "assets/ic_transaction_category3.png",
                    title: "Withdraw",
                    time: "Sep 2",
                    amount: "- 5.000"),
                LatestItemCard(
                    iconUrl: "assets/ic_transaction_category4.png",
                    title: "Transfer",
                    time: "Aug 2",
                    amount: "- 123.500"),
                LatestItemCard(
                    iconUrl: "assets/ic_transaction_category5.png",
                    title: "Electric",
                    time: "Aug 2",
                    amount: "- 123.500"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildSendAgain() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Friendly Tips",
            style: darkTextStyle.copyWith(fontWeight: semiBold, fontSize: 16),
          ),
          const SizedBox(
            height: 14,
          ),
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                UserItem(imgUrl: "assets/img_friend1.png", username: "yuanita"),
                UserItem(imgUrl: "assets/img_friend2.png", username: "jani"),
                UserItem(imgUrl: "assets/img_friend3.png", username: "urip"),
                UserItem(imgUrl: "assets/img_friend4.png", username: "masa"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildTip() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Send Again",
            style: darkTextStyle.copyWith(fontWeight: semiBold, fontSize: 16),
          ),
          const SizedBox(
            height: 14,
          ),
          BlocProvider(
            create: (context) => TipsBloc()..add(GetTipsEvent()),
            child: BlocBuilder<TipsBloc, TipsState>(
              builder: (context, state) {

                if (state is TipsLoading){
                  return const Center(child: CircularProgressIndicator(),);
                }

                if (state is TipsSuccess){
                  return Wrap(
                    spacing: 17,
                    runSpacing: 18,
                    children: state.data.map((e) => TipsCard(data: e,)).toList(),
                  );
                }

                if (state is TipsFailed){
                  print(state.e);
                  return const Center(child: CircularProgressIndicator(),);
                }

                return Container();
              },
            ),
          )
        ],
      ),
    );
  }
}

class MoreDialog extends StatelessWidget {
  const MoreDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      alignment: Alignment.bottomCenter,
      content: Container(
        width: MediaQuery.of(context).size.width,
        height: 326,
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40), color: lightBG),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Do More With Us",
              style: darkTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
            ),
            const SizedBox(
              height: 13,
            ),
            Wrap(
              spacing: 29,
              runSpacing: 29,
              children: [
                ServiceButton(
                  icon: "assets/ic_produc_data.png",
                  title: "Data",
                  ontap: () {
                    Navigator.pushNamed(context, "/data-provoder");
                  },
                ),
                ServiceButton(
                  icon: "assets/ic_produc_water.png",
                  title: "Water",
                  ontap: () {},
                ),
                ServiceButton(
                  icon: "assets/ic_produc_stream.png",
                  title: "Steream",
                  ontap: () {},
                ),
                ServiceButton(
                  icon: "assets/ic_produc_movie.png",
                  title: "Movie",
                  ontap: () {},
                ),
                ServiceButton(
                  icon: "assets/ic_produc_food.png",
                  title: "Food",
                  ontap: () {},
                ),
                ServiceButton(
                  icon: "assets/ic_produc_travel.png",
                  title: "Travel",
                  ontap: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
