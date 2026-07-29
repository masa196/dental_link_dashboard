import 'package:dental_link_dashboard/features/receptionist/data/models/all_doctors/all_doctors_model.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/pages/doctors/widgets/doctors_statistics_card.dart';
import 'package:flutter/material.dart';

class DoctorsStatistics extends StatelessWidget {
  const DoctorsStatistics({
    super.key,
    required this.totals,
  });

  final Totals? totals;

 @override
Widget build(BuildContext context) {
  final colors = Theme.of(context).colorScheme;

  final items = [
    DoctorsStatisticsCard(
      title: "إجمالي المستحقات",
      value: "${totals?.totalBilled ?? 0}",
      suffix: "ل.س",
      valueColor: colors.onSurface,
    ),

    DoctorsStatisticsCard(
      title: "إجمالي التحصيلات",
      value: "${totals?.totalPaid ?? 0}",
      suffix: "ل.س",
      valueColor: Colors.green,
    ),

    DoctorsStatisticsCard(
      title: "الديون المتبقية",
      value: "${totals?.totalOwed ?? 0}",
      suffix: "ل.س",
      valueColor: Colors.red,
    ),

    DoctorsStatisticsCard(
      title: "نسبة السداد",
      value:
          "${(totals?.repaymentPercentage ?? 0).toStringAsFixed(1)}%",
      valueColor: colors.onSurface,
    ),
  ];


  return Directionality(
    textDirection: TextDirection.rtl,

    child: LayoutBuilder(
      builder: (context, constraints) {

        const spacing = 20.0;
        const minCardWidth = 260.0;

        final requiredWidth =
            (minCardWidth * items.length) +
            (spacing * (items.length - 1));


        final isScrollable =
            requiredWidth > constraints.maxWidth;


        return SingleChildScrollView(

          scrollDirection: Axis.horizontal,

          child: Row(

            mainAxisSize: isScrollable
                ? MainAxisSize.min
                : MainAxisSize.max,


            children: List.generate(
              items.length,

              (index) {

                return Padding(

                  padding: EdgeInsets.only(
                    left: index == items.length - 1
                        ? 0
                        : spacing,
                  ),


                  child: SizedBox(

                    width: isScrollable
                        ? minCardWidth
                        : (constraints.maxWidth -
                            (spacing * (items.length - 1))) /
                            items.length,


                    height: 140,

                    child: items[index],
                  ),
                );
              },
            ),
          ),
        );
      },
    ),
  );
}
}