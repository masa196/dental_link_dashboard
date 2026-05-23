import 'package:flutter/material.dart';
import 'package:dental_link_dashboard/core/constants/app_fonts/app_typography.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/core/responsive/responsive.dart';
import 'package:dental_link_dashboard/core/responsive/screen_sizes.dart';

class ReceptionistDashboard extends StatelessWidget {
  final VoidCallback? onMenuTap;
  final bool showMenu;

  const ReceptionistDashboard({
    super.key,
    this.onMenuTap,
    this.showMenu = false,
  });

  static const Color primaryColor = Color(0xFF016273);
  static const Color successColor = Color(0xFF53A45A);
  static const Color dangerColor = Color(0xFFE53E3E);
  static const Color neutralLight = Color(0xFFF5F7FA);

  @override
  Widget build(BuildContext context) {
    final isArabic = context.isArabic;
    final scheme = context.scheme;
    final isDesktop = Responsive.isDesktop(context);

    // تم إزالة الـ Scaffold الداخلي ليعتمد على Scaffold الـ Layout ويظهر المحتوى بشكل صحيح
    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isDesktop ? 8.0 : 0.0),
        child: Stack(
          children: [
            // ================= MAIN CONTENT =================
            Column(
              children: [
                _DashboardHeader(
                  isArabic: isArabic,
                  scheme: scheme,
                  showMenu: showMenu,
                  onMenuTap: onMenuTap,
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.only(bottom: 90),
                    itemCount: 4,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      return OrderCard(
                        index: index,
                        isArabic: isArabic,
                        scheme: scheme,
                      );
                    },
                  ),
                ),
              ],
            ),

            // ================= FLOATING PAGINATION =================
            Positioned(
              left: 0,
              right: 0,
              bottom: 10,
              child: Center(child: const _FloatingPagination()),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardHeader extends StatelessWidget {
  const _DashboardHeader({
    required this.isArabic,
    required this.scheme,
    required this.showMenu,
    this.onMenuTap,
  });

  final bool isArabic;
  final ColorScheme scheme;
  final bool showMenu;
  final VoidCallback? onMenuTap;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isMobile = Responsive.isMobile(context);

    // بناء سطر العنوان مع زر القائمة (Drawer) إذا كانت الشاشة صغيرة
    Widget headerTitleRow = Row(
      children: [
        if (showMenu && onMenuTap != null) ...[
          IconButton(
            icon: const Icon(Icons.menu, size: 26),
            onPressed: onMenuTap,
            color: scheme.onSurface,
          ),
          const SizedBox(width: 8),
        ],
        Expanded(
          child: Text(
            isArabic ? 'مركز الإنتاج المباشر' : 'Live Production Center',
            style: TextStyle(
              fontSize: isDesktop ? 26 : 20,
              fontWeight: FontWeight.bold,
              color: scheme.onSurface,
            ),
          ),
        ),
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isMobile) ...[
          headerTitleRow,
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: _SearchBar(isArabic: isArabic, scheme: scheme),
          ),
        ] else ...[
          Row(
            children: [
              Expanded(child: headerTitleRow),
              const SizedBox(width: 18),
              SizedBox(
                width: isDesktop ? 380 : 260,
                child: _SearchBar(isArabic: isArabic, scheme: scheme),
              ),
            ],
          ),
        ],

        const SizedBox(height: 20),

        // جعل حلف التبويبات متجاوب وقابل للتمرير الأفقي في الشاشات الصغيرة
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: _TabsRow(isArabic: isArabic, scheme: scheme),
        ),

        const SizedBox(height: 10),
        Divider(height: 1, thickness: 1, color: Colors.grey.shade200),
      ],
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({required this.isArabic, required this.scheme});

  final bool isArabic;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: TextField(
        textAlign: isArabic ? TextAlign.right : TextAlign.left,
        decoration: InputDecoration(
          hintText: isArabic
              ? 'البحث حسب رقم الحالة أو اسم المريض...'
              : 'Search by case number or patient...',
          hintStyle: TextStyle(
            color: scheme.onSurface.withValues(alpha: AppSizes.alpha55),
            fontSize: AppTypography.fs13,
          ),
          prefixIcon: Icon(Icons.search, color: Colors.grey.shade400, size: 18),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
        ),
      ),
    );
  }
}

class _TabsRow extends StatelessWidget {
  const _TabsRow({required this.isArabic, required this.scheme});

