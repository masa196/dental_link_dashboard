import 'package:flutter/material.dart';

import 'package:dental_link_dashboard/core/navigation/app_breadcrumbs.dart';

class CreateEmployeeTopBar extends StatelessWidget {
  const CreateEmployeeTopBar({
    super.key,
    required this.breadcrumbs,
    required this.isArabic,
    required this.scheme,
    required this.showMenuButton,
    required this.onMenuTap,
    required this.onCancel,
    required this.onSave,
    required this.isLoading,
  });

  final List<AppBreadcrumbItem> breadcrumbs;
  final bool isArabic;
  final ColorScheme scheme;
  final bool showMenuButton;
  final VoidCallback? onMenuTap;
  final VoidCallback onCancel;
  final VoidCallback? onSave;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // الارتفاع الموحد والداخلي المتناسق لشريط الويب العلوى
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: scheme.surface,
        // إزالة الحواف الدائرية والظل واستبدالها بفاصل سفلي ناعم واحترافي
        border: Border(
          bottom: BorderSide(
            color: scheme.outlineVariant.withValues(alpha: 0.15),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // الجزء الأيسر: زر القائمة، الـ Breadcrumbs، والعنوان
          Expanded(
            child: Row(
              children: [
                if (showMenuButton)
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 12),
                    child: IconButton(
                      onPressed: onMenuTap,
                      icon: const Icon(Icons.menu_rounded),
                      style: IconButton.styleFrom(
                        foregroundColor: scheme.onSurfaceVariant,
                        minimumSize: const Size(40, 40),
                      ),
                    ),
                  ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: isArabic
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      // تم الاحتفاظ بالـ Breadcrumbs تماماً كما طلبت
                      AppBreadcrumbs(items: breadcrumbs),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 24), // مسافة أمان لمنع تداخل العناصر
          // الجزء الأيمن: أزرار التحكم (Cancel & Save)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _PageButton(
                label: isArabic ? 'إلغاء' : 'Cancel',
                backgroundColor: Colors
                    .transparent, // جعل زر الإلغاء شفاف أو Outlined يعطي طابع ويب مودرن
                foregroundColor: scheme.onSurfaceVariant,
                onPressed: onCancel,
                isPrimary: false,
              ),
              const SizedBox(width: 12),
              _PageButton(
                label: isArabic ? 'حفظ التغييرات' : 'Save changes',
                backgroundColor: scheme.primary,
                foregroundColor: scheme.onPrimary,
                onPressed: onSave,
                isLoading: isLoading,
                isPrimary: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PageButton extends StatelessWidget {
  const _PageButton({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.onPressed,
    required this.isPrimary,
    this.isLoading = false,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:
          40, // ارتفاع قياسي عالمي لأزرار الويب (Standard Web Button Height)
      child: isPrimary
          ? FilledButton(
              onPressed: onPressed,
              style: FilledButton.styleFrom(
                backgroundColor: backgroundColor,
                foregroundColor: foregroundColor,
                elevation: 0, // إلغاء الظلال الحادة للأزرار
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    8,
                  ), // حواف ناعمة ومتناسقة (8px)
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              child: _buildButtonContent(),
            )
          : TextButton(
              onPressed: onPressed,
              style: TextButton.styleFrom(
                foregroundColor: foregroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              child: _buildButtonContent(),
            ),
    );
  }

  Widget _buildButtonContent() {
    return isLoading && onPressed != null
        ? SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
            ),
          )
        : Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          );
  }
}
