
import 'package:firedart/generated/google/protobuf/timestamp.pb.dart';

class ViolationInfor{
  String violation;
  String typeTraffic;
  String imageViolationLinkApi;
  String imageLicenseplateViolationLinkApi;
  String timeViolation;
  String videoViolationApi;
  String licenseplate;
  String localCamera;
  String idOnFirebase;
  ViolationInfor(
      this.violation,
      this.typeTraffic,
      this.imageViolationLinkApi,
      this.imageLicenseplateViolationLinkApi,
      this.timeViolation,
      this.videoViolationApi,
      this.licenseplate,
      this.localCamera,
      this.idOnFirebase
      );


}
