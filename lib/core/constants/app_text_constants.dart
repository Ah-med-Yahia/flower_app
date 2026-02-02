import 'package:easy_localization/easy_localization.dart';

class AppTextConstants {
  AppTextConstants._();
  static const String home = 'Home';
  static const String categories = 'Categories';
  static const String cart = 'Cart';
  static const String occasion = 'Occasion';
  static const String profile = 'Profile';
  static const String logout = 'Logout';
  static const String confirmLogout = 'Confirm logout!!';
  static const String cancel = 'Cancel';
  static const String failedToRegister =
      'Failed to register. Please try again.';
  static const String signUp = 'Sign Up';
  static const String firstName = 'First Name';
  static const String lastName = 'Last Name';
  static const String enterFirstName = 'Enter first name';
  static const String enterLastName = 'Enter last name';
  static const String password = 'Password';
  static const String enterPassword = 'Enter password';
  static const String confirmPassword = 'Confirm Password';
  static const String enterConfirmPassword = 'Enter confirm password';
  static const String email = 'Email';
  static const String enterEmail = 'Enter email';
  static const String phoneNumber = 'Phone Number';
  static const String enterPhoneNumber = 'Enter phone number';
  static const String gender = 'Gender';
  static const String female = 'Female';
  static const String male = 'Male';

  static const String creatingAccountAgreement =
      'Creating an account, you agree to our ';
  static const String termsAndConditions = 'Terms&Conditions';
  static const String alreadyHaveAccount = 'Already have an account?';
  static const String login = 'Login';
  static const String invalidPhoneNumber = 'Invalid phone number';
  static const String accountCreatedSuccessfully =
      'Account created successfully';
  static const String addToCart = 'Add to Cart';
  static const String status = 'Status: ';
  static const String inStock = 'in stock';
  static const String outOfStock = 'out of stock';
  static const String taxNote = 'All prices include tax';
  static const String description = 'Description:';
  static const String egp = 'EGP';
  static const String loginSuccess = 'Login Successful';
  static const String passwordUpdatedSuccessfully =
      'Password Updated Successfully!';
  static const String failedToUpdatePassword = 'Failed To Update Password!';
  static const String resetPassword = 'Reset Password';
  static const String update = 'Update';
  static const String newPasswordSameAsOld =
      'New password must be different from current password';
  static const String pleaseConfirmYourNewPassword =
      'Please confirm your new password';

  static const String pleaseEnterYourCurrentPassword =
      'Please enter your current password';
  static const String pleaseEnterYourNewPassword =
      'Please enter your new password';

  static const String orderPlacedSuccessfully = 'Order placed successfully';
  static const String deliveryTime = 'Delivery Time';
  static const String schedule = 'Schedule';
  static const String instant = 'Instant';
  static const String arriveBy = 'Arrive By ';
  static const String checkout = 'Checkout';
  static const String deliveryAddress = 'Delivery Address';
  static const String addNew = 'Add new';
  static const String paymentMethod = 'Payment Method';
  static const String cashOnDelivery = 'Cash on Delivery';
  static const String creditCard = 'Credit Card';
  static const String payment = 'Payment';
  static const String credit = 'credit';
  static const String cash = 'cash';
  static const String paymentUrlNotFound = 'Payment URL not found';
  static const String name = 'Name';
  static const String enterName = 'Enter the name';
  static const String itIsAGift = 'It is a Gift';
  static const String enterGiftDetails = 'Enter gift details';
  static const String selectDeliveryAddress =
      'Please select a delivery address';
  static const String enterRecipientName = 'Enter recipient\'s name';
  static const String enterRecipientphone = 'Enter recipient\'s phone number';

  //------------------- CHECKOUT PRICING -------------------//
  static const String subtotal = 'Subtotal';
  static const String deliveryFee = 'Delivery Fee';
  static const String total = 'Total';
  static const String placeOrder = 'Place Order';
  static const double deliveryFeeAmount = 10.0;

  //------------------- HOME PAGE -------------------//
  static const String bestSeller = 'Best seller';
  static const String bestSellerSubTitle =
      'Bloom with our exquisite best sellers';
  static const String noProductsAvailable = 'No products available';
  static const String retry = 'Retry';
  static const String deliverTo = 'Deliver to';
  static const String search = 'Search';
  static const String flowery = 'Flowery';
  static const String viewAll = 'View All';
  static const String flower = 'Flower';
  //-------------------------- Common --------------------------//
  static String get loading => 'common.loading'.tr();

  static String get retry => 'common.retry'.tr();

  static String get cancel => 'common.cancel'.tr();

  static String get confirm => 'common.confirm'.tr();

