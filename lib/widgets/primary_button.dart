import 'package:flutter/material.dart';
import 'package:todo_app/utils/utils.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({
    Key key,
    @required this.width,
    @required this.text,
    @required this.color,
    @required this.onPressed,
  }) : super(key: key);

  final double width;
  final String text;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: RaisedButton(
        onPressed: onPressed,
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
        ),
        color: color,
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .button
              .copyWith(color: textSecondaryColor),
        ),
      ),
    );
  }
}
