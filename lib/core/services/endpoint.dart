class Url {
  static const String baseUrl = 'https://tradefarm-dev-api.herokuapp.com/v1/';
  static const String login = baseUrl + "users/token/";
  static const String register = baseUrl + "users/";
  static const String user = baseUrl + "users/me/";
  static const String kycs = baseUrl + "kycs/";
  static const String balance = "https://tradefarm-dev-api.herokuapp.com/v1/users/net_balance/?currency_code=USD";
  static const String otpVerification = baseUrl + "phone_numbers/verification/";
  static const String verifyPhoneNumber = baseUrl + "phone_numbers/";
  static const String transactionTokens = baseUrl + "transaction_tokens/";
  static const String transfers = baseUrl + "transfers/";
  static const String withdrawals = baseUrl + "withdrawals/";
  static const String deposits = baseUrl + "deposits/";
  static const String payments = baseUrl + "payments/";
    static const String confirmPayments = baseUrl + "payments/comfirm/";
        static const String deleteToken = baseUrl + "transaction_tokens/delete/";



}
