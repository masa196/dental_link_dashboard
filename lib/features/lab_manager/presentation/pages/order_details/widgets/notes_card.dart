// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class NotesCard extends StatelessWidget {
  const NotesCard({
    super.key,
    required this.notes,
  });

  final String? notes;


  @override
  Widget build(BuildContext context) {

    final scheme = Theme.of(context).colorScheme;


    return Card(
      elevation: 0,
      color: scheme.surface,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),

        side: BorderSide(
          color: scheme.outline,
        ),
      ),


      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Row(
              children: [

                Icon(
                  Icons.notes_outlined,
                  color: scheme.primary,
                ),


                const SizedBox(width: 8),


                Text(
                  "الملاحظات",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),

              ],
            ),


            const SizedBox(height: 16),


            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(

                color: scheme.primary.withOpacity(.05),

                borderRadius:
                    BorderRadius.circular(12),

              ),


              child: Text(

                notes == null || notes!.trim().isEmpty
                    ? "لا توجد ملاحظات"
                    : notes!,

                style: TextStyle(
                  color: notes == null ||
                          notes!.trim().isEmpty
                      ? scheme.onSurfaceVariant
                      : scheme.onSurface,
                  height: 1.6,
                ),

              ),
            ),

          ],
        ),
      ),
    );
  }
}