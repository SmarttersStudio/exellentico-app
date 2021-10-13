import 'dart:convert';

RestError fitWalletResponseFromJson(String str) =>
    RestError.fromJson(json.decode(str));

String fitWalletResponseToJson(RestError data) => json.encode(data.toJson());

class RestError {
  String name;
  String message;
  int code;
  String className;
  bool result;

  RestError(
      {required this.name,
      required this.message,
      required this.code,
      required this.className,
      required this.result});

  factory RestError.fromJson(Map<String, dynamic> json) => RestError(
      name: json["name"] ?? '',
      message: json["message"] ?? '',
      code: json["code"] ?? 0,
      className: json["className"] ?? '',
      result: json['result'] ?? false);
  @override
  String toString() => message;

  Map<String, dynamic> toJson() => {
        "name": name,
        "message": message,
        "code": code,
        "className": className,
      };
}
