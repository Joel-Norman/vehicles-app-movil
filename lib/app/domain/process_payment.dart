class PaymentInfo {
  String? redirect;
  String? key;
  String? amount;
  String? currency;
  String? billToFirstName;
  String? billToLastName;
  String? billToAddress;
  String? billToAddress2;
  String? billToCity;
  String? billToState;
  String? billToZipPostCode;
  String? billToCountry;
  String? billToTelephone;
  String? billToEmail;
  String? orderNumber;
  String? capture;
  String? subscription;
  String? platform;

  PaymentInfo({
    this.redirect,
    this.key,
    this.amount,
    this.currency,
    this.billToFirstName,
    this.billToLastName,
    this.billToAddress,
    this.billToAddress2,
    this.billToCity,
    this.billToState,
    this.billToZipPostCode,
    this.billToCountry,
    this.billToTelephone,
    this.billToEmail,
    this.orderNumber,
    this.capture,
    this.subscription,
    this.platform,
  });

  // Método para convertir un JSON a un objeto PaymentInfo
  factory PaymentInfo.fromJson(Map<String, dynamic> json) {
    return PaymentInfo(
      redirect: json['redirect'],
      key: json['key'],
      amount: json['amount'],
      currency: json['currency'],
      billToFirstName: json['billToFirstName'],
      billToLastName: json['billToLastName'],
      billToAddress: json['billToAddress'],
      billToAddress2: json['billToAddress2'],
      billToCity: json['billToCity'],
      billToState: json['billToState'],
      billToZipPostCode: json['billToZipPostCode'],
      billToCountry: json['billToCountry'],
      billToTelephone: json['billToTelephone'],
      billToEmail: json['billToEmail'],
      orderNumber: json['orderNumber'],
      capture: json['capture'],
      subscription: json['subscription'],
      platform: json['platform'],
    );
  }

  // Método para convertir el objeto PaymentInfo a JSON
  Map<String, dynamic> toJson() {
    return {
      'redirect': redirect,
      'key': key,
      'amount': amount,
      'currency': currency,
      'billToFirstName': billToFirstName,
      'billToLastName': billToLastName,
      'billToAddress': billToAddress,
      'billToAddress2': billToAddress2,
      'billToCity': billToCity,
      'billToState': billToState,
      'billToZipPostCode': billToZipPostCode,
      'billToCountry': billToCountry,
      'billToTelephone': billToTelephone,
      'billToEmail': billToEmail,
      'orderNumber': orderNumber,
      'capture': capture,
      'subscription': subscription,
      'platform': platform,
    };
  }
}