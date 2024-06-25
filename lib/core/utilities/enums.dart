import 'package:get/get.dart';
import '/core/localization/app_strings.dart';

enum GenderEnum {
  male,
  female,
}

extension GenderEnumExtension on GenderEnum {
  int? get value {
    switch (this) {
      case GenderEnum.female:
        return 0;
      case GenderEnum.male:
        return 1;
      default:
        return null;
    }
  }

  String get nameLocalized {
    return switch (this) {
      GenderEnum.male => AppStrings.male.tr,
      GenderEnum.female => AppStrings.female.tr,
    };
  }

  String get nameAr {
    return switch (this) {
      GenderEnum.male => 'ذكر',
      GenderEnum.female => 'أنثى',
    };
  }

  String get nameEn {
    return switch (this) {
      GenderEnum.male => 'Male',
      GenderEnum.female => 'Female',
    };
  }
}