  final bool isArabic;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final tabs = <_TabData>[
      _TabData(
        label: isArabic ? 'طباعة QR' : 'Print QR',
        count: '12',
        active: false,
      ),
      _TabData(
        label: isArabic ? 'استلام الطلب' : 'Receive Order',
        count: '48',
        active: false,
      ),
      _TabData(
        label: isArabic ? 'تسليم الطلب' : 'Deliver Order',
        count: '24',
        active: true,
      ),
    ];
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < tabs.length; i++) ...[
          _TabItem(data: tabs[i], scheme: scheme),
          if (i != tabs.length - 1) const SizedBox(width: 24),
        ],
      ],
    );
  }
}

class _TabData {
  const _TabData({
    required this.label,
    required this.count,
    required this.active,
  });
  final String label;
  final String count;
  final bool active;
}

class _TabItem extends StatelessWidget {
  const _TabItem({required this.data, required this.scheme});
  final _TabData data;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: data.active
                ? ReceptionistDashboard.primaryColor
                : Colors.transparent,
            width: 2,
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            data.label,
            style: TextStyle(
              color: data.active
                  ? ReceptionistDashboard.primaryColor
                  : Colors.grey.shade500,
              fontWeight: data.active ? FontWeight.w700 : FontWeight.w500,
              fontSize: 13,
            ),
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: data.active
                  ? ReceptionistDashboard.primaryColor
                  : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              data.count,
              style: TextStyle(
                color: data.active ? Colors.white : Colors.black87,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  const OrderCard({
    required this.index,
    required this.isArabic,
    required this.scheme,
    super.key,
  });
  final int index;
  final bool isArabic;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    final cards = <_CardData>[
      const _CardData(
        orderId: '#CS-98231',
        patientName: 'جوناثان ميلر',
        doctorName: 'د. سارة جنكينز',
        clinicName: 'عيادة وسط المدينة للأسنان',
        quantity: '3 أسنان',
        material: 'زيركون',
        shade: 'A2',
        price: '1,250 SAR',
        pickupDate: '24/10/2023',
        deliveryDate: '26/10/2023',
        remainingText: 'اليوم',
        isUrgent: true,
      ),
      const _CardData(
        orderId: '#CS-98244',
        patientName: 'إيميلي طومسون',
        doctorName: 'د. ألان جرانت',
        clinicName: 'مركز بايسيد للأسنان',
        quantity: '14 سن',
        material: 'أكريليك',
        shade: 'B1',
        price: '850 SAR',
        pickupDate: '25/10/2023',
        deliveryDate: '27/10/2023',
        remainingText: 'باقي 1 يوم',
        isUrgent: false,
      ),
      const _CardData(
        orderId: '#CS-98112',
        patientName: 'ماركوس زانغ',
        doctorName: 'د. إيلينا رودريغيز',
        clinicName: 'مجمع ساوث سايد الطبي',
        quantity: '1 سن',
        material: 'E-Max',
        shade: 'A1',
        price: '600 SAR',
        pickupDate: '24/10/2023',
        deliveryDate: '25/10/2023',
        remainingText: 'اليوم',
        isUrgent: true,
      ),
      const _CardData(
        orderId: '#CS-98115',
        patientName: 'صوفيا تشين',
        doctorName: 'د. روبرت ويلسون',
        clinicName: 'عيادة نورث هيل للأسنان',
        quantity: '4 أسنان',
        material: 'زيركون عالي الشفافية',
        shade: 'C2',
        price: '1,800 SAR',
        pickupDate: '27/10/2023',
        deliveryDate: '30/10/2023',
        remainingText: 'باقي 3 يوم',
        isUrgent: false,
      ),
    ];
    final card = cards[index];

    // وضع الديسكتوب (توزيع أفقي مرن يعتمد على اتجاه النظام الطبيعي)
    if (isDesktop) {
      // إذا كانت الواجهة عربية، نعرض المحتوى عمودياً بالترتيب المطلوب
      if (isArabic) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Patient column on the right (fixed width to match design)
              SizedBox(
                width: 200,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: _PatientColumn(card: card),
                ),
              ),
              const SizedBox(width: 16),

              // Specs container (middle) - fixed width on desktop
              SizedBox(
                width: isDesktop ? 480 : null,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ReceptionistDashboard.neutralLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _SpecItem(
                          label: 'الكمية',
                          value: card.quantity,
                          accent: false,
                        ),
                      ),
                      _SpecDivider(),
                      Expanded(
                        child: _SpecItem(
                          label: 'نوع المادة',
                          value: card.material,
                          accent: false,
                        ),
                      ),
                      _SpecDivider(),
                      Expanded(
                        child: _SpecItem(
                          label: 'اللون',
                          value: card.shade,
                          accent: false,
                        ),
                      ),
                      _SpecDivider(),
                      Expanded(
                        child: _SpecItem(
                          label: 'السعر',
                          value: card.price,
                          accent: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Status pills
              _StatusColumn(isUrgent: card.isUrgent),
              const SizedBox(width: 16),

              // Dates / action on the left
              SizedBox(
                width: isDesktop ? 180 : 140,
                child: _DateActionColumn(card: card, scheme: scheme),
              ),
            ],
          ),
        );
      }

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            _DateActionColumn(card: card, scheme: scheme),
            const SizedBox(width: 16),
            _StatusColumn(isUrgent: card.isUrgent),
            const SizedBox(width: 16),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: ReceptionistDashboard.neutralLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _SpecItem(
                        label: 'الكمية',
                        value: card.quantity,
                        accent: false,
                      ),
                    ),
                    _SpecDivider(),
                    Expanded(
                      child: _SpecItem(
                        label: 'نوع المادة',
                        value: card.material,
                        accent: false,
                      ),
                    ),
                    _SpecDivider(),
                    Expanded(
                      child: _SpecItem(
                        label: 'اللون',
                        value: card.shade,
                        accent: false,
                      ),
                    ),
                    _SpecDivider(),
                    Expanded(
                      child: _SpecItem(
                        label: 'السعر',
                        value: card.price,
                        accent: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(flex: 2, child: _PatientColumn(card: card)),
          ],
        ),
      );
    } else {
      // وضع الشاشات الصغيرة (التأقلم الرأسي الشامل لمنع الـ Overflow والمسافات المشوهة)
      // للشاشات الصغيرة، نغير الترتيب عند العربية ليطابق المطلوب
      if (isArabic) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.34,
                child: _PatientColumn(card: card),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.46,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: ReceptionistDashboard.neutralLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _SpecItem(
                        label: 'الكمية',
                        value: card.quantity,
                        accent: false,
                      ),
                    ),
                    Expanded(
                      child: _SpecItem(
                        label: 'المادة',
                        value: card.material,
                        accent: false,
                      ),
                    ),
                    Expanded(
                      child: _SpecItem(
                        label: 'اللون',
                        value: card.shade,
                        accent: false,
                      ),
                    ),
                    Expanded(
                      child: _SpecItem(
                        label: 'السعر',
                        value: card.price,
                        accent: true,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 110,
                child: _StatusColumn(isUrgent: card.isUrgent),
              ),
              SizedBox(
                width: 160,
                child: _DateActionColumn(card: card, scheme: scheme),
              ),
            ],
          ),
        );
      }

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _StatusColumn(isUrgent: card.isUrgent),
                const SizedBox(width: 12),
                Expanded(child: _PatientColumn(card: card)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Divider(height: 10, color: Colors.red),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ReceptionistDashboard.neutralLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _SpecItem(
                      label: 'الكمية',
                      value: card.quantity,
                      accent: false,
                    ),
                  ),
                  Expanded(
                    child: _SpecItem(
                      label: 'المادة',
                      value: card.material,
                      accent: false,
                    ),
                  ),
                  Expanded(
                    child: _SpecItem(
                      label: 'اللون',
                      value: card.shade,
                      accent: false,
                    ),
                  ),
                  Expanded(
                    child: _SpecItem(
                      label: 'السعر',
                      value: card.price,
                      accent: true,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            _DateActionColumn(card: card, scheme: scheme),
          ],
        ),
      );
    }
  }
}

