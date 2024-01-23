import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/widgets/button.dart';
import 'package:flutter/material.dart';

class DataPackageSuccessPage extends StatelessWidget {
  const DataPackageSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Paket Data\nBerhasil Terbeli", style: darkTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 20
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 26,),
            Text("Use the money wisely and\ngrow your finance", style: grayTextStyle.copyWith(
                fontSize: 16
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50,),
            CustomFilledButton(
              title: "Back to Home", width: 183,
              onPressed: (){
                Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
              },
            )
          ],
        ),
      ),
    );
  }
}