///
///Created By Sunil Kumar at 06/05/2020
///
// To parse this JSON data, do
//
//     final reverseGeocoder = reverseGeocoderFromJson(jsonString);

import 'dart:convert';

ReverseGeoCoder reverseGeoCoderFromJson(String str) => ReverseGeoCoder.fromJson(json.decode(str));

String reverseGeoCoderToJson(ReverseGeoCoder data) => json.encode(data.toJson());

class ReverseGeoCoder {
    List<Result> results;

    ReverseGeoCoder({
        this.results,
    });

    factory ReverseGeoCoder.fromJson(Map<String, dynamic> json) => ReverseGeoCoder(
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Result {
    List<AddressComponent> addressComponents;
    String formattedAddress;

    Result({
        this.addressComponents,
        this.formattedAddress,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        addressComponents: List<AddressComponent>.from(json["address_components"].map((x) => AddressComponent.fromJson(x))),
        formattedAddress: json["formatted_address"],
    );

    Map<String, dynamic> toJson() => {
        "address_components": List<dynamic>.from(addressComponents.map((x) => x.toJson())),
        "formatted_address": formattedAddress,
    };
}

class AddressComponent {
    String longName;
    String shortName;
    List<String> types;

    AddressComponent({
        this.longName,
        this.shortName,
        this.types,
    });

    factory AddressComponent.fromJson(Map<String, dynamic> json) => AddressComponent(
        longName: json["long_name"],
        shortName: json["short_name"],
        types: List<String>.from(json["types"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "long_name": longName,
        "short_name": shortName,
        "types": List<dynamic>.from(types.map((x) => x)),
    };
}
