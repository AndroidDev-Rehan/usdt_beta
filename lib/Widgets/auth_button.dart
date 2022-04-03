import 'package:flutter/material.dart';
import 'package:usdt_beta/Widgets/progress.dart';
import 'package:usdt_beta/sizeConfig.dart';
import 'package:usdt_beta/style/color.dart';

class AuthButton extends StatelessWidget {
  final Function onTap;
  final String label;
  final bool isLoading;

  AuthButton({
    this.onTap,
    this.label,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55.0,
        width: SizeConfig.screenWidth * 0.90,
        decoration: BoxDecoration(
            //gradient: btnGrad,
            color: bgColorLight,
            borderRadius: BorderRadius.circular(8.0)),
        child: Center(
          child: isLoading == false || isLoading == null
              ? Text(label,
                  style: TextStyle(
                      color: authBtnTxtClr,
                      fontSize: 18,
                      fontWeight: FontWeight.w600))
              : circularProgress(),
        ),
      ),
    );
  }
}
