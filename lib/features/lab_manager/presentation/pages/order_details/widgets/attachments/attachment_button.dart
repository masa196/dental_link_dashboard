// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';


class AttachmentButton extends StatelessWidget {

  const AttachmentButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.count,
  });


  final String title;

  final IconData icon;

  final VoidCallback onTap;

  final int? count;



  @override
  Widget build(BuildContext context) {

    final scheme = Theme.of(context).colorScheme;


    return InkWell(

      onTap: onTap,

      borderRadius: BorderRadius.circular(14),


      child: Container(

        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),


        decoration: BoxDecoration(

         
          color: scheme.primary.withOpacity(.06),

          borderRadius: BorderRadius.circular(14),

          border: Border.all(
            color: scheme.primary.withOpacity(.15),
          ),

        ),


        child: Row(

          children: [


            Container(

              padding: const EdgeInsets.all(10),

              decoration: BoxDecoration(

                color: scheme.primary.withOpacity(.12),

                shape: BoxShape.circle,

              ),

              child: Icon(
                icon,
                color: scheme.primary,
                size: 22,
              ),

            ),


            const SizedBox(width: 12),



            Expanded(

              child: Text(

                title,

                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),

              ),

            ),



            if(count != null)

              Container(

                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),

                decoration: BoxDecoration(

                  color: scheme.primary,

                  borderRadius:
                  BorderRadius.circular(20),

                ),


                child: Text(

                  count.toString(),

                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),

                ),

              ),



            const SizedBox(width: 8),



            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: scheme.primary,
            ),

          ],

        ),

      ),

    );
  }
}