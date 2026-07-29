import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:flutter/material.dart';

class DoctorsStatisticsCard extends StatelessWidget {

  const DoctorsStatisticsCard({
    super.key,
    required this.title,
    required this.value,
    required this.valueColor,
    this.suffix,
  });


  final String title;
  final String value;
  final Color valueColor;
  final String? suffix;


  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;


    return Container(

      padding: const EdgeInsets.all(
        AppSpacing.lg,
      ),

      decoration: BoxDecoration(

        color: colors.surface,

        borderRadius: BorderRadius.circular(20),

        border: Border.all(
          color: colors.primary.withValues(
            alpha: 0.8,
          ),
          width: 1.2,
        ),

      ),


      child: Column(

        mainAxisAlignment:
            MainAxisAlignment.center,

        crossAxisAlignment:
            CrossAxisAlignment.start,


        children: [


          Text(

            title,

            maxLines: 1,

            overflow:
                TextOverflow.ellipsis,

            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(

                  color:
                      colors.onSurfaceVariant,

                  fontWeight:
                      FontWeight.w700,
                ),
          ),


          const SizedBox(
            height: 12,
          ),



          Row(

            mainAxisSize:
                MainAxisSize.min,

            crossAxisAlignment:
                CrossAxisAlignment.end,


            children: [


              Text(

                value,

                maxLines: 1,

                overflow:
                    TextOverflow.ellipsis,

                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(

                      fontWeight:
                          FontWeight.w900,

                      color:
                          valueColor,
                    ),
              ),



              if (suffix != null) ...[


                const SizedBox(
                  width: 6,
                ),



                Padding(

                  padding:
                      const EdgeInsets.only(
                        bottom: 2,
                      ),


                  child: Text(

                    suffix!,

                    style:
                        Theme.of(context)
                            .textTheme
                            .bodySmall,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}