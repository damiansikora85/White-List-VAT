class Subject {
  String name = "";
  String nip = "";
  String statusVat = "";
  String regon = "";
  String pesel = "";
  String krs = "";
  String residenceAddress = "";
  String workingAddress = "";
  //reprezentatives;
  //authorizedClerks;
  //partners;
  DateTime registrationLegalDate = DateTime.fromMicrosecondsSinceEpoch(0);
  DateTime registrationDenialDate = DateTime.fromMicrosecondsSinceEpoch(0);
  String registrationDenialBasis = "";
  DateTime restorationDate = DateTime.fromMicrosecondsSinceEpoch(0);
  String restorationBasis = "";
  DateTime removalDate = DateTime.fromMicrosecondsSinceEpoch(0);
  String removalBasis = "";
  List<String> accounts = List<String>.empty(growable: true);
  bool hasVirtualAccounts = false;

  Subject();

  factory Subject.fromJson(Map<String, dynamic> json) {
    var subject = new Subject();
    if (json['name'] != null) {
      subject.name = json['name'];
    }
    if (json['nip'] != null) {
      subject.nip = json['nip'];
    }
    if (json['statusVat'] != null) {
      subject.statusVat = json['statusVat'];
    }
    if (json['krs'] != null) {
      subject.krs = json['krs'];
    }
    if (json['regon'] != null) {
      subject.regon = json['regon'];
    }
    if (json['pesel'] != null) {
      subject.pesel = json['pesel'];
    }
    if (json['residenceAddress'] != null) {
      subject.residenceAddress = json['residenceAddress'];
    }
    if (json['workingAddress'] != null) {
      subject.workingAddress = json['workingAddress'];
    }
    if (json['registrationLegalDate'] != null) {
      subject.registrationLegalDate =
          DateTime.parse(json['registrationLegalDate']);
    }
    if (json['registrationDenialDate'] != null) {
      subject.registrationDenialDate =
          DateTime.parse(json['registrationDenialDate']);
    }
    if (json['registrationDenialBasis'] != null) {
      subject.registrationDenialBasis = json['registrationDenialBasis'];
    }
    if (json['restorationDate'] != null) {
      subject.restorationDate = DateTime.parse(json['restorationDate']);
    }
    if (json['restorationBasis'] != null) {
      subject.restorationBasis = json['restorationBasis'];
    }
    if (json['removalDate'] != null) {
      subject.removalDate = DateTime.parse(json['removalDate']);
    }
    if (json['removalBasis'] != null) {
      subject.removalBasis = json['removalBasis'];
    }
    if (json['hasVirtualAccounts'] != null) {
      subject.hasVirtualAccounts = json['hasVirtualAccounts'];
    }
    if (json['accountNumbers'] != null) {
      subject.accounts = (json['accountNumbers'] as List).cast<String>();
    }

    return subject;
  }
}
