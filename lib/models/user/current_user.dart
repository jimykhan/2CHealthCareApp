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
  factory CurrentUser.fromJson(Map<String, dynamic> data) => _$CurrentUserFromJson(data);
  Map<String, dynamic> toJson() => _$CurrentUserToJson(this);
}

// part 'claim_g.dart';
@JsonSerializable()
class Claims {
  String? claimType;
  String? claimValue;

  Claims({this.claimType, this.claimValue});
  factory Claims.fromJson(Map<String, dynamic> data) => _$ClaimsFromJson(data);
  Map<String, dynamic> toJson() => _$ClaimsToJson(this);
}