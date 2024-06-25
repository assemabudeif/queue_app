import 'package:get/get.dart';

import 'ar_translations.dart';
import 'en_translations.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': enTranslations,
        'ar': arTranslations,
      };
}
