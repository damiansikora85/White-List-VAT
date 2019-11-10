class VatError {
  String code;
  String message;

  VatError();

  factory VatError.fromJson(Map<String, Object> json)
  {
    var vatError = new VatError();
    if(json['code'] != null)
    {
      vatError.code = json['code'];
    }
    if(json['message'] != null)
    {
      vatError.message = json['message'];
    }
    return vatError;
  }
}