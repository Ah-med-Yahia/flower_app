class ApiConstants {
  ApiConstants._();

  static const String baseUrl = "https://flower.elevateegy.com/api/v1/";
  static const String productByIdEndpoint = "/products/{id}";
  static const String idPathQuery = "id";

  //-------------------------- Forget Password Endpoints --------------------------//
  static const String forgetPasswordEndpoint = "auth/forgotPassword";
  static const String verifyResetCodeEndpoint = "auth/verifyResetCode";
  static const String resetPasswordEndpoint = "auth/resetPassword";

  //------------------------ BEST SELLER ------------------------//
  static const String bestSellerEndPoint = 'best-seller';

  //------------------------ PRODUCT DETAILS ------------------------//
  static const String productsEndpoint = "/products/{id}";

  //------------------------ CATEGORIES ------------------------//
  static const String getAllOccasions = "occasions";
  static const String loginEndPoint = 'auth/signin';
}
