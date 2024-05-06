import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

class CatLoader extends StatelessWidget {
  const CatLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SpinKitWave(
        itemBuilder: (context, index) {
          final color = switch (index % 5) {
            0 => const Color(0xFFED320E),
            1 => const Color(0xFFB33387),
            2 => const Color(0xFFFFC901),
            3 => const Color(0xFFBAFDA2),
            _ => const Color(0xFFFE91E8),
          };

          return DecoratedBox(
            decoration: BoxDecoration(
              color: color,
              boxShadow: const [
                BoxShadow(
                  blurStyle: neuBlurStyle,
                  color: neuShadow,
                  offset: neuOffset,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
