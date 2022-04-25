import 'package:flutter/material.dart';

class CardInfo extends StatelessWidget {
  final String country;
  final dynamic probabilty;

  CardInfo({
    required this.country,
    required this.probabilty,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:  const EdgeInsets.all(15),
        margin:  const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        width: MediaQuery.of(context).size.width,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              offset: const Offset(
                0.0,
                10.0,
              ),
              blurRadius: 10.0,
              spreadRadius: -6.0,
            ),
          ],
        ),
        child: Row(
          children: [
            Text(
              country,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Container(
               margin: const EdgeInsets.only(left: 140.0),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.6),
                    offset: const Offset(
                      0.0,
                      10.0,
                    ),
                    blurRadius: 10.0,
                    spreadRadius: -2.0,
                  ),
                ],
              ),
              child: Text(
                (double.parse(probabilty) * 100).toStringAsFixed(2).toString() + 
                    "%",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ));
  }
}
