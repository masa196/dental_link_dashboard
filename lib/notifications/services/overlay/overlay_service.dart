
import 'package:dental_link_dashboard/notifications/presentation/widgets/notification_overlay_card.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class OverlayService {
  OverlayEntry? _entry;
  late OverlayState _overlay;

  bool get isShowing => _entry != null;

  void attach(BuildContext context) {
  _overlay = Overlay.of(context);
}

 void show({
  required String title,
  required String body,
}) {


  hide();

  _entry = OverlayEntry(
    builder: (_) => _NotificationOverlay(
      title: title,
      body: body,
    ),
  );

  _overlay.insert(_entry!);

  Future.delayed(const Duration(seconds: 5), hide);
}

  void hide() {
    _entry?.remove();
    _entry = null;
  }
}


class _NotificationOverlay extends StatefulWidget {
  const _NotificationOverlay({
    required this.title,
    required this.body,
  });

  final String title;
  final String body;

  @override
  State<_NotificationOverlay> createState() =>
      _NotificationOverlayState();
}

class _NotificationOverlayState
    extends State<_NotificationOverlay>
    with SingleTickerProviderStateMixin {

  late final AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 24,
      right: 24,
      child: SlideTransition(
        position: Tween(
          begin: const Offset(1.2, 0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Curves.easeOut,
          ),
        ),
        child: FadeTransition(
          opacity: controller,
          child: NotificationOverlayCard(
            title: widget.title,
            body: widget.body,
          ),
        ),
      ),
    );
  }
}