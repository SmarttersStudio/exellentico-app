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
        profile: json["profile"]!=null? Profile.fromJson(json["profile"]):null,
    );

    Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "profile": profile.toJson(),
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
        v: json["__v"],
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
        this.coordinates,
        this.fcmIds,
        this.googleId,
        this.facebookId,
        this.linkedinId,
        this.githubId,
        this.avatar,
        this.role,
        this.emailVerified,
        this.phoneVerified,
        this.passwordResetToken,
        this.passwordResetTokenExpiry,
        this.firstName,
        this.lastName,
        this.email,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.sub,
    });

    String id;
    List<dynamic> coordinates;
    List<dynamic> fcmIds;
    String googleId;
    String facebookId;
    String linkedinId;
    String githubId;
    String avatar;
    int role;
    bool emailVerified;
    bool phoneVerified;
    String passwordResetToken;
    dynamic passwordResetTokenExpiry;
    String firstName;
    String lastName;
    String email;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    String sub;

    factory UserDatum.fromJson(Map<String, dynamic> json) => UserDatum(
        id: json["_id"],
        coordinates: json["coordinates"]!=null ? List<dynamic>.from(json["coordinates"].map((x) => x)) : null,
        fcmIds: json["fcmIds"]!=null ? List<dynamic>.from(json["fcmIds"].map((x) => x)) :null,
        googleId: json["googleId"]!= null ? json["googleId"] : '',
        facebookId: json["facebookId"]!= null ? json["facebookId"] : '',
        linkedinId: json["linkedinId"]!= null ? json["linkedinId"] : '',
        githubId: json["githubId"]!= null ? json["githubId"] : '',
        avatar: json["avatar"]!= null ? json["avatar"] : '',
        role: json["role"]!=null ? json["role"] : 0,
        emailVerified: json["emailVerified"]!=null ? json["emailVerified"] : false,
        phoneVerified: json["phoneVerified"]!= null ? json["phoneVerified"] : false,
        passwordResetToken: json["passwordResetToken"]!=null ? json["passwordResetToken"] :"",
        passwordResetTokenExpiry: json["passwordResetTokenExpiry"]!= null ?json["passwordResetTokenExpiry"]:null,
        firstName: json["firstName"]!= null ? json["firstName"] : "",
        lastName: json["lastName"]!=null ? json["lastName"] : "",
        email: json["email"]!=null ? json["email"] : "",
        createdAt: json.containsKey('createdAt')? DateTime.parse(json["createdAt"]) : null,
        updatedAt:  json.containsKey('updatedAt')? DateTime.parse(json["updatedAt"]) : null,
        v: json["__v"],
        sub: json["sub"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
        "fcmIds": List<dynamic>.from(fcmIds.map((x) => x)),
        "googleId": googleId,
        "facebookId": facebookId,
        "linkedinId": linkedinId,
        "githubId": githubId,
        "avatar": avatar,
        "role": role,
        "emailVerified": emailVerified,
        "phoneVerified": phoneVerified,
        "passwordResetToken": passwordResetToken,
        "passwordResetTokenExpiry": passwordResetTokenExpiry,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "sub": sub,
    };
}
