import 'package:bank_sha/models/operator_card_model.dart';
import 'package:bank_sha/models/payment_method_model.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {

  final String title;
  final double width;
  final double height;
  final VoidCallback? onPressed;

  const CustomFilledButton({
    super.key,
    required this.title,
    this.width  = double.infinity,
    this.height = 50,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        onPressed: onPressed, 
        style: TextButton.styleFrom(
          backgroundColor: purpleColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(56))
        ),
        child: Text(title ,style: whiteTextStyle.copyWith(
          fontSize: 16,
          fontWeight: semiBold
        ),)
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final VoidCallback? onPressed;

  const CustomTextButton({
    super.key,
    required this.title,
    this.width  = double.infinity,
    this.height = 24,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        onPressed: onPressed, 
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero
        ),
        child: Text(title, style: grayTextStyle.copyWith(
          fontSize: 16,
        ),)
      ),
    );
  }
}

class PinButton extends StatelessWidget {
  final String label;
  final VoidCallback onPress;

  const PinButton({
    super.key,
    required this.label,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: numberBG
        ),
        child: Center(
          child: Text(label, style: whiteTextStyle.copyWith(
            fontSize: 22,
            fontWeight: semiBold
          ),),
        ),
      ),
    );
  }
}

class BankButton extends StatelessWidget {
  final OperatorCardModel data;

  final bool isSelected;
  final VoidCallback? onTap;

  const BankButton({
    super.key,
    required this.data,

    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(22),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: whiteColor,
          border: Border.all(color: isSelected ? blueColor : lightBG, width: 2)
        ),
        child: Row(
          children: [
            // Container(
            //   width: 96,
            //   height: 30,
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage(imgUrl),
            //       fit: BoxFit.cover
            //     ),
            //   ),
            // ),
            Image.network(data.thumbnail!, width: 96,),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(data.name.toString(), style: darkTextStyle.copyWith(
                  fontWeight: medium,
                  fontSize: 16
                ),),
                SizedBox(height: 2,),
                Text(data.status.toString(), style: grayTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: regular
                ),)
              ],
            )
          ],
        ),
      ),
    );
  }
}

class BankItemButton extends StatelessWidget {
  final PaymentMethodModel data;

  final String subtitle;
  final bool isSelected;
  final VoidCallback? onTap;

  const BankItemButton({
    super.key,
    required this.data,
    this.subtitle = "50 Min",
    
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(22),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: whiteColor,
          border: Border.all(color: isSelected ? blueColor : lightBG, width: 2)
        ),
        child: Row(
          children: [
            // Container(
            //   width: 96,
            //   height: 30,
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage(imgUrl),
            //       fit: BoxFit.cover
            //     ),
            //   ),
            // ),
            Image.network(data.thumbnail.toString(), width: 96,),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(data.name.toString(), style: darkTextStyle.copyWith(
                  fontWeight: medium,
                  fontSize: 16
                ),),
                SizedBox(height: 2,),
                Text(subtitle, style: grayTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: regular
                ),)
              ],
            )
          ],
        ),
      ),
    );
  }
}