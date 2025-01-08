import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi')
  ];

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from;

  /// No description provided for @share_transaction.
  ///
  /// In en, this message translates to:
  /// **'Share Transaction'**
  String get share_transaction;

  /// No description provided for @no_note.
  ///
  /// In en, this message translates to:
  /// **'No Note'**
  String get no_note;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get note;

  /// No description provided for @transaction_detail.
  ///
  /// In en, this message translates to:
  /// **'Transaction Detail'**
  String get transaction_detail;

  /// No description provided for @shared.
  ///
  /// In en, this message translates to:
  /// **'Shared'**
  String get shared;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @transaction_details.
  ///
  /// In en, this message translates to:
  /// **'Transaction Details'**
  String get transaction_details;

  /// No description provided for @invalid_date.
  ///
  /// In en, this message translates to:
  /// **'Invalid Date'**
  String get invalid_date;

  /// No description provided for @others.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get others;

  /// No description provided for @transaction_history.
  ///
  /// In en, this message translates to:
  /// **'Transaction History'**
  String get transaction_history;

  /// No description provided for @no_transactions_yet.
  ///
  /// In en, this message translates to:
  /// **'No transactions yet'**
  String get no_transactions_yet;

  /// No description provided for @points.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get points;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @in_developing.
  ///
  /// In en, this message translates to:
  /// **'Under Development'**
  String get in_developing;

  /// No description provided for @transaction_overview.
  ///
  /// In en, this message translates to:
  /// **'Transaction Overview'**
  String get transaction_overview;

  /// No description provided for @withdrawals.
  ///
  /// In en, this message translates to:
  /// **'Withdrawals'**
  String get withdrawals;

  /// No description provided for @transfers.
  ///
  /// In en, this message translates to:
  /// **'Transfers'**
  String get transfers;

  /// No description provided for @top_ups.
  ///
  /// In en, this message translates to:
  /// **'Top-Ups'**
  String get top_ups;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @fee.
  ///
  /// In en, this message translates to:
  /// **'Fee'**
  String get fee;

  /// No description provided for @back_to_home.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get back_to_home;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @total_payment.
  ///
  /// In en, this message translates to:
  /// **'Total Payment'**
  String get total_payment;

  /// No description provided for @reference_number.
  ///
  /// In en, this message translates to:
  /// **'Reference Number'**
  String get reference_number;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @your_transaction_was_successful.
  ///
  /// In en, this message translates to:
  /// **'Your transaction was successful.'**
  String get your_transaction_was_successful;

  /// No description provided for @transfer_successful.
  ///
  /// In en, this message translates to:
  /// **'Transfer Successful'**
  String get transfer_successful;

  /// No description provided for @transfer_to_banks.
  ///
  /// In en, this message translates to:
  /// **'Transfer to Banks'**
  String get transfer_to_banks;

  /// No description provided for @search_bank_code.
  ///
  /// In en, this message translates to:
  /// **'Search Bank Code'**
  String get search_bank_code;

  /// No description provided for @all_banks.
  ///
  /// In en, this message translates to:
  /// **'All Banks'**
  String get all_banks;

  /// No description provided for @recipient_name.
  ///
  /// In en, this message translates to:
  /// **'Recipient Name'**
  String get recipient_name;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// No description provided for @select_bank_code.
  ///
  /// In en, this message translates to:
  /// **'Select Bank Code'**
  String get select_bank_code;

  /// No description provided for @bank_code.
  ///
  /// In en, this message translates to:
  /// **'Bank Code'**
  String get bank_code;

  /// No description provided for @transfer_to_bank.
  ///
  /// In en, this message translates to:
  /// **'Transfer to Bank'**
  String get transfer_to_bank;

  /// No description provided for @transfer.
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get transfer;

  /// No description provided for @to_friends.
  ///
  /// In en, this message translates to:
  /// **'To Friends'**
  String get to_friends;

  /// No description provided for @to_bank.
  ///
  /// In en, this message translates to:
  /// **'To Bank'**
  String get to_bank;

  /// No description provided for @latest_transfer.
  ///
  /// In en, this message translates to:
  /// **'Latest Transfer'**
  String get latest_transfer;

  /// No description provided for @transfer_to_friends.
  ///
  /// In en, this message translates to:
  /// **'Transfer to Friends'**
  String get transfer_to_friends;

  /// No description provided for @your_balance.
  ///
  /// In en, this message translates to:
  /// **'Your Balance'**
  String get your_balance;

  /// No description provided for @top_up.
  ///
  /// In en, this message translates to:
  /// **'Top Up'**
  String get top_up;

  /// No description provided for @phone_number.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone_number;

  /// No description provided for @input_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Enter Phone Number'**
  String get input_phone_number;

  /// No description provided for @notes_optional.
  ///
  /// In en, this message translates to:
  /// **'Notes (Optional)'**
  String get notes_optional;

  /// No description provided for @write_your_notes_here.
  ///
  /// In en, this message translates to:
  /// **'Write your notes here'**
  String get write_your_notes_here;

  /// No description provided for @set_amount.
  ///
  /// In en, this message translates to:
  /// **'Set Amount'**
  String get set_amount;

  /// No description provided for @proceed_to_transfer.
  ///
  /// In en, this message translates to:
  /// **'Proceed to Transfer'**
  String get proceed_to_transfer;

  /// No description provided for @top_up_amount.
  ///
  /// In en, this message translates to:
  /// **'Top-Up Amount'**
  String get top_up_amount;

  /// No description provided for @bank_transfer.
  ///
  /// In en, this message translates to:
  /// **'Bank Transfer'**
  String get bank_transfer;

  /// No description provided for @top_up_now.
  ///
  /// In en, this message translates to:
  /// **'Top-Up Now'**
  String get top_up_now;

  /// No description provided for @recent_top_ups.
  ///
  /// In en, this message translates to:
  /// **'Recent Top-Ups'**
  String get recent_top_ups;

  /// No description provided for @no_top_ups_yet.
  ///
  /// In en, this message translates to:
  /// **'No top-ups yet.'**
  String get no_top_ups_yet;

  /// No description provided for @top_up_successful.
  ///
  /// In en, this message translates to:
  /// **'Top-Up Successful!'**
  String get top_up_successful;

  /// No description provided for @has_been_added_to_your_balance.
  ///
  /// In en, this message translates to:
  /// **'has been added to your balance.'**
  String get has_been_added_to_your_balance;

  /// No description provided for @return_to_home.
  ///
  /// In en, this message translates to:
  /// **'Return to Home'**
  String get return_to_home;

  /// No description provided for @withdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get withdraw;

  /// No description provided for @withdrawal_amount.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal Amount'**
  String get withdrawal_amount;

  /// No description provided for @enter_custom_amount.
  ///
  /// In en, this message translates to:
  /// **'Enter Custom Amount'**
  String get enter_custom_amount;

  /// No description provided for @withdraw_now.
  ///
  /// In en, this message translates to:
  /// **'Withdraw Now'**
  String get withdraw_now;

  /// No description provided for @recent_withdrawals.
  ///
  /// In en, this message translates to:
  /// **'Recent Withdrawals'**
  String get recent_withdrawals;

  /// No description provided for @no_withdrawals_yet.
  ///
  /// In en, this message translates to:
  /// **'No withdrawals yet.'**
  String get no_withdrawals_yet;

  /// No description provided for @withdrawal_successful.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal Successful!'**
  String get withdrawal_successful;

  /// No description provided for @has_been_withdrawn.
  ///
  /// In en, this message translates to:
  /// **'has been withdrawn.'**
  String get has_been_withdrawn;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @select_language.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get select_language;

  /// No description provided for @dark_mode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get dark_mode;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'vi': return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
