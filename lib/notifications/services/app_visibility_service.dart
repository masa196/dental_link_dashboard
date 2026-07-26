// ignore: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:html' as html;
import 'package:injectable/injectable.dart';


@lazySingleton
class AppVisibilityService {


  void initialize(
      Function() onVisible,
  ) {

    html.document.onVisibilityChange.listen((_) {

      if(html.document.visibilityState == 'visible') {

        onVisible();

      }

    });

  }

}