import '/core/utilities/enums.dart';

class ApiConstance {
  static String baseUrl =
      // 'https://9823-196-150-198-46.ngrok-free.app';
      "https://kernel-code.site/qapp";

  static int sessionId = -1;

  /// Auth
  static String blackList(String phoneNumber) => "/blacklist/$phoneNumber";
  static String login = "/login/$sessionId";
  static String logout = "/logout/$sessionId";
  static String sedOtp({
    required String phoneNumber,
    required GenderEnum gender,
    required String deviceId,
  }) =>
      "/sendOtp/$phoneNumber/${gender.value ?? 1}/$deviceId";
  static String verifyOtp(String otp) => "/Verify/$otp";

  /// Home
  static String findORGsPath({
    required double lat,
    required double long,
  }) =>
      "/findbr/$lat/$long/$sessionId";

  static String search(String name) => '/searchbr/$name/$sessionId';
  static String viewTokens = "/view/$sessionId";

  /// Services
  static String searchDepartment(String orgId) =>
      '/searchDepartment/$orgId/$sessionId';
  static String generateToken({
    required String depId,
    required String branchId,
  }) =>
      '/generate/$depId/$sessionId/$branchId';
  static String getRemainingTokensWithoutToken(String depId) =>
      '/get_remaining_tokens_withoutToken/$depId/$sessionId';

  static String getRemainingTokensWithoutTokenWithReservation(String depId) =>
      '/get_remaining_tokens_withoutToken_with_reservation/$depId/$sessionId';

  /// Token Information
  static String getRemainingToken({
    required String depId,
    required String tokenNumber,
  }) =>
      '/get_remaining_tokens/$tokenNumber/$depId/$sessionId';

  static String getTokenInfoWithSlot({
    required String depId,
    required String tokenNumber,
  }) =>
      '/gettokeninfo/$depId/$tokenNumber';

  static String cancelToken({
    required String depId,
    required String tokenNumber,
  }) =>
      '/cancel/$tokenNumber/$depId/$sessionId';

  static String transferToken({
    required String tokenNumber,
    required String depId,
    required String phoneNumber,
  }) =>
      '/transfaretoken/$tokenNumber/$depId/$phoneNumber';

  static String rateToken({
    required int tokenNumber,
    required int tokenId,
    required int depId,
    required int slotId,
    required int rate,
  }) =>
      '/ratings/$tokenId/$tokenNumber/$depId/$slotId/$rate';

  static String getDepQuestions({
    required String depId,
  }) =>
      '/questions/$depId';

  static String sendAnswer = '/sendanswer';
}
