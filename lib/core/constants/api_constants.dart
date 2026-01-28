class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://flower.elevateegy.com/api/v1/';

  // ------------------------ AUTH ------------------------ //
  static const String registerEndpoint = 'auth/signup';
  static const String loginEndPoint = 'auth/signin';

  // -------------------- FORGET PASSWORD ------------------ //
  static const String forgetPasswordEndpoint = 'auth/forgotPassword';
  static const String verifyResetCodeEndpoint = 'auth/verifyResetCode';
  static const String resetPasswordEndpoint = 'auth/resetPassword';

  // ------------------------ PRODUCTS --------------------- //
  static const String productByIdEndpoint = 'products/{id}';
  static const String productsEndpoint = 'products/{id}';
  static const String idPathQuery = 'id';

  // ---------------------- BEST SELLER -------------------- //
  static const String bestSellerEndPoint = 'best-seller';


  //------------------------ CATEGORIES ------------------------//
  static const String getAllCategories = 'categories';
  static const String getCategoryProducts = 'categories/{id}';
  static const String getAllOccasions = "occasions";

  // ------------------------- CART ------------------------ //
  static const String cartEndpoint = 'cart';
}
