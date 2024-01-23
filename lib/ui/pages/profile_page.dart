import 'package:bank_sha/blocs/auth/auth_bloc.dart';
import 'package:bank_sha/shared/method.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/widgets/button.dart';
import 'package:bank_sha/ui/widgets/button_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed){
            customSnackbar(context, state.e);
          }

          if (state is AuthInitial){
            Navigator.pushNamedAndRemoveUntil(context, "/onboard", (route) => false);
          }
        },
        builder: (context, state) {

          if (state is AuthLoading){
            return const Center(child: CircularProgressIndicator(),);
          }

          if (state is AuthSuccess){
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                const SizedBox(height: 20),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 22),
                  decoration: BoxDecoration(
                      color: whiteColor, borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: state.data.profilePicture == null 
                                ? const AssetImage("assets/img_profile.png")
                                : NetworkImage(state.data.profilePicture!) as ImageProvider
                            )
                        ),
                        child: state.data.verivied == 1  ? Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: whiteColor),
                            child: Center(
                                child: Icon(
                              Icons.check_circle,
                              color: greenColor,
                              size: 24,
                            )),
                          ),
                        ) : null,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        state.data.name!,
                        style: darkTextStyle.copyWith(
                            fontWeight: medium, fontSize: 18),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ButtonProfile(
                        icon: "assets/ic_edit_profile.png",
                        title: "Edit Profile",
                        onpress: () async {
                          if (await Navigator.pushNamed(context, "/pin") ==
                              true) {
                            Navigator.pushNamed(context, "/profile-edit");
                          }
                        },
                      ),
                      ButtonProfile(
                        icon: "assets/ic_pin.png",
                        title: "My Pin",
                        onpress: () async {
                          if (await Navigator.pushNamed(context, "/pin") ==
                              true) {
                            Navigator.pushNamed(context, "/profile-edit-pin");
                          }
                        },
                      ),
                      ButtonProfile(
                        icon: "assets/ic_wallet.png",
                        title: "Wallet Setting",
                        onpress: () {},
                      ),
                      ButtonProfile(
                        icon: "assets/ic_my_reward.png",
                        title: "My Rewards",
                        onpress: () {},
                      ),
                      ButtonProfile(
                        icon: "assets/ic_help_center.png",
                        title: "Help Center",
                        onpress: () {},
                      ),
                      ButtonProfile(
                        icon: "assets/ic_logout.png",
                        title: "Log Out",
                        onpress: () {
                          context.read<AuthBloc>().add(AuthLogout());
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                CustomTextButton(
                  title: "Report a Problem",
                  onPressed: () {},
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
