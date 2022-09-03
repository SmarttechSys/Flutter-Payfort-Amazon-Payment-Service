import 'dart:convert';

import 'package:amazon_payfort/src/enums/response_status.dart';

class PayfortResult {
  PayfortResult({
    this.responseCode,
    this.responseStatus,
    this.responseMessage,
    this.sdkToken,
    this.merchantReference,
    this.command,
    this.amount,
    this.customerEmail,
    this.currency,
    this.merchantExtra,
    this.merchantExtra1,
    this.paymentOption,
    this.authorizationCode,
    this.customerName,
    this.expiryDate,
    this.cardNumber,
    this.status,
  });

  /// Response Code carries the value of our system’s response. *The code consists of five digits,
  /// the first 2 digits represent the response status [https://paymentservices-reference.payfort.com/docs/api/build/index.html?java#statuses],
  /// and the last 3 digits represent the response messages [https://paymentservices-reference.payfort.com/docs/api/build/index.html?java#messages].
  ///
  String? responseCode;

  /// Transaction status : [success], [failure] and [canceled]
  ResponseStatus? responseStatus;

  /// The message description of the response code; it returns according to the request language..
  ///
  String? responseMessage;

  /// An SDK Token to enable using the Amazon Payment Services Mobile SDK.
  ///
  String? sdkToken;

  /// The Merchant’s unique order number.
  ///
  String? merchantReference;

  /// Command
  ///
  String? command;

  /// The transaction’s amount.
  /// Each currency has predefined allowed decimal points that should be taken into consideration when sending the amount.
  ///
  String? amount;

  /// The customer’s email.
  ///
  String? customerEmail;

  /// The currency of the transaction’s amount in ISO code 3.
  ///
  String? currency;

  String? merchantExtra;

  String? merchantExtra1;

  /// Payment option. [MASTERCARD], [VISA], [AMEX] etc...
  ///
  String? paymentOption;

  /// The authorization code returned from the 3rd party.
  ///
  String? authorizationCode;

  /// The customer’s name.
  ///
  String? customerName;

  /// The card’s expiry date.
  ///
  String? expiryDate;

  /// The masked credit card’s number. Only the [MEEZA] payment option takes 19 digits card number.
  ///
  String? cardNumber;

  /// A two-digit numeric value that indicates the status of the transaction.
  ///
  String? status;

  factory PayfortResult.fromMap(Map<String, dynamic> data) {
    return PayfortResult(
      responseCode: data['response_code'],
      responseStatus: ResponseStatus.values[data['response_status']],
      responseMessage: data['response_message'],
      sdkToken: data['sdkToken'],
      merchantReference: data['merchantRef'],
      command: data['command'],
      amount: data['amount'],
      customerEmail: data['email'],
      currency: data['currency'],
      merchantExtra: data['merchant_extra'],
      merchantExtra1: data['merchant_extra1'],
      paymentOption: data['payment_option'],
      authorizationCode: data['authorization_code'],
      customerName: data['customer_name'],
      expiryDate: data['expiry_date'],
      cardNumber: data['card_number'],
      status: data['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'response_code': responseCode,
      'response_status': responseStatus?.index,
      'response_message': responseMessage,
      'sdkToken': sdkToken,
      'merchantRef': merchantReference,
      'command': command,
      'amount': amount,
      'email': customerEmail,
      'currency': currency,
      "merchant_extra": merchantExtra,
      "merchant_extra1": merchantExtra1,
      'payment_option': paymentOption,
      'authorization_code': authorizationCode,
      'customer_name': customerName,
      'expiry_date': expiryDate,
      'card_number': cardNumber,
      'status': status,
    };
  }

  @override
  String toString() {
    return jsonEncode(toMap());
  }
}
