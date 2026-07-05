import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/show_orders/show_orders_bloc.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/show_orders/show_orders_event.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/show_orders/show_orders_state.dart';

class PriorityFilter extends StatelessWidget {
  const PriorityFilter({super.key});

  static const String all = 'all';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowOrdersBloc, ShowOrdersState>(
      builder: (context, state) {
        final selected = state.currentPriority ?? all;

        final colorScheme = Theme.of(context).colorScheme;

        return SizedBox(
          width: 150,
          child: DropdownButtonFormField<String>(
            value: selected,

            isDense: true,
            iconSize: 18,
            elevation: 2,
            dropdownColor: colorScheme.surface,

            decoration: InputDecoration(
              labelText: 'Priority',
              labelStyle: TextStyle(
                fontSize: 12,
                color: colorScheme.onSurfaceVariant,
              ),

              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: colorScheme.outlineVariant),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: colorScheme.primary, width: 1.2),
              ),
            ),

            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),

            items: [
              DropdownMenuItem(
                value: all,
                child: Text(
                  'الكل',
                  style: TextStyle(color: colorScheme.primary),
                ),
              ),
              DropdownMenuItem(
                value: 'urgent',
                child: Text(
                  'مستعجل',
                  style: TextStyle(color: colorScheme.primary),
                ),
              ),
              DropdownMenuItem(
                value: 'normal',
                child: Text(
                  'عادي',
                  style: TextStyle(color: colorScheme.primary),
                ),
              ),
            ],

            onChanged: (priority) {
              final isAll = priority == all;

              context.read<ShowOrdersBloc>().add(
                ShowOrdersRequested(
                  status: state.currentStatus!,
                  page: 1,
                  priority: isAll ? null : priority,
                  clearPriority: isAll,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
