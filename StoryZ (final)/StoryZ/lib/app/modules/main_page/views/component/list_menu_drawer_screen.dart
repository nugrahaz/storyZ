import 'package:flutter/material.dart';
import 'package:storyz/app/constants/constants.dart';
import 'package:storyz/app/utils/utils.dart';

class ListMenuDrawerScreen extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function()? function;

  const ListMenuDrawerScreen({
    Key? key,
    this.icon = Icons.error,
    this.text = "",
    this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        color: AppStyles.colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: AppStyles.colors.white,
              size: 6.75 * SizeConfig.blockWidth,
            ),
            SizedBox(
              width: SizeConfig.blockWidth * 3.5,
            ),
            Text(
              text,
              style: TextStyle(
                  color: AppStyles.colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 4.0 * SizeConfig.blockWidth),
            )
          ],
        ),
      ),
    );
  }
}
