

import 'package:another_flushbar/flushbar.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

void customSnackbar(BuildContext context, String message){
  Flushbar(
    message: message,
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: redCOlor,
    duration: const Duration(seconds: 2),
  ).show(context);
}

String formatCurency(num param, {String symbol = 'Rp '}){
  return NumberFormat.currency(
    locale: 'id',
    symbol: symbol,
    decimalDigits: 0,
  ).format(param);
}

Future <XFile?> selectImage() async {
  final ImagePicker picker = ImagePicker();
  XFile? image = await picker.pickImage(source: ImageSource.gallery);

  return image;
}