import 'package:bank_sha/shared/theme.dart';
import 'package:flutter/material.dart';

class CsutomTextField extends StatelessWidget {

  final String title;
  final bool obsecure;
  final TextEditingController? controller;
  final bool isShowTitle;
  final TextInputType? keyboardType;
  final Function(String)? onFieldSubmitted;

  const CsutomTextField({
    super.key,
    required this.title,
    this.obsecure = false,
    this.controller,
    this.isShowTitle = true,
    this.keyboardType,
    this.onFieldSubmitted
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isShowTitle)
        Text(title, style: darkTextStyle.copyWith(
          fontWeight: medium
        ),) ,
        if (isShowTitle) const SizedBox(height: 8,),
        TextFormField(
          obscureText: obsecure,
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
            contentPadding: const EdgeInsets.all(12),
            hintText: isShowTitle ? '' : title
          ),
          onFieldSubmitted: onFieldSubmitted,
        )
      ],
    );
  }
}