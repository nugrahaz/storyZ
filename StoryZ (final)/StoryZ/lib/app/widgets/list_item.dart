part of 'widgets.dart';

class ListItem extends StatefulWidget {
  final IconData icon;
  final bool isNavigate;
  final String text;
  final Function()? function;

  const ListItem(
      {Key? key,
      this.icon = Icons.error,
      this.text = "",
      this.function,
      this.isNavigate = true})
      : super(key: key);

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.function,
      child: Container(
        margin: EdgeInsets.only(
          bottom: SizeConfig.blockWidth * 5,
        ),
        padding: EdgeInsets.symmetric(
            horizontal: 4.0 * SizeConfig.blockWidth,
            vertical: 4.0 * SizeConfig.blockWidth),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppStyles.colors.white,
        ),
        child: Row(
          children: <Widget>[
            (widget.icon != Icons.minimize_rounded)
                ? Icon(
                    widget.icon,
                    size: 7.0 * SizeConfig.blockWidth,
                    color: AppStyles.colors.bgDark,
                  )
                : const SizedBox(),
            (widget.icon != Icons.minimize_rounded)
                ? SizedBox(width: 4.0 * SizeConfig.blockWidth)
                : const SizedBox(),
            Expanded(
                child: Text(
              widget.text,
              style: AppStyles.textStyles.poppinsMedium.copyWith(
                fontWeight: FontWeight.w900,
                color: AppStyles.colors.bgDark.withOpacity(0.9),
                fontSize: SizeConfig.blockWidth * 3.5,
              ),
            )),
            (widget.isNavigate)
                ? Icon(
                    Icons.chevron_right_sharp,
                    size: SizeConfig.blockWidth * 6,
                  )
                : Padding(
                    padding:
                        EdgeInsets.only(right: 2.0 * SizeConfig.blockWidth),
                    child: Icon(
                      Icons.circle_rounded,
                      size: SizeConfig.blockWidth * 1.5,
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
