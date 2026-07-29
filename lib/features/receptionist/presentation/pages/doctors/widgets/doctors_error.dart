import 'package:flutter/material.dart';

class DoctorsError extends StatelessWidget {

  const DoctorsError({
    super.key,
    required this.failure,
  });

  final Object failure;


  @override
  Widget build(BuildContext context) {

    final scheme =
        Theme.of(context).colorScheme;


    return Container(

      width: double.infinity,

      padding:
          const EdgeInsets.all(32),

      decoration: BoxDecoration(

        color: scheme.errorContainer,

        borderRadius:
            BorderRadius.circular(24),

      ),

      child: Column(

        mainAxisSize:
            MainAxisSize.min,

        children: [

          Icon(
            Icons.error_outline,
            size: 48,
            color: scheme.error,
          ),


          const SizedBox(height: 16),


          Text(
            "حدث خطأ أثناء تحميل الأطباء",

            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(
                  fontWeight:
                      FontWeight.bold,
                ),
          ),


          const SizedBox(height: 8),


          Text(
            failure.toString(),
            textAlign:
                TextAlign.center,
          ),


          const SizedBox(height: 20),


          FilledButton.icon(

            onPressed: () {
              // retry سيتم ربطه لاحقاً
            },

            icon:
                const Icon(Icons.refresh),

            label:
                const Text("إعادة المحاولة"),

          ),
        ],
      ),
    );
  }
}