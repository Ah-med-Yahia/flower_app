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
  static const String changePasswordEndPoint = 'auth/change-password';

  // ------------------------ PRODUCTS --------------------- //
  static const String productByIdEndpoint = 'products/{id}';
  static const String idPathQuery = 'id';

  // ---------------------- BEST SELLER -------------------- //
  static const String bestSellerEndPoint = 'best-seller';

  //------------------------ CATEGORIES ------------------------//
  static const String getAllCategories = 'categories';
  static const String getCategoryProducts = 'products';

  //------------------------ Occasions ------------------------//
  static const String getAllOccasions = 'occasions';
  static const String getOccasionProducts = 'occasions/{id}';

  //------------------------ Home Screen ------------------------//
  static const String homeScreenEndPoint = 'home';

  //------------------------ PROFILE ------------------------//
  static const String profileDataEndPoint = 'auth/profile-data';

  // ------------------------- CART ------------------------ //
  static const String cartEndpoint = 'cart';
  static const String removeItemFromCartEndpoint = 'cart/{id}';
  static const String updateCartItemEndpoint = 'cart/{id}';
  //------------------------ ADDRESS ------------------------//
  static const String addAddress = 'addresses';
  static const String updateAddress = 'addresses/{id}';
}

class QueryParamsKey {
  static const String categoryId = 'category';
}
