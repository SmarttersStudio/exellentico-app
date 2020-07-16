///
///Created By Aurosmruti (aurosmruti@smarttersstudio.com) on 7/1/2020 12:12 PM
///



import 'dart:convert';

UserResponse userResponseFromJson(String str) => UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
    UserResponse({
        this.user,
        this.profile,
    });

    UserDatum user;
    Profile profile;

    factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        user: json["user"]!=null?  UserDatum.fromJson(json["user"]):null,
        profile: json.containsKey('profile')
            ? json["profile"]!=null?Profile.fromJson(json["profile"]):null
            : null,
      );

    Map<String, dynamic> toJson() => {
        "user": user!=null ? user.toJson() : null,
        "profile":profile!=null? profile.toJson() : null,
    };
}

class Profile {
    Profile({
        this.id,
        this.gender,
        this.dob,
        this.city,
        this.user,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    String id;
    int gender;
    DateTime dob;
    String city;
    String user;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["_id"]!=null ? json["_id"]:"",
        gender: json["gender"]!=null ? json["gender"]: 0 ,
        dob: json["dob"]!=null ? DateTime.parse(json["dob"]) : null,
        city: json["city"]!=null ? json["city"] : "",
        user: json["user"]!=null ? json["user"] : "",
        createdAt: json.containsKey('createdAt')? DateTime.parse(json["createdAt"]) : null,
        updatedAt: json.containsKey('updatedAt')? DateTime.parse(json["updatedAt"]) : null,
        v: json["__v"]!=null? json["__v"] : 0,
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "gender": gender,
        "dob": dob,
        "city": city,
        "user": user,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class UserDatum {
    UserDatum({
        this.id,
        this.phone,
        this.emailVerified,
        this.avatar,
        this.hasSubscription,
        this.googleId,
        this.facebookId,
        this.fcmId,
        this.passwordResetTokenExpiry,
        this.firstName,
        this.lastName,
        this.email,
        this.role,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.passwordResetToken,
    });

    String id;
    String phone;
    bool emailVerified;
    String avatar;
    bool hasSubscription;
    String googleId;
    String facebookId;
    String fcmId;
    dynamic passwordResetTokenExpiry;
    String firstName;
    String lastName;
    String email;
    int role;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    String passwordResetToken;

    factory UserDatum.fromJson(Map<String, dynamic> json) => UserDatum(
        id: json["_id"]!=null?json["_id"]:'',
        phone: json["phone"]!=null?json["phone"]:'',
        emailVerified: json["emailVerified"]!=null?json["emailVerified"]:false,
        avatar: json["avatar"]!=null?json["avatar"]:'',
        hasSubscription: json["hasSubscription"]!=null ? json["hasSubscription"]:false,
        googleId: json["googleId"]!=null?json["googleId"]:'',
        facebookId: json["facebookId"]!=null?json["facebookId"]:'',
        fcmId: json["fcmId"]!=null?json["fcmId"]:'',
        passwordResetTokenExpiry: json["passwordResetTokenExpiry"]!=null?json["passwordResetTokenExpiry"]:'',
        firstName: json["firstName"]!=null?json["firstName"]:'',
        lastName: json["lastName"]!=null?json["lastName"]:'',
        email: json["email"]!=null?json["email"]:'',
        role: json["role"]!=null?json["role"]:0,
        createdAt: json.containsKey('createdAt')? DateTime.parse(json["createdAt"]) : null,
        updatedAt: json.containsKey('updatedAt')? DateTime.parse(json["updatedAt"]) : null,
        v: json["__v"]!=null ?json["__v"]:0,
        passwordResetToken: json["passwordResetToken"]!=null?json["passwordResetToken"]:'',
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "phone": phone,
        "emailVerified": emailVerified,
        "avatar": avatar,
        "hasSubscription": hasSubscription,
        "googleId": googleId,
        "facebookId": facebookId,
        "fcmId": fcmId,
        "passwordResetTokenExpiry": passwordResetTokenExpiry,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "role": role,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "passwordResetToken": passwordResetToken,
    };
}
