import 'package:flutter/material.dart';

class DoctorsLoading extends StatelessWidget {
  const DoctorsLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (context, constraints) {

        return Wrap(
          spacing: 24,
          runSpacing: 24,

          children: List.generate(
            6,
            (index) {

              return SizedBox(
                width: 360,
                child: Container(
                  height: 300,

                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .surfaceContainerHighest,

                    borderRadius:
                        BorderRadius.circular(24),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}