import 'dart:convert';

class FortRequest {
  FortRequest({
    required this.sdkToken,
    this.merchantReference,
    this.language = 'en',
    required this.amount,
    required this.customerEmail,
    this.currency = 'SAR',
    this.merchantExtra,
    this.merchantExtra1,
    this.paymentOption,
  }) : command = 'PURCHASE';

  /// An SDK Token to enable using the Amazon Payment Services Mobile SDK.
  ///
  final String sdkToken;

  /// The Merchant’s unique order number.
  ///
  final String? merchantReference;

  /// The checkout page and messages language.
  /// By default language: [en].
  ///
  final String language;

  /// Request Command.
  ///
  final String command;

  /// The transaction’s amount.
  /// Each currency has predefined allowed decimal points that should be taken into consideration when sending the amount.
  ///
  final num amount;

  /// The customer’s email. Example: customer1@domain.com
  ///
  final String customerEmail;

  /// The currency of the transaction’s amount in ISO code 3. Example: AED, USD, EUR, GBP.
  /// By Default currency : [USD].
  ///
  final String currency;

  final String merchantExtra;

  final String merchantExtra1;

  final String? paymentOption;


  Map<String, dynamic> toFortRequest() {
    return <String, dynamic>{
      'sdkToken': sdkToken,
      'merchantRef': '${DateTime.now().millisecondsSinceEpoch}',
      'lang': language,
      'amount': amount.toString(),
      'email': customerEmail,
      'currency': currency,
      "merchant_extra": merchantExtra,
      "merchant_extra1": merchantExtra1,
      "payment_option": paymentOption
    };
  }

  FortRequest copyWith({
    String? sdkToken,
    String? merchantReference,
    String? language,
    num? amount,
    String? customerEmail,
    String? currency,
    String? merchantExtra,
    String? merchantExtra1,
    String? paymentOption,
  }) {
    return FortRequest(
      sdkToken: sdkToken ?? this.sdkToken,
      merchantReference: merchantReference ?? this.merchantReference,
      language: language ?? this.language,
      amount: amount ?? this.amount,
      customerEmail: customerEmail ?? this.customerEmail,
      currency: currency ?? this.currency,
      merchantExtra: merchantExtra ?? this.merchantExtra,
      merchantExtra1: merchantExtra1 ?? this.merchantExtra1,
      paymentOption: paymentOption ?? this.paymentOption,
    );
  }

  @override
  String toString() {
    return jsonEncode(toFortRequest());
  }
}
