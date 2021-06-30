class VatError {
  late String code;
  late String message;

  VatError();

  factory VatError.fromJson(Map<String, dynamic> json) {
    var vatError = new VatError();
    if (json['code'] != null) {
      vatError.code = json['code'];
    }
    if (json['message'] != null) {
      vatError.message = json['message'];
    }
    return vatError;
  }
}
