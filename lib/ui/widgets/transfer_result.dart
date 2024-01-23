import 'package:bank_sha/models/user_model.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:flutter/material.dart';

class TransferResult extends StatelessWidget {

  final UserModel userModel;
  final bool isSelected;
  final VoidCallback? ontap;

  const TransferResult({
    super.key,
    required this.userModel,
    this.isSelected = false,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: 155,
        height: 185,
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 22),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? Border.all(
            width: 2,
            color: blueColor
          ) : null
        ),
        child: Column(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: userModel.profilePicture == null
                 ? const AssetImage('assets/img_profile.png')
                 : NetworkImage(userModel.profilePicture!) as ImageProvider
                )
              ),
              child: userModel.verivied  == 1 ? Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: whiteColor
                  ),
                  child: Center(child: Icon(Icons.check_circle, color: greenColor, size: 14,)),
                ),
              ) : null,
            ),
            const SizedBox(height: 13,),
            Text(userModel.name.toString(), style: darkTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,overflow: TextOverflow.ellipsis
            ),),
            const SizedBox(height: 2,),
            Text('@${userModel.username}', style: grayTextStyle.copyWith(
              fontSize: 12,
              fontWeight: regular,
              overflow: TextOverflow.ellipsis
            ),)
          ],
        ),
      ),
    );
  }
}