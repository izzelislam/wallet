import 'package:bank_sha/models/data_plan_model.dart';
import 'package:bank_sha/shared/method.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:flutter/material.dart';

class PackageDataCard extends StatelessWidget {
  final DataPlanModel data;
  
  final bool isSelected;
  final VoidCallback? ontap;

  const PackageDataCard({
    super.key,
    required this.data,
   
    this.ontap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: 155,
        height: 171,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: whiteColor,
          border: isSelected ? Border.all(width: 2, color: blueColor) : null
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(data.name.toString(), style: darkTextStyle.copyWith(
                fontWeight: medium,
                fontSize: 32
              ),),
              const SizedBox(height: 6,),
              Text(formatCurency(data.price!), style: grayTextStyle.copyWith(
                fontSize: 12,
                fontWeight: regular
              ),)
            ],
          ),
        ),
      ),
    );
  }
}