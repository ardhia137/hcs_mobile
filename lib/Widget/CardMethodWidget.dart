import 'package:flutter/material.dart';
import 'package:hcs_mobile/utils/theme.dart';

class CardMetdhodWidget extends StatelessWidget {
  final Function() onpressed;
  final String email;
  const CardMetdhodWidget({Key? key,required this.onpressed, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 7,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon_email.png',
              width: 47,
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'E-mail ke',
                    style: blackTextstyle.copyWith(
                        fontWeight: semibold, fontSize: 15),
                  ),
                  Text(
                    '${email}',
                    style:
                        blackTextstyle.copyWith(fontWeight: light, fontSize: 15),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
