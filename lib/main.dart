
import 'package:dental_link_dashboard/core/auth/auth_token_storage.dart';
import 'package:dental_link_dashboard/notifications/domain/entities/device_token_entity.dart';
import 'package:dental_link_dashboard/notifications/domain/usecases/create_device_token_usecase.dart';
import 'package:dental_link_dashboard/notifications/services/firebase/firebase_messaging_service.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dental_link_dashboard/app.dart';
import 'package:dental_link_dashboard/core/services/locator.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint(
      "Firebase initialization failed: $e",
    );
  }


  await Hive.initFlutter();
  await Hive.openBox<String>('settings');
  await configureDependencies();


  try {
    final messagingService = locator<FirebaseMessagingService>();

    await messagingService.initialize();
    await _registerDeviceTokenIfLoggedIn();
  } catch (e) {
    debugPrint(
      "Firebase messaging setup skipped: $e",
    );
  }
  runApp(const DentalLinkDashboardApp(), );
}

Future<void> _registerDeviceTokenIfLoggedIn() async {
  try {
    final authStorage =  locator<AuthTokenStorage>();

    final token = authStorage.token;


    if(token == null || token.isEmpty){
      return;
    }


    final fcmToken = await locator<FirebaseMessagingService>
    ().getToken();


    if(fcmToken == null || fcmToken.isEmpty){
      return;
    }


    await locator<CreateDeviceTokenUseCase>()
        .call(
          DeviceTokenEntity(
            token: fcmToken,
            deviceType: 'web',
          ),
        );


  } catch(e){

    debugPrint(
      "Firebase restore ignored: $e",
    );

  }
}