  static String get close => 'common.close'.tr();

  static String get update => 'common.update'.tr();

  static String get delete => 'common.delete'.tr();

  static String get search => 'common.search'.tr();

  static String get viewAll => 'common.viewAll'.tr();

  static String get status => 'common.status'.tr();

  static String get egp => 'common.egp'.tr();

  static String get currencySign => 'common.currencySign'.tr();

  static String get items => 'common.items'.tr();

  //-------------------------- Auth --------------------------//
  static String get login => 'auth.login'.tr();

  static String get signUp => 'auth.signUp'.tr();

  static String get logout => 'auth.logout'.tr();

  static String get confirmLogout => 'auth.confirmLogout'.tr();

  static String get firstName => 'auth.firstName'.tr();

  static String get lastName => 'auth.lastName'.tr();

  static String get email => 'auth.email'.tr();

  static String get password => 'auth.password'.tr();

  static String get confirmPassword => 'auth.confirmPassword'.tr();

  static String get phoneNumber => 'auth.phoneNumber'.tr();

  static String get gender => 'auth.gender'.tr();

  static String get female => 'auth.female'.tr();

  static String get male => 'auth.male'.tr();

  // Auth Hints
  static String get enterFirstName => 'auth.hints.enterFirstName'.tr();

  static String get enterLastName => 'auth.hints.enterLastName'.tr();

  static String get enterEmail => 'auth.hints.enterEmail'.tr();

  static String get enterPassword => 'auth.hints.enterPassword'.tr();

  static String get enterConfirmPassword =>
      'auth.hints.enterConfirmPassword'.tr();

  static String get enterPhoneNumber => 'auth.hints.enterPhoneNumber'.tr();

  //-------------------------- Auth Forget Password --------------------------//
  static String get forgetPasswordHeader => 'auth.forgetPassword.header'.tr();

  static String get forgetPasswordTitle => 'auth.forgetPassword.title'.tr();

  static String get emailVerificationHeader =>
      'auth.forgetPassword.emailVerificationHeader'.tr();

  static String get emailVerificationTitle =>
      'auth.forgetPassword.emailVerificationTitle'.tr();

  static String get resetPasswordHeader =>
      'auth.forgetPassword.resetPasswordHeader'.tr();

  static String get resetPasswordTitle =>
      'auth.forgetPassword.resetPasswordTitle'.tr();

  static String get emailLabel => 'auth.forgetPassword.emailLabel'.tr();

  static String get emailHint => 'auth.forgetPassword.emailHint'.tr();

  static String get newPasswordLabel =>
      'auth.forgetPassword.newPasswordLabel'.tr();

  static String get newPasswordHint =>
      'auth.forgetPassword.newPasswordHint'.tr();

  static String get confirmPasswordLabel =>
      'auth.forgetPassword.confirmPasswordLabel'.tr();

  static String get otpResentSuccess =>
      'auth.forgetPassword.otpResentSuccess'.tr();

  static String get currentPassword =>
      'auth.forgetPassword.currentPassword'.tr();

  static String get newPassword => 'auth.forgetPassword.newPassword'.tr();

  // Auth Messages
  static String get failedToRegister => 'auth.messages.failedToRegister'.tr();

  static String get creatingAccountAgreement =>
      'auth.messages.creatingAccountAgreement'.tr();

  static String get termsAndConditions =>
      'auth.messages.termsAndConditions'.tr();

  static String get alreadyHaveAccount =>
      'auth.messages.alreadyHaveAccount'.tr();

  static String get invalidPhoneNumber =>
      'auth.messages.invalidPhoneNumber'.tr();

  static String get accountCreatedSuccessfully =>
      'auth.messages.accountCreatedSuccessfully'.tr();

  static String get loginSuccess => 'auth.messages.loginSuccess'.tr();

  static String get passwordUpdatedSuccessfully =>
      'auth.messages.passwordUpdatedSuccessfully'.tr();

  static String get failedToUpdatePassword =>
      'auth.messages.failedToUpdatePassword'.tr();

  static String get newPasswordSameAsOld =>
      'auth.messages.newPasswordSameAsOld'.tr();

  static String get pleaseConfirmYourNewPassword =>
      'auth.messages.pleaseConfirmYourNewPassword'.tr();

  static String get pleaseEnterYourCurrentPassword =>
      'auth.messages.pleaseEnterYourCurrentPassword'.tr();

  static String get pleaseEnterYourNewPassword =>
      'auth.messages.pleaseEnterYourNewPassword'.tr();

  static String get emailFocusError => 'auth.messages.emailFocusError'.tr();

