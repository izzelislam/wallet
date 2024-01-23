import 'package:bank_sha/shared/theme.dart';
import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
  final String imgUrl;
  final String username;

  const UserItem({
    super.key,
    required this.imgUrl,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 120,
      margin: const EdgeInsets.only(right: 18),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 45,
            width: 45,
            margin: EdgeInsets.only(bottom: 13),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: AssetImage(imgUrl), fit: BoxFit.cover)
            ),
          ),
          Text( '@$username', style: darkTextStyle.copyWith(
            fontSize: 12,
            fontWeight: medium
          ),)
        ],
      ),
    );
  }
}