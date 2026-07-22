import 'package:flutter/material.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';

class AppSnackbarHelper {
  AppSnackbarHelper._();

  static void showSuccess(
    BuildContext context, {
    required String title,
    required String message,
  }) {
    _show(context, title: title, message: message, isSuccess: true);
  }

  static void showFailure(
    BuildContext context, {
    required String title,
    required String message,
    AppFailure? failure,
  }) {
    String validationDetails = '';

    if (failure != null && failure.type == AppFailureType.validation) {
      final errors = failure.errors;
      if (errors != null && errors.isNotEmpty) {
        validationDetails = errors.entries
            .map((entry) => '${entry.key}: ${entry.value.join(', ')}')
            .join('\n');
      }
    }

    final detailedMessage = validationDetails.isEmpty
        ? message
        : '$message\n$validationDetails';

    _show(context, title: title, message: detailedMessage, isSuccess: false);
  }

  static void _show(
    BuildContext context, {
    required String title,
    required String message,
    required bool isSuccess,
  }) {
    final overlay = Overlay.of(context, rootOverlay: true);

    // الألوان المتناسقة مع واجهتك (أخضر مريح للنجاح، وأحمر دافئ للفشل)
    final backColor = isSuccess
        ? const Color(0xffE8F5E9)
        : const Color(0xffFFEBEE);
    final borderColor = isSuccess
        ? const Color(0xff4CAF50)
        : const Color(0xffEF5350);
    final iconColor = isSuccess
        ? const Color(0xff2E7D32)
        : const Color(0xffC62828);
    final textColor = isSuccess
        ? const Color(0xff1B5E20)
        : const Color(0xffB71C1C);

    late final OverlayEntry entry;

    entry = OverlayEntry(
      builder: (overlayContext) {
        return _ToastAnimationWrapper(
          onDismiss: () {
            if (entry.mounted) entry.remove();
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              24,
              MediaQuery.of(overlayContext).padding.top + 24,
              24,
              0,
            ),
            child: SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 520),
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: backColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: borderColor.withValues(alpha: 0.5),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: borderColor.withValues(alpha: 0.08),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: borderColor.withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isSuccess
                                  ? Icons.check_circle_rounded
                                  : Icons.error_rounded,
                              color: iconColor,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  message,
                                  style: TextStyle(
                                    color: textColor.withValues(alpha: 0.85),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    overlay.insert(entry);
  }
}

class DepartmentSnackbarHelper {
  DepartmentSnackbarHelper._();

  static void showSuccess(
    BuildContext context, {
    required String title,
    required String message,
  }) {
    AppSnackbarHelper.showSuccess(context, title: title, message: message);
  }

  static void showFailure(
    BuildContext context, {
    required String title,
    required String message,
    AppFailure? failure,
  }) {
    AppSnackbarHelper.showFailure(
      context,
      title: title,
      message: message,
      failure: failure,
    );
  }
}

// ويدجت مخصصة للتحكم بحركة ظهور واختفاء الإشعار بسلاسة (Fade & Slide)
class _ToastAnimationWrapper extends StatefulWidget {
  const _ToastAnimationWrapper({required this.child, required this.onDismiss});
  final Widget child;
  final VoidCallback onDismiss;

  @override
  State<_ToastAnimationWrapper> createState() => _ToastAnimationWrapperState();
}

class _ToastAnimationWrapperState extends State<_ToastAnimationWrapper>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    _controller.forward();

    // تشغيل الـ Timer للاختفاء التلقائي بعد 4 ثوانٍ
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        _controller.reverse().then((_) => widget.onDismiss());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(position: _slideAnimation, child: widget.child),
    );
  }
}
