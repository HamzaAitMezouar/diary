abstract class Urls {
  static String baseUrl = "http://10.0.2.2:3040/api/v1/";
  // "http://127.0.0.1:3040/api/v1/";
  //

  static String refreshToken = "${baseUrl}token/refresh_token";

  static String auth = "${baseUrl}auth/";
  static String requestOtp = "${auth}request-otp";
  static String verifyOtp = "${auth}verify-otp";
  static String addToken = "${auth}add-token";

  static String resenOtp = "${auth}resend-otp";
  static String loginMail = "${auth}login-email";
  static String socialMediaLogin = "${auth}social-media-login";
  static String verifyEmail = "${auth}verify-email/:encryptedEmail";
  static String logout = "${auth}log-out";

  static String medicament = "${baseUrl}medicament";
  static String category = "${baseUrl}category";

  static String pharmacy = "${baseUrl}pharmacy";
  static String orders = "${baseUrl}order";
  static String acceptPharmacyOrder = "${baseUrl}order/accept_order";
  static String payment = "${baseUrl}payment";
  static String savecard = "${payment}create_card";
  static String pay = "${payment}pay";
}
