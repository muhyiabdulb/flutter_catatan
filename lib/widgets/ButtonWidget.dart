import 'package:flutter/material.dart';
import 'package:flutter_catatan/theme.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.textButton,
    required this.onTap,
    required this.backgroundColor,
    this.isFull = false,
    // this.isSmall = false,
  });
  final String textButton;
  final Function() onTap;
  final Color backgroundColor;
  final bool isFull;
  // final bool isSmall;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: (isFull) ? double.infinity : null,
      // padding: EdgeInsets.symmetric(
      //     vertical: (isSmall) ? paddingS : paddingL,
      //     horizontal: (isSmall) ? paddingL : paddingXL),
      margin: const EdgeInsets.only(top: 30),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          textButton,
          style: whiteTextStyle.copyWith(
            fontWeight: medium,
          ),
        ),
      ),
    );
  }
}
