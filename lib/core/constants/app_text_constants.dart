import 'package:easy_localization/easy_localization.dart';

class AppTextConstants {
  AppTextConstants._();
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

  static String get appName => 'common.appName'.tr();

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

  static String get termsAppBarTitleEn => 'profile.termsAppBarTitle'.tr();

  static String get termsAppBarTitleAr => 'profile.termsAppBarTitle'.tr();

  static String get appInfoAppBarTitleEn => 'profile.appInfoAppBarTitle'.tr();

  static String get appInfoAppBarTitleAr => 'profile.appInfoAppBarTitle'.tr();

  static String get noTermsDataAvailable => 'profile.noTermsDataAvailable'.tr();

  static String get switchToArabic => 'profile.switchToArabic'.tr();

  static String get switchToEnglish => 'profile.switchToEnglish'.tr();

  ///-------------------------- Edit Profile --------------------------//
  static String get editProfile => 'editProfile.title'.tr();

  static String get change => 'editProfile.change'.tr();

  static String get uploadImage => 'editProfile.uploadImage'.tr();

  ///-------------------------- CART --------------------------//
  static String get cart => 'cart.title'.tr();

  static String get addToCart => 'cart.addToCart'.tr();

  static String get inStock => 'cart.inStock'.tr();

  static String get outOfStock => 'cart.outOfStock'.tr();

  static String get taxNote => 'cart.taxNote'.tr();

  static String get description => 'cart.description'.tr();

  static String get deliveryFee => 'cart.deliveryFee'.tr();

  static String get cartClearedSuccessfully =>
      'cart.cartClearedSuccessfully'.tr();

  static String get cartError => 'cart.cartError'.tr();

  static String get addToCartSuccess => 'cart.addToCartSuccess'.tr();

  static String get cartErrorMessage => 'cart.cartErrorMessage'.tr();

  static String get emptyCart => 'cart.emptyCart'.tr();

  static String get clearCart => 'cart.clearCart'.tr();

  static String get clearCartConfirmation => 'cart.clearCartConfirmation'.tr();

  static String get deleteThisItem => 'cart.deleteThisItem'.tr();

  static String get checkout => 'cart.checkout'.tr();

  static String get subTotal => 'cart.subTotal'.tr();

  static String get total => 'cart.total'.tr();

  static String get removeFromCart => 'cart.removeFromCart'.tr();

  // Occasion
  static String get occasion => 'occasion.title'.tr();

  static String get bloomExquisiteBestSellers =>
      'occasion.bloomExquisiteBestSellers'.tr();

  static String get noOccasionsAvailable =>
      'occasion.noOccasionsAvailable'.tr();

  ///-------------------------- CATEGORIES --------------------------//
  static String get sortBy => 'categories.sortBy'.tr();
  static String get lowesPrice => 'categories.lowesPrice'.tr();
  static String get highPrice => 'categories.highPrice'.tr();
  static String get newest => 'categories.newest'.tr();
  static String get oldest => 'categories.oldest'.tr();
  static String get discount => 'categories.discount'.tr();
  static String get filter => 'categories.filter'.tr();

  //-------------------------- Technical Keys --------------------------//
  static const String enLangKey = 'en';

  static const String arLangKey = 'ar';

  static String get id => 'id';

  static String get percentageSign => '%';

  static String get forgetPasswordHeadLine => 'auth.forgetPassword.header'.tr();

  static String get confirmBtn => 'common.confirm'.tr();

  static String get egy => 'common.egp'.tr();

  // Saved Addresses
  static String get addNewAddress => 'savedAddresses.addNewAddress'.tr();
  //-------------------------- CHECKOUT --------------------------//
  static String get orderPlacedSuccessfully =>
      'checkout.orderPlacedSuccessfully'.tr();
  static String get deliveryTime => 'checkout.deliveryTime'.tr();
  static String get schedule => 'checkout.schedule'.tr();
  static String get instant => 'checkout.instant'.tr();
  static String get arriveBy => 'checkout.arriveBy'.tr();
  static String get deliveryAddress => 'checkout.deliveryAddress'.tr();
  static String get addNew => 'checkout.addNew'.tr();
  static String get paymentMethod => 'checkout.paymentMethod'.tr();
  static String get cashOnDelivery => 'checkout.cashOnDelivery'.tr();
  static String get creditCard => 'checkout.creditCard'.tr();
  static String get payment => 'checkout.payment'.tr();
  static String get credit => 'checkout.credit'.tr();
  static String get cash => 'checkout.cash'.tr();
  static String get paymentUrlNotFound => 'checkout.paymentUrlNotFound'.tr();
  static String get name => 'checkout.name'.tr();
  static String get enterName => 'checkout.enterName'.tr();
  static String get itIsAGift => 'checkout.itIsAGift'.tr();
  static String get enterGiftDetails => 'checkout.enterGiftDetails'.tr();
  static String get selectDeliveryAddress =>
      'checkout.selectDeliveryAddress'.tr();
  static String get enterRecipientName => 'checkout.enterRecipientName'.tr();
  static String get enterRecipientphone => 'checkout.enterRecipientphone'.tr();
  static String get paymentCancelled => 'checkout.paymentCancelled'.tr();
  static String get subtotal => 'checkout.subtotal'.tr();
  static String get placeOrder => 'checkout.placeOrder'.tr();

  // Add Update Address
  static String get savedAddresses => 'addUpdateAddress.savedAddresses'.tr();

  static String get address => 'addUpdateAddress.address'.tr();

  static String get enterAddress => 'addUpdateAddress.enterAddress'.tr();

  static String get recipientName => 'addUpdateAddress.recipientName'.tr();

  static String get enterTheRecipientName =>
      'addUpdateAddress.enterTheRecipientName'.tr();

  static String get state => 'addUpdateAddress.state'.tr();

  static String get selectState => 'addUpdateAddress.selectState'.tr();

  static String get city => 'addUpdateAddress.city'.tr();

  static String get selectCity => 'addUpdateAddress.selectCity'.tr();

  static String get saveAddress => 'addUpdateAddress.saveAddress'.tr();

  static String get addressSavedSuccessfully =>
      'addUpdateAddress.addressSavedSuccessfully'.tr();
  static String get addressUpdatedSuccessfully =>
      'addUpdateAddress.addressUpdatedSuccessfully'.tr();
}
