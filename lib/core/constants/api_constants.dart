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
  static const String uploadUserImageEndPoint = 'auth/upload-photo';
  static const String editProfileEndPoint = 'auth/editProfile';
  static const String photoPart = 'photo';

  // ------------------------- CART ------------------------ //
  static const String cartEndpoint = 'cart';
  static const String removeItemFromCartEndpoint = 'cart/{id}';
  static const String updateCartItemEndpoint = 'cart/{id}';

  //------------------------ ADDRESS ------------------------//
  static const String addressEndPoint = 'addresses';
  static const String addressByIDEndPoint = 'addresses/{id}';
}

class QueryParamsKey {
  QueryParamsKey._();
  static const String categoryId = 'category';
  static const String sort = 'sort';
  static const String search = 'keyword';
}

class QueryParamsValues {
  QueryParamsValues._();
  static const String lowestPrice = 'price';
  static const String highestPrice = '-price';
  static const String newest = 'createdAt';
  static const String oldest = '-createdAt';
  static const String lowestPriceAfterDiscount = 'priceAfterDiscount';
}
