import 'package:flutter/material.dart';
import 'package:hcs_mobile/utils/theme.dart';

class ButtonWidget extends StatelessWidget {
  final Color color;
  final TextStyle textStyle;
  final Border border;
  final String text;
  final Function() onpressed;
  final EdgeInsets padding;
  const ButtonWidget({Key? key,required this.color,this.border = const Border(),required this.textStyle,required this.text,required this.onpressed, this.padding = const EdgeInsets.symmetric(vertical: 5) }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double shortestside = MediaQuery.of(context).size.shortestSide;
    final bool phonelayout = shortestside < 600;
    return InkWell(
      onTap: onpressed,
      child: Container(
        padding: padding,
        height: phonelayout == true ? 40 : 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: color,border: border),
        child: Center(
          child: Text(
            '${text}',
            style: textStyle
          ),
        ),
      ),
    );
  }
}