  static String get passwordsDoNotMatch =>
      'auth.messages.passwordsDoNotMatch'.tr();

  static String get dontHaveAccount => 'auth.messages.dontHaveAccount'.tr();

  static String get rememberMe => 'auth.messages.rememberMe'.tr();

  // Auth Guest
  static String get guestUser => 'auth.guest.guestUser'.tr();

  static String get continueAsGuest => 'auth.guest.continueAsGuest'.tr();

  static String get guestUserProfile => 'auth.guest.guestUserProfile'.tr();

  //-------------------------- HOME --------------------------//
  static String get home => 'home.title'.tr();

  static String get categories => 'home.categories'.tr();

  static String get noCategoriesAvailable => 'home.noCategoriesAvailable'.tr();

  static String get bestSeller => 'home.bestSeller'.tr();

  static String get bestSellerSubTitle => 'home.bestSellerSubTitle'.tr();

  static String get noProductsAvailable => 'home.noProductsAvailable'.tr();

  static String get deliverTo => 'home.deliverTo'.tr();

  static String get flowery => 'home.flowery'.tr();

  static String get flower => 'home.flower'.tr();

  static const String defaultImage =
      'https://flower.elevateegy.com/uploads/66c36d5d-c067-46d9-b339-d81be57e0149-image_one.pngs';

  //-------------------------- Profile --------------------------//
  static const String defaultAvatarUrl =
      'https://flower.elevateegy.com/uploads/default-profile.png';
  static const String englishProfileState = 'English';
  static const String arabicProfileState = 'Arabic';

  static String get profile => 'profile.title'.tr();

  static String get notification => 'profile.notification'.tr();

  static String get chooseLanguage => 'profile.chooseLanguage'.tr();

  static String get english => 'profile.english'.tr();

  static String get arabic => 'profile.arabic'.tr();

  static String get language => 'profile.language'.tr();

  static String get termsAndConditionsPolicy =>
      'profile.termsAndConditionsPolicy'.tr();

  static String get aboutUsPolicy => 'profile.aboutUsPolicy'.tr();

  static String get myOrders => 'profile.myOrders'.tr();

  static String get savedAddresses => 'profile.savedAddresses'.tr();

  static String get termsAppBarTitleEn => 'profile.termsAppBarTitle'.tr();

  static String get termsAppBarTitleAr => 'profile.termsAppBarTitle'.tr();

  static String get appInfoAppBarTitleEn => 'profile.appInfoAppBarTitle'.tr();

  static String get appInfoAppBarTitleAr => 'profile.appInfoAppBarTitle'.tr();

  static String get noTermsDataAvailable => 'profile.noTermsDataAvailable'.tr();

  static String get switchToArabic => 'profile.switchToArabic'.tr();

  static String get switchToEnglish => 'profile.switchToEnglish'.tr();

  ///-------------------------- CART --------------------------//
  static String get cart => 'cart.title'.tr();

  static String get addToCart => 'cart.addToCart'.tr();

  static String get inStock => 'cart.inStock'.tr();

  static String get outOfStock => 'cart.outOfStock'.tr();

  static String get taxNote => 'cart.taxNote'.tr();

  static String get description => 'cart.description'.tr();

  static String get cartClearedSuccessfully =>
      'cart.cartClearedSuccessfully'.tr();

  static String get cartError => 'cart.cartError'.tr();

  static String get cartErrorMessage => 'cart.cartErrorMessage'.tr();

  static String get emptyCart => 'cart.emptyCart'.tr();

  static String get clearCart => 'cart.clearCart'.tr();

  static String get clearCartConfirmation => 'cart.clearCartConfirmation'.tr();

  static String get deleteThisItem => 'cart.deleteThisItem'.tr();

  static String get checkout => 'cart.checkout'.tr();

  static String get subTotal => 'cart.subTotal'.tr();

  static String get deliveryFee => 'cart.deliveryFee'.tr();

  static String get total => 'cart.total'.tr();

  // Occasion
  static String get occasion => 'occasion.title'.tr();

  static String get bloomExquisiteBestSellers =>
      'occasion.bloomExquisiteBestSellers'.tr();

  static String get noOccasionsAvailable =>
      'occasion.noOccasionsAvailable'.tr();

  //-------------------------- Technical Keys --------------------------//
  static const String enLangKey = 'en';

  static const String arLangKey = 'ar';

  static String get id => 'id';

  static String get percentageSign => '%';

  static String get forgetPasswordHeadLine => 'auth.forgetPassword.header'.tr();

  static String get confirmBtn => 'common.confirm'.tr();

  static String get egy => 'common.egp'.tr();
}
