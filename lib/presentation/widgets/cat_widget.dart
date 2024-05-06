import 'package:flutter/material.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

import '../../domain/entities/cat.dart';
import '../resources/app_colors.dart';

class CatWidget extends StatelessWidget {
  const CatWidget({
    required this.cat,
    super.key,
  });

  final Cat cat;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.memory(
          cat.image,
          fit: BoxFit.contain,
        ),
        ColoredBox(
          color: neuBlack,
          child: Row(
            children: [
              Expanded(
                child: NeuTextButton(
                  enableAnimation: true,
                  buttonColor: AppColors.orange,
                  text: const Text(
                    'Use this cat!',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              NeuIconButton(
                icon: const Icon(Icons.share_outlined),
                enableAnimation: true,
                buttonColor: AppColors.purple,
              ),
              NeuIconButton(
                icon: const Icon(Icons.download_outlined),
                enableAnimation: true,
                buttonColor: AppColors.purple,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
