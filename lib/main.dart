import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dental_link_dashboard/app.dart';
import 'package:dental_link_dashboard/core/services/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  // open a small settings box to persist simple app preferences (locale, theme)
  await Hive.openBox<String>('settings');

  await configureDependencies();

  runApp(const DentalLinkDashboardApp());
}
