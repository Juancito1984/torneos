import 'package:flutter/material.dart';
import 'package:torneos/utils/util_images.dart';

class NoData extends StatelessWidget {
  final String title;

  const NoData(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              UrlImages().noData,
              width: 150,
              height: 150,
            ),
            Text(
              title.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ));
  }
}