class _CardData {
  const _CardData({
    required this.orderId,
    required this.patientName,
    required this.doctorName,
    required this.clinicName,
    required this.quantity,
    required this.material,
    required this.shade,
    required this.price,
    required this.pickupDate,
    required this.deliveryDate,
    required this.remainingText,
    required this.isUrgent,
  });
  final String orderId;
  final String patientName;
  final String doctorName;
  final String clinicName;
  final String quantity;
  final String material;
  final String shade;
  final String price;
  final String pickupDate;
  final String deliveryDate;
  final String remainingText;
  final bool isUrgent;
}

class _DateActionColumn extends StatelessWidget {
  const _DateActionColumn({required this.card, required this.scheme});
  final _CardData card;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return SizedBox(
      width: isDesktop ? 180 : double.infinity,
      child: Column(
        crossAxisAlignment: isDesktop
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.start,
        children: [
          _DateLine(
            label: 'تاريخ الاستلام',
            value: card.pickupDate,
            emphasize: false,
            scheme: scheme,
          ),
          const SizedBox(height: 4),
          _DateLine(
            label: 'تاريخ التسليم',
            value: card.deliveryDate,
            emphasize: true,
            scheme: scheme,
          ),
          const SizedBox(height: 4),
          Text(
            card.remainingText,
            style: TextStyle(
              color: card.isUrgent
                  ? ReceptionistDashboard.dangerColor
                  : Colors.grey.shade500,
              fontWeight: FontWeight.w700,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: isDesktop ? 180 : double.infinity,
            height: 38,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: ReceptionistDashboard.primaryColor,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'اختيار موظف التوصيل',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DateLine extends StatelessWidget {
  const _DateLine({
    required this.label,
    required this.value,
    required this.emphasize,
    required this.scheme,
  });
  final String label;
  final String value;
  final bool emphasize;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: scheme.onSurface.withValues(alpha: 0.55),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            color: emphasize
                ? ReceptionistDashboard.primaryColor
                : scheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _StatusColumn extends StatelessWidget {
  const _StatusColumn({required this.isUrgent});
  final bool isUrgent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 115,
      child: Column(
        children: [
          _OutlinePill(
            label: 'جاهز للتسليم',
            background: ReceptionistDashboard.successColor.withValues(
              alpha: 0.1,
            ),
            borderColor: ReceptionistDashboard.successColor.withValues(
              alpha: 0.2,
            ),
            textColor: ReceptionistDashboard.successColor,
          ),
          const SizedBox(height: 8),
          _OutlinePill(
            label: 'ملحقات الطلبية',
            background: Colors.white,
            borderColor: Colors.grey.shade300,
            textColor: Colors.grey.shade700,
          ),
        ],
      ),
    );
  }
}

class _PatientColumn extends StatelessWidget {
  const _PatientColumn({required this.card});
  final _CardData card;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isArabic = context.isArabic;

    return Column(
      crossAxisAlignment: isArabic
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          card.orderId,
          textAlign: isArabic ? TextAlign.right : TextAlign.left,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade400,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          card.patientName,
          textAlign: isArabic ? TextAlign.right : TextAlign.left,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 2),
        Text(
          card.doctorName,
          textAlign: isArabic ? TextAlign.right : TextAlign.left,
          style: const TextStyle(
            color: ReceptionistDashboard.primaryColor,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: isDesktop
              ? MainAxisAlignment.start
              : MainAxisAlignment.end,
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 13,
              color: Colors.grey.shade500,
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                card.clinicName,
                textAlign: isArabic ? TextAlign.right : TextAlign.left,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SpecItem extends StatelessWidget {
  const _SpecItem({
    required this.label,
    required this.value,
    required this.accent,
  });
  final String label;
  final String value;
  final bool accent;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: accent
                ? ReceptionistDashboard.primaryColor
                : Colors.grey.shade800,
            fontSize: accent ? 13 : 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _SpecDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 32, color: Colors.grey.shade300);
  }
}

class _OutlinePill extends StatelessWidget {
  const _OutlinePill({
    required this.label,
    required this.background,
    required this.borderColor,
    required this.textColor,
  });
  final String label;
  final Color background;
  final Color borderColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: borderColor),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w700,
          fontSize: 11,
        ),
      ),
    );
  }
}

class _FloatingPagination extends StatelessWidget {
  const _FloatingPagination();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _PageArrow(icon: Icons.chevron_left),
          const _PageButton(text: '1', active: true),
          const _PageButton(text: '2'),
          const _PageButton(text: '3'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              '...',
              style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
            ),
          ),
          const _PageButton(text: '12'),
          const _PageArrow(icon: Icons.chevron_right),
        ],
      ),
    );
  }
}

class _PageButton extends StatelessWidget {
  const _PageButton({required this.text, this.active = false});
  final String text;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26,
      height: 26,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: active ? ReceptionistDashboard.primaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          color: active ? Colors.white : Colors.black87,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _PageArrow extends StatelessWidget {
  const _PageArrow({required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 26,
      height: 26,
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {},
        icon: Icon(icon, size: 16, color: Colors.grey.shade400),
      ),
    );
  }
}
