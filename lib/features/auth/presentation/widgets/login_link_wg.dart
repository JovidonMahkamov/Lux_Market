import 'package:flutter/material.dart';

class LoginLinkWidget extends StatelessWidget {
  final String? text;
  final String text1;
  void Function()? onTap;
   LoginLinkWidget({super.key, this.text, required this.text1, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 14.5, color: Color(0xFF6B6480)),
          children: [
             TextSpan(text: text),
            WidgetSpan(
              child: GestureDetector(
                onTap: onTap,
                child:  Text(
                  text1,
                  style: TextStyle(
                    fontSize: 14.5,
                    color: Color(0xFF7B52D8),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}