import 'package:bank_sha/blocs/auth/auth_bloc.dart';
import 'package:bank_sha/blocs/user/user_bloc.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/pages/data_package_success_page.dart';
import 'package:bank_sha/ui/pages/data_provider_page.dart';
import 'package:bank_sha/ui/pages/home_page.dart';
import 'package:bank_sha/ui/pages/onboarding_page.dart';
import 'package:bank_sha/ui/pages/pin_page.dart';
import 'package:bank_sha/ui/pages/profile_edit_page.dart';
import 'package:bank_sha/ui/pages/profile_edit_pin.dart';
import 'package:bank_sha/ui/pages/profile_edit_success.dart';
import 'package:bank_sha/ui/pages/profile_page.dart';
import 'package:bank_sha/ui/pages/sig_up_success_page.dart';
import 'package:bank_sha/ui/pages/sign_in_page.dart';
import 'package:bank_sha/ui/pages/sign_up_page.dart';
import 'package:bank_sha/ui/pages/splash_page.dart';
// import 'package:bank_sha/ui/pages/topup_amount_page.dart';
import 'package:bank_sha/ui/pages/topup_page.dart';
import 'package:bank_sha/ui/pages/topup_success_page.dart';
// import 'package:bank_sha/ui/pages/transfer_amount_page.dart';
import 'package:bank_sha/ui/pages/transfer_page.dart';
import 'package:bank_sha/ui/pages/transfer_success_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()..add(AuthgetCurrentUser())),
        BlocProvider(create: (context) => UserBloc()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: lightBG,
          appBarTheme: AppBarTheme(
            // leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.chevron_left, color: blackColor, size: 28)),
            backgroundColor: lightBG,
            elevation: 0,
            centerTitle: true,
            iconTheme: IconThemeData(
              color: blackColor
            ),
            titleTextStyle:  darkTextStyle.copyWith(
              fontSize: 20,
              fontWeight: semiBold
            )
          )
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          "/"         : (context) => SplashPage(),
          "/onboard"  : (context) => OnBoardingPage(),
          "/login"    : (context) => SignInPage(),
          "/register"    : (context) => SignUpPage(),
          "/register-success"    : (context) => SignUpSuccessPage(),
          "/home"    : (context) => HomePage(),
          "/profile"    : (context) => ProfilePage(),
          "/pin"    : (context) => PinPage(),
          "/profile-edit"    : (context) => ProfileEditPage(),
          "/profile-edit-pin"    : (context) => ProfileEditPinPage(),
          "/profile-edit-success"    : (context) => ProfileEditSuccessPage(),
          "/topup"    : (context) => TopUpPage(),
          // "/topup-amount"    : (context) => TopupAmountPage(data: tes,),
          "/topup-success"    : (context) => TopupSuccessPage(),
          "/transfer"    : (context) => TransferPage(),
          // "/transfer-amount"    : (context) => TransferAmountPage(),
          "/transfer-success"    : (context) => TransferSuccessPage(),
          "/data-provoder"    : (context) => DataProviderPage(),
          "/data-success"    : (context) => DataPackageSuccessPage(),
        },
      ),
    );
  }
}