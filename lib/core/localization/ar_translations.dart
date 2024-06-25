import 'app_strings.dart';

Map<String, String> get arTranslations => {
      // General
      AppStrings.appName: 'تطبيق الطابور',
      AppStrings.invalidPageName: 'اسم الصفحة غير صحيح',
      AppStrings.changeLanguage: 'Change language to English',
      AppStrings.exit: 'الخروج',
      AppStrings.areYouSureToExitApp: 'هل أنت متأكد من الخروج من التطبيق؟',
      AppStrings.cancel: 'إلغاء',
      AppStrings.notifications: 'الإشعارات',
      AppStrings.error: 'خطأ',
      AppStrings.success: 'نجاح',
      AppStrings.registerSuccess: 'تم التسجيل بنجاح',
      AppStrings.loginSuccess: 'تم تسجيل الدخول بنجاح',
      AppStrings.pleaseAgreeToTheTermsAndPolicy:
          'يرجى الموافقة على الشروط والسياسة',
      AppStrings.empty: 'فارغ',
      AppStrings.retry: 'إعادة المحاولة',
      AppStrings.noMoreItems: 'لا يوجد المزيد من العناصر',

      // General Errors
      AppStrings.connectionTimeoutWithApiServer: 'انتهت مهلة الاتصال مع الخادم',
      AppStrings.receiveTimeoutWithApiServer: 'انتهت مهلة الاستقبال مع الخادم',
      AppStrings.sendTimeoutWithApiServer: 'انتهت مهلة الإرسال مع الخادم',
      AppStrings.yourRequestWithApiServerWasCanceled: 'تم إلغاء طلبك مع الخادم',
      AppStrings.failedToAuthenticateWithApiServer: 'فشل في المصادقة مع الخادم',
      AppStrings.thereWasAConnectionErrorWithTheServer:
          'كان هناك خطأ في الاتصال مع الخادم',
      AppStrings.checkYourInternetConnectionPlease:
          'تحقق من اتصالك بالإنترنت من فضلك!',
      AppStrings.thereWasAnUnknownErrorWithTheServer:
          'كان هناك خطأ غير معروف مع الخادم',
      AppStrings.yourRequestNotFoundPleaseTryAgainLater:
          'لم يتم العثور على طلبك، يرجى المحاولة مرة أخرى لاحقا!',
      AppStrings.internalServerErrorPleaseTryAgainLater:
          'خطأ داخلي في الخادم، يرجى المحاولة مرة أخرى لاحقا!',
      AppStrings.oopsThereWasAnErrorPleaseTryAgainLater:
          'عذرا، حدث خطأ، يرجى المحاولة مرة أخرى لاحقا!',
      AppStrings.yourSessionHasExpiredPleaseLoginAgain:
          'انتهت جلستك، يرجى تسجيل الدخول مرة أخرى!',
      AppStrings.youAreBlacklisted: 'أنت في القائمة السوداء!',
      AppStrings.failedToSendOTP: 'فشل في إرسال رمز التحقق',
      AppStrings.invalidOTP: 'رمز التحقق غير صحيح!',
      AppStrings.alertTitle: 'تنبيه!',

      /// On Boarding
      AppStrings.onBoardingOneTitle: 'توفير الوقت',
      AppStrings.onBoardingOneDescription:
          'من خلال حجز خدمتك بنقرة زر ورؤية موقعك في الصف',
      AppStrings.onBoardingTwoTitle: 'علم موقعك',
      AppStrings.onBoardingTwoDescription:
          'اختر موقعك وشاهد الخدمات القريبة منك',
      AppStrings.next: 'التالي',
      AppStrings.skip: 'تخطى',

      /// Auth
      AppStrings.queue: 'الطابور',
      AppStrings.selectGender: 'اختر الجنس',
      AppStrings.otpVerification: 'التحقق من رمز التحقق',
      AppStrings.dontYouReceiveOTP: "لم تستلم رمز التحقق؟",
      AppStrings.resendOTP: 'إعادة إرسال رمز التحقق',
      AppStrings.submit: 'إرسال',
      AppStrings.phoneNumberRequired: 'رقم الهاتف مطلوب',

      /// Home
      AppStrings.search: 'بحث',
      AppStrings.home: 'الرئيسية',
      AppStrings.nearestOrganizations: 'أقرب المؤسسات',
      AppStrings.tokens: 'الرموز',
      AppStrings.settings: 'الإعدادات',
      AppStrings.viewDetails: 'عرض التفاصيل',
      AppStrings.locationServicesAreDisabled: 'خدمات الموقع معطلة',
      AppStrings.locationPermissionsAreDenied: 'تم رفض أذونات الموقع',
      AppStrings.branchNotAvailable: 'الفرع غير متاح اليوم',
      AppStrings.branchAvailableDaysIs: 'أيام الفرع المتاحة هي',
      AppStrings.branchAvailableHoursIs: 'عدد الساعات المتاحة الفرع هي',
      AppStrings.ok: 'حسنا',

      /// Settings
      AppStrings.termsAndConditions: 'الشروط والأحكام',
      AppStrings.privacyPolicy: 'سياسة الخصوصية',
      AppStrings.logout: 'تسجيل الخروج',
      AppStrings.areYouSureToLogout: 'هل انت متأكد من انك تريد تسجيل الخروج؟',
      AppStrings.logoutSuccess: 'تم تسجيل الخروج بنجاح',

      /// Tokens
      AppStrings.organization: 'المؤسسة',
      AppStrings.service: 'الخدمة',
      AppStrings.yourToken: 'رمزك',
      AppStrings.delay: 'تأخير',
      AppStrings.reservationCanceled: 'تم إلغاء الحجز بنجاح!',
      AppStrings.cantCanceledTokenTryAgain:
          "لا يمكن إلغاء الرمز المميز، حاول مرة أخرى لاحقًا!",

      /// Organisation Details
      AppStrings.getToken: 'احصل على رمز',
      AppStrings.delayReservation: 'تأخير الحجز',
      AppStrings.yourCurrentNumber: 'رقمك الحالي',
      AppStrings.cancelReservation: 'إلغاء الحجز',
      AppStrings.areYouSureYouWantToCancelThisReservation:
          'هل أنت متأكد من أنك تريد إلغاء هذا الحجز؟',
      AppStrings.no: 'لا',
      AppStrings.yes: 'نعم',
      AppStrings.confirmReservation: 'تأكيد الحجز',
      AppStrings.remainingToken: 'الرموز المتبقية',
      AppStrings.estimatedTime: 'الوقت المقدر',
      AppStrings.min: 'دقيقة',
      AppStrings.noTokenAvailable: 'لا توجد رموز متاحة',
      AppStrings.phoneNumberNotFound:
          'رقم الهاتف غير موجود, يرجى التأكد من الرقم المدخل!',
      AppStrings.tokenTransferredSuccessfully: 'تم نقل الرمز بنجاح',
      AppStrings.areYouSureYouWantToReservationConfirmation:
          'هل أنت متأكد من أنك تريد تأكيد هذا الحجز؟',

      /// Token information Screen
      AppStrings.tokenInfo: 'معلومات الرمز',
      AppStrings.reservationNumber: 'رقم الحجز',
      AppStrings.currentNumber: 'الرقم الحالي',
      AppStrings.nameOfOrganization: 'اسم المؤسسة',
      AppStrings.transferReservation: 'نقل الحجز',
      AppStrings.phoneNumber: 'رقم التليفون',
      AppStrings.send: 'ارسال',
      AppStrings.forService: 'للخدمة',
      AppStrings.pleaseGoTo: 'برجاء التوجه ل',
      AppStrings.slot: 'شباك',
      AppStrings.yourTokenIsNotInTheSlotYet:
          'رمزك ليس على الشباك بعد، يرجى الانتظار!',
      AppStrings.areYouSureYouWantToDelayReservation:
          'هل أنت متأكد من أنك تريد تأخير الحجز؟',
      AppStrings.rateService: 'تقييم الخدمة',
      AppStrings.submitRating: 'إرسال التقييم',
      AppStrings.questionsAboutTheService: 'أسئلة حول الخدمة',
      AppStrings.answerToTheQuestion: 'إجابة السؤال',

      /// Qr View
      AppStrings.scanQRCode: 'مسح الكود الشريطي',
      AppStrings.barcodeType: 'نوع الباركود',
      AppStrings.data: 'البيانات',
    };
