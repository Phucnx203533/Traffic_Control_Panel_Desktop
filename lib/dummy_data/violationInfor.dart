

class Violation {
  final String violation;
  final String licenseplate;
  final DateTime timeViolation;
  final String cameraIdDetectViolation;
  final String nameImageViolation;
  final String nameImageLicenseplateViolation;
  final String nameVideoViolation;
  final String typeTraffic;


  Violation(
      this.violation,
      this.licenseplate,
      this.timeViolation,
      this.cameraIdDetectViolation,
      this.nameImageViolation,
      this.nameImageLicenseplateViolation,
      this.nameVideoViolation,
      this.typeTraffic);

  factory Violation.fromJson(Map<String, dynamic> json) {
    return Violation(
      json['violation'],
      json['licenseplate'],
      DateTime.parse(json['timeViolation']),
      json['cameraIdDetectViolation'],
      json['nameImageViolation'],
      json['nameImageLicenseplateViolation'],
      json['nameVideoViolation'],
      json['typeTraffic'],
    );
  }
}
