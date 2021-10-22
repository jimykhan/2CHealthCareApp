import 'package:json_annotation/json_annotation.dart';
part 'current_user.g.dart';
@JsonSerializable()
class CurrentUser {
  int? id;
  String? userName;
  String? appUserId;
  String? fullName;
  bool? is2faRequired;
  bool? isAuthenticated;
  bool? isPhoneVerified;
  bool? isEmailVerified;
  int? loginCount;
  String? bearerToken;
  String? expiration;
  int? userType;
  List<Claims> claims;

  CurrentUser(
      {this.id,
        this.userName,
        this.appUserId,
        this.fullName,
        this.is2faRequired,
        this.isAuthenticated,
        this.isPhoneVerified,
        this.isEmailVerified,
        this.loginCount,
        this.bearerToken,
        this.expiration,
        this.userType,
        required this.claims});
}

// part 'claim_g.dart';
@JsonSerializable()
class Claims {
  String? claimType;
  String? claimValue;

  Claims({this.claimType, this.claimValue});
}