// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentUser _$CurrentUserFromJson(Map<String, dynamic> json) => CurrentUser(
      id: json['id'] as int?,
      userName: json['userName'] as String?,
      appUserId: json['appUserId'] as String?,
      fullName: json['fullName'] as String?,
      is2faRequired: json['is2faRequired'] as bool?,
      isAuthenticated: json['isAuthenticated'] as bool?,
      isPhoneVerified: json['isPhoneVerified'] as bool?,
      isEmailVerified: json['isEmailVerified'] as bool?,
      loginCount: json['loginCount'] as int?,
      bearerToken: json['bearerToken'] as String?,
      expiration: json['expiration'] as String?,
      userType: json['userType'] as int?,
      claims: (json['claims'] as List<dynamic>)
          .map((e) => Claims.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CurrentUserToJson(CurrentUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'appUserId': instance.appUserId,
      'fullName': instance.fullName,
      'is2faRequired': instance.is2faRequired,
      'isAuthenticated': instance.isAuthenticated,
      'isPhoneVerified': instance.isPhoneVerified,
      'isEmailVerified': instance.isEmailVerified,
      'loginCount': instance.loginCount,
      'bearerToken': instance.bearerToken,
      'expiration': instance.expiration,
      'userType': instance.userType,
      'claims': instance.claims,
    };

Claims _$ClaimsFromJson(Map<String, dynamic> json) => Claims(
      claimType: json['claimType'] as String?,
      claimValue: json['claimValue'] as String?,
    );

Map<String, dynamic> _$ClaimsToJson(Claims instance) => <String, dynamic>{
      'claimType': instance.claimType,
      'claimValue': instance.claimValue,
    };
