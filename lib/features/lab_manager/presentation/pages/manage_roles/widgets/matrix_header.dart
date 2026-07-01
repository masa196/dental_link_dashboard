import 'package:flutter/material.dart';

class MatrixHeader extends StatelessWidget {
  const MatrixHeader({
    super.key,
    required this.roles,
    required this.permissionWidth,
    required this.roleWidth,
    required this.isArabic,
    
  });

  final List<String> roles;
  final double permissionWidth;
  final double roleWidth;
  final bool isArabic;

 

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.6),
        border: Border(
          bottom: BorderSide(
            color: scheme.outline.withValues(alpha: 0.25),
          ),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: permissionWidth,
            child: Center(
              child: Text(
                isArabic ? 'الصلاحية' : 'Permission',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),

          for (int i = 0; i < roles.length; i++)
            SizedBox(
              width: roleWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      roles[i],
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),

                  const SizedBox(width: 6),

              
                ],
              ),
            ),
        ],
      ),
    );
  }
}