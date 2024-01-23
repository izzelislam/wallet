 import 'package:bank_sha/shared/theme.dart';
import 'package:flutter/material.dart';

class ServiceButton extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback? ontap;

  const ServiceButton({
    super.key,
    required this.icon,
    required this.title,
    this.ontap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: whiteColor,
            ),
            child: Center(child: Image.asset(icon, width: 26,)),
          ),
          Text(title, style: darkTextStyle.copyWith(
            fontWeight: medium,
            fontSize: 14
          ),)
        ],
      ),
    );
  }
}