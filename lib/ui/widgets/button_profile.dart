import 'package:bank_sha/shared/theme.dart';
import 'package:flutter/material.dart';

class ButtonProfile extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback? onpress;

  const ButtonProfile({
    super.key,
    required this.icon,
    required this.title,
    this.onpress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: Row(
          children: [
            Image.asset(icon, width: 24,),
            const SizedBox(width: 18),
            Text(title, style: darkTextStyle.copyWith(
              
              fontWeight: medium,
              fontSize: 14
            ),)
          ],
        ),
      ),
    );
  }
}