// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Settings`
  String get setting {
    return Intl.message(
      'Settings',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `Languages`
  String get language {
    return Intl.message(
      'Languages',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Personal Information`
  String get personal_info {
    return Intl.message(
      'Personal Information',
      name: 'personal_info',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get logout {
    return Intl.message(
      'Log out',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message(
      'Version',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get system {
    return Intl.message(
      'System',
      name: 'system',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Khmer`
  String get khmer {
    return Intl.message(
      'Khmer',
      name: 'khmer',
      desc: '',
      args: [],
    );
  }

  /// `Chinese`
  String get chinese {
    return Intl.message(
      'Chinese',
      name: 'chinese',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get btn_yes {
    return Intl.message(
      'Yes',
      name: 'btn_yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get btn_no {
    return Intl.message(
      'No',
      name: 'btn_no',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to logout?`
  String get msg_confirm_logout {
    return Intl.message(
      'Do you want to logout?',
      name: 'msg_confirm_logout',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Signup`
  String get register {
    return Intl.message(
      'Signup',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Change Profile Photo`
  String get change_profile_photo {
    return Intl.message(
      'Change Profile Photo',
      name: 'change_profile_photo',
      desc: '',
      args: [],
    );
  }

  /// `About us`
  String get about_us {
    return Intl.message(
      'About us',
      name: 'about_us',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get order {
    return Intl.message(
      'Order',
      name: 'order',
      desc: '',
      args: [],
    );
  }

  /// `My Cart`
  String get my_cart {
    return Intl.message(
      'My Cart',
      name: 'my_cart',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get change_password {
    return Intl.message(
      'Change Password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Old`
  String get old {
    return Intl.message(
      'Old',
      name: 'old',
      desc: '',
      args: [],
    );
  }

  /// `New`
  String get new_ {
    return Intl.message(
      'New',
      name: 'new_',
      desc: '',
      args: [],
    );
  }

  /// ` `
  String get spacing {
    return Intl.message(
      ' ',
      name: 'spacing',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phone_number {
    return Intl.message(
      'Phone Number',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Favorite`
  String get favorite {
    return Intl.message(
      'Favorite',
      name: 'favorite',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Cinema`
  String get cinema {
    return Intl.message(
      'Cinema',
      name: 'cinema',
      desc: '',
      args: [],
    );
  }

  /// `Offers`
  String get offer {
    return Intl.message(
      'Offers',
      name: 'offer',
      desc: '',
      args: [],
    );
  }

  /// `F&B`
  String get fb {
    return Intl.message(
      'F&B',
      name: 'fb',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get more {
    return Intl.message(
      'More',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `Hello`
  String get hello {
    return Intl.message(
      'Hello',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Product`
  String get product {
    return Intl.message(
      'Product',
      name: 'product',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get help {
    return Intl.message(
      'Help',
      name: 'help',
      desc: '',
      args: [],
    );
  }

  /// `General`
  String get general {
    return Intl.message(
      'General',
      name: 'general',
      desc: '',
      args: [],
    );
  }

  /// `Delivery`
  String get delivery {
    return Intl.message(
      'Delivery',
      name: 'delivery',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Contact us`
  String get contact_us {
    return Intl.message(
      'Contact us',
      name: 'contact_us',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacy_policy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `News & Activity`
  String get news_activity {
    return Intl.message(
      'News & Activity',
      name: 'news_activity',
      desc: '',
      args: [],
    );
  }

  /// `Term & Conditions`
  String get term_condition {
    return Intl.message(
      'Term & Conditions',
      name: 'term_condition',
      desc: '',
      args: [],
    );
  }

  /// `What's new?`
  String get what_new {
    return Intl.message(
      'What\'s new?',
      name: 'what_new',
      desc: '',
      args: [],
    );
  }

  /// `Learn More`
  String get learn_more {
    return Intl.message(
      'Learn More',
      name: 'learn_more',
      desc: '',
      args: [],
    );
  }

  /// `Legend Membership`
  String get lengend_membership {
    return Intl.message(
      'Legend Membership',
      name: 'lengend_membership',
      desc: '',
      args: [],
    );
  }

  /// `Getting many benifit from our membership card.Take one now at your nearby Legend Cinema!`
  String get dis_legend_membership {
    return Intl.message(
      'Getting many benifit from our membership card.Take one now at your nearby Legend Cinema!',
      name: 'dis_legend_membership',
      desc: '',
      args: [],
    );
  }

  /// `What's we offer`
  String get what_we_offer {
    return Intl.message(
      'What\'s we offer',
      name: 'what_we_offer',
      desc: '',
      args: [],
    );
  }

  /// `Premium Benifits`
  String get premium_benifit {
    return Intl.message(
      'Premium Benifits',
      name: 'premium_benifit',
      desc: '',
      args: [],
    );
  }

  /// `Choose Cinema`
  String get choose_cinema {
    return Intl.message(
      'Choose Cinema',
      name: 'choose_cinema',
      desc: '',
      args: [],
    );
  }

  /// `Allow`
  String get allow {
    return Intl.message(
      'Allow',
      name: 'allow',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continues {
    return Intl.message(
      'Continue',
      name: 'continues',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Developer Mode`
  String get developer_mode {
    return Intl.message(
      'Developer Mode',
      name: 'developer_mode',
      desc: '',
      args: [],
    );
  }

  /// `Purchase`
  String get purchase {
    return Intl.message(
      'Purchase',
      name: 'purchase',
      desc: '',
      args: [],
    );
  }

  /// `Activate`
  String get activate {
    return Intl.message(
      'Activate',
      name: 'activate',
      desc: '',
      args: [],
    );
  }

  /// `Buy Ticket`
  String get buy_ticket {
    return Intl.message(
      'Buy Ticket',
      name: 'buy_ticket',
      desc: '',
      args: [],
    );
  }

  /// `Now Showing`
  String get now_showing {
    return Intl.message(
      'Now Showing',
      name: 'now_showing',
      desc: '',
      args: [],
    );
  }

  /// `Coming Soon`
  String get coming_soon {
    return Intl.message(
      'Coming Soon',
      name: 'coming_soon',
      desc: '',
      args: [],
    );
  }

  /// `Promotions`
  String get promotion {
    return Intl.message(
      'Promotions',
      name: 'promotion',
      desc: '',
      args: [],
    );
  }

  /// `See all`
  String get see_all {
    return Intl.message(
      'See all',
      name: 'see_all',
      desc: '',
      args: [],
    );
  }

  /// `All Cinemas`
  String get all_cinema {
    return Intl.message(
      'All Cinemas',
      name: 'all_cinema',
      desc: '',
      args: [],
    );
  }

  /// `Search cinema...`
  String get search_cinema {
    return Intl.message(
      'Search cinema...',
      name: 'search_cinema',
      desc: '',
      args: [],
    );
  }

  /// `Contact info`
  String get contact_info {
    return Intl.message(
      'Contact info',
      name: 'contact_info',
      desc: '',
      args: [],
    );
  }

  /// `Advertising & Partnership`
  String get advertising_partnership {
    return Intl.message(
      'Advertising & Partnership',
      name: 'advertising_partnership',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Upcoming`
  String get upcoming {
    return Intl.message(
      'Upcoming',
      name: 'upcoming',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Explore More`
  String get explore_more {
    return Intl.message(
      'Explore More',
      name: 'explore_more',
      desc: '',
      args: [],
    );
  }

  /// `Summary`
  String get summary {
    return Intl.message(
      'Summary',
      name: 'summary',
      desc: '',
      args: [],
    );
  }

  /// `Order Summary`
  String get order_summary {
    return Intl.message(
      'Order Summary',
      name: 'order_summary',
      desc: '',
      args: [],
    );
  }

  /// `Total :`
  String get total {
    return Intl.message(
      'Total :',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Check Out`
  String get checkout {
    return Intl.message(
      'Check Out',
      name: 'checkout',
      desc: '',
      args: [],
    );
  }

  /// `Gust Information`
  String get gust_info {
    return Intl.message(
      'Gust Information',
      name: 'gust_info',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get payment_method {
    return Intl.message(
      'Payment Method',
      name: 'payment_method',
      desc: '',
      args: [],
    );
  }

  /// `Set New Profile Picture`
  String get set_new_profile {
    return Intl.message(
      'Set New Profile Picture',
      name: 'set_new_profile',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get other {
    return Intl.message(
      'Other',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `From Camera`
  String get from_camera {
    return Intl.message(
      'From Camera',
      name: 'from_camera',
      desc: '',
      args: [],
    );
  }

  /// `From Gallery`
  String get from_gallery {
    return Intl.message(
      'From Gallery',
      name: 'from_gallery',
      desc: '',
      args: [],
    );
  }

  /// `Legend Member`
  String get legend_member {
    return Intl.message(
      'Legend Member',
      name: 'legend_member',
      desc: '',
      args: [],
    );
  }

  /// `Member Benifits`
  String get member_benifit {
    return Intl.message(
      'Member Benifits',
      name: 'member_benifit',
      desc: '',
      args: [],
    );
  }

  /// `Getting many benifit from our membership card. Take one now at your nearby Lengend Cinema!`
  String get txt_member_benifit {
    return Intl.message(
      'Getting many benifit from our membership card. Take one now at your nearby Lengend Cinema!',
      name: 'txt_member_benifit',
      desc: '',
      args: [],
    );
  }

  /// `5% Bonus on top up`
  String get bonus_5 {
    return Intl.message(
      '5% Bonus on top up',
      name: 'bonus_5',
      desc: '',
      args: [],
    );
  }

  /// `Discount 10% Ticket &\nConcession`
  String get bonus_10 {
    return Intl.message(
      'Discount 10% Ticket &\nConcession',
      name: 'bonus_10',
      desc: '',
      args: [],
    );
  }

  /// `Benifits`
  String get benifit {
    return Intl.message(
      'Benifits',
      name: 'benifit',
      desc: '',
      args: [],
    );
  }

  /// `Activate Card`
  String get activate_card {
    return Intl.message(
      'Activate Card',
      name: 'activate_card',
      desc: '',
      args: [],
    );
  }

  /// `Card Activate`
  String get card_activate {
    return Intl.message(
      'Card Activate',
      name: 'card_activate',
      desc: '',
      args: [],
    );
  }

  /// `Card Number`
  String get card_number {
    return Intl.message(
      'Card Number',
      name: 'card_number',
      desc: '',
      args: [],
    );
  }

  /// `Announcement`
  String get announcement {
    return Intl.message(
      'Announcement',
      name: 'announcement',
      desc: '',
      args: [],
    );
  }

  /// `Login Order to see notification`
  String get ms_notification {
    return Intl.message(
      'Login Order to see notification',
      name: 'ms_notification',
      desc: '',
      args: [],
    );
  }

  /// `No notification`
  String get no_notification {
    return Intl.message(
      'No notification',
      name: 'no_notification',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get details {
    return Intl.message(
      'Details',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `When to watch your favorite\nmovie at the nearby cinema?\nExplore now to see more cinema around you.`
  String get ms_footer {
    return Intl.message(
      'When to watch your favorite\nmovie at the nearby cinema?\nExplore now to see more cinema around you.',
      name: 'ms_footer',
      desc: '',
      args: [],
    );
  }

  /// `Opening Hour`
  String get opening_hour {
    return Intl.message(
      'Opening Hour',
      name: 'opening_hour',
      desc: '',
      args: [],
    );
  }

  /// `Number fo Hall`
  String get number_of_hall {
    return Intl.message(
      'Number fo Hall',
      name: 'number_of_hall',
      desc: '',
      args: [],
    );
  }

  /// `Release: `
  String get release {
    return Intl.message(
      'Release: ',
      name: 'release',
      desc: '',
      args: [],
    );
  }

  /// `Duration: `
  String get duration {
    return Intl.message(
      'Duration: ',
      name: 'duration',
      desc: '',
      args: [],
    );
  }

  /// `Classification: `
  String get classification {
    return Intl.message(
      'Classification: ',
      name: 'classification',
      desc: '',
      args: [],
    );
  }

  /// `Genre: `
  String get genre {
    return Intl.message(
      'Genre: ',
      name: 'genre',
      desc: '',
      args: [],
    );
  }

  /// `Description about the Movie`
  String get dis_movie {
    return Intl.message(
      'Description about the Movie',
      name: 'dis_movie',
      desc: '',
      args: [],
    );
  }

  /// `Discount 10% Concession`
  String get offer_dis_t1 {
    return Intl.message(
      'Discount 10% Concession',
      name: 'offer_dis_t1',
      desc: '',
      args: [],
    );
  }

  /// `Discount 10% Ticket`
  String get offer_dis_t2 {
    return Intl.message(
      'Discount 10% Ticket',
      name: 'offer_dis_t2',
      desc: '',
      args: [],
    );
  }

  /// `Buy 1 get 1 Every Tuesday`
  String get offer_dis_t3 {
    return Intl.message(
      'Buy 1 get 1 Every Tuesday',
      name: 'offer_dis_t3',
      desc: '',
      args: [],
    );
  }

  /// `10% discount on concession`
  String get offer_s1 {
    return Intl.message(
      '10% discount on concession',
      name: 'offer_s1',
      desc: '',
      args: [],
    );
  }

  /// `10% discount on ticket`
  String get offer_s2 {
    return Intl.message(
      '10% discount on ticket',
      name: 'offer_s2',
      desc: '',
      args: [],
    );
  }

  /// `Buy one get one tickets free!`
  String get offer_s3 {
    return Intl.message(
      'Buy one get one tickets free!',
      name: 'offer_s3',
      desc: '',
      args: [],
    );
  }

  /// `No movie were found, Please try other movie title`
  String get no_movie {
    return Intl.message(
      'No movie were found, Please try other movie title',
      name: 'no_movie',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email or phone number`
  String get ms_login {
    return Intl.message(
      'Enter your email or phone number',
      name: 'ms_login',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number to create new account`
  String get ms_register {
    return Intl.message(
      'Enter your phone number to create new account',
      name: 'ms_register',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get ms_valid_pass {
    return Intl.message(
      'Please enter your password',
      name: 'ms_valid_pass',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email`
  String get ms_valid_email {
    return Intl.message(
      'Please enter your email',
      name: 'ms_valid_email',
      desc: '',
      args: [],
    );
  }

  /// `Invalid phone number format`
  String get ms_valid_phone {
    return Intl.message(
      'Invalid phone number format',
      name: 'ms_valid_phone',
      desc: '',
      args: [],
    );
  }

  /// `Phone number is required`
  String get ms_phone_number_required {
    return Intl.message(
      'Phone number is required',
      name: 'ms_phone_number_required',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong!`
  String get ms_error {
    return Intl.message(
      'Something went wrong!',
      name: 'ms_error',
      desc: '',
      args: [],
    );
  }

  /// `Success!`
  String get ms_sucess {
    return Intl.message(
      'Success!',
      name: 'ms_sucess',
      desc: '',
      args: [],
    );
  }

  /// `Logging in...`
  String get login_process {
    return Intl.message(
      'Logging in...',
      name: 'login_process',
      desc: '',
      args: [],
    );
  }

  /// `You've created this account with `
  String get ms_create_account {
    return Intl.message(
      'You\'ve created this account with ',
      name: 'ms_create_account',
      desc: '',
      args: [],
    );
  }

  /// `Re-Enter Password`
  String get re_enter_password {
    return Intl.message(
      'Re-Enter Password',
      name: 're_enter_password',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Please select your gender`
  String get ms_select_gender {
    return Intl.message(
      'Please select your gender',
      name: 'ms_select_gender',
      desc: '',
      args: [],
    );
  }

  /// `Available...`
  String get available {
    return Intl.message(
      'Available...',
      name: 'available',
      desc: '',
      args: [],
    );
  }

  /// `Scan to pay with any baking app`
  String get scan_to_pay {
    return Intl.message(
      'Scan to pay with any baking app',
      name: 'scan_to_pay',
      desc: '',
      args: [],
    );
  }

  /// `Member points`
  String get member_point {
    return Intl.message(
      'Member points',
      name: 'member_point',
      desc: '',
      args: [],
    );
  }

  /// `Food & Beverage`
  String get food_b {
    return Intl.message(
      'Food & Beverage',
      name: 'food_b',
      desc: '',
      args: [],
    );
  }

  /// `No Data Found!`
  String get no_data {
    return Intl.message(
      'No Data Found!',
      name: 'no_data',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'km'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
