import 'package:flutter/material.dart';
import 'package:storyz/app/constants/constants.dart';
import 'package:storyz/app/utils/utils.dart';

class ListLanguage extends StatefulWidget {
  final String assetPath;
  final String title;
  final Color borderColor;
  final Function() function;

  const ListLanguage({
    Key? key,
    required this.assetPath,
    required this.title,
    required this.borderColor,
    required this.function,
  }) : super(key: key);

  @override
  State<ListLanguage> createState() => _ListLanguageState();
}

class _ListLanguageState extends State<ListLanguage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.function();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: SizeConfig.blockWidth * 6),
        decoration: BoxDecoration(
            border: Border.all(
                width: 0.5 * SizeConfig.blockWidth, color: widget.borderColor),
            borderRadius:
                BorderRadius.all(Radius.circular(4.0 * SizeConfig.blockWidth))),
        height: 20.0 * SizeConfig.blockWidth,
        child: Row(
          children: [
            Flexible(
              flex: 4,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: SizeConfig.blockWidth * 5,
                        bottom: SizeConfig.blockWidth * 5,
                        left: 4.0 * SizeConfig.blockWidth,
                        right: SizeConfig.blockWidth * 5),
                    decoration: BoxDecoration(
                        color: AppStyles.colors.white.withOpacity(0.2),
                        shape: BoxShape.circle),
                    child: Padding(
                        padding: EdgeInsets.all(0.25 * SizeConfig.blockWidth),
                        child: widget.assetPath == ""
                            ? Icon(
                                Icons.language_rounded,
                                color: AppStyles.colors.white,
                              )
                            : Image.asset(widget.assetPath)),
                  ),
                  Text(
                    widget.title,
                    style: AppStyles.textStyles.poppinsSemiBold.copyWith(
                        color: AppStyles.colors.white,
                        fontSize: 4.5 * SizeConfig.blockWidth),
                  ),
                ],
              ),
            ),
            Flexible(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      color: (widget.borderColor != AppStyles.colors.white)
                          ? widget.borderColor.withOpacity(0.95)
                          : AppStyles.colors.transparent,
                      shape: BoxShape.circle),
                  height: 4.0 * SizeConfig.blockWidth,
                ))
          ],
        ),
      ),
    );
  }
}
