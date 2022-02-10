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
  String? refreshToken;
  String? refreshTokenExpiration;
  int? userType;
  List<Claims>? claims;

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
        this.refreshToken,
        this.refreshTokenExpiration,
        this.userType,
        this.claims});

  CurrentUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    appUserId = json['appUserId'];
    fullName = json['fullName'];
    is2faRequired = json['is2faRequired'];
    isAuthenticated = json['isAuthenticated'];
    isPhoneVerified = json['isPhoneVerified'];
    isEmailVerified = json['isEmailVerified'];
    loginCount = json['loginCount'];
    bearerToken = json['bearerToken'];
    expiration = json['expiration'];
    refreshToken = json['refreshToken'];
    refreshTokenExpiration = json['refreshTokenExpiration'];
    userType = json['userType'];
    if (json['claims'] != null) {
      claims = <Claims>[];
      json['claims'].forEach((v) {
        claims!.add(new Claims.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['appUserId'] = this.appUserId;
    data['fullName'] = this.fullName;
    data['is2faRequired'] = this.is2faRequired;
    data['isAuthenticated'] = this.isAuthenticated;
    data['isPhoneVerified'] = this.isPhoneVerified;
    data['isEmailVerified'] = this.isEmailVerified;
    data['loginCount'] = this.loginCount;
    data['bearerToken'] = this.bearerToken;
    data['expiration'] = this.expiration;
    data['refreshToken'] = this.refreshToken;
    data['refreshTokenExpiration'] = this.refreshTokenExpiration;
    data['userType'] = this.userType;
    if (this.claims != null) {
      data['claims'] = this.claims!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Claims {
  String? claimType;
  String? claimValue;

  Claims({this.claimType, this.claimValue});

  Claims.fromJson(Map<String, dynamic> json) {
    claimType = json['claimType'];
    claimValue = json['claimValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['claimType'] = this.claimType;
    data['claimValue'] = this.claimValue;
    return data;
  }
}