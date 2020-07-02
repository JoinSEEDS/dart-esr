import 'dart:typed_data';
import 'package:json_annotation/json_annotation.dart';

import 'package:dart_esr/eosdart/src/eosdart_base.dart';
import 'package:dart_esr/eosdart/src/serialize.dart' as ser;

part 'signing_request.g.dart';

@JsonSerializable(explicitToJson: true)
class SigningRequest {
  @JsonKey(name: 'chain_id')
  List<dynamic> chainId = [];

  @JsonKey(name: 'req')
  List<dynamic> req = [];

  @JsonKey(name: 'flags')
  int flags = 1;

  @JsonKey(name: 'callback')
  String callback = '';

  @JsonKey(name: 'info')
  List<dynamic> info = [];

  SigningRequest();

  factory SigningRequest.fromJson(Map<String, dynamic> json) =>
      _$SigningRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SigningRequestToJson(this);

  @override
  String toString() => this.toJson().toString();

  Uint8List toBinary(Type type) {
    var buffer = ser.SerialBuffer(Uint8List(0));
    type.serialize(type, buffer, this.toJson());
    return buffer.asUint8List();
  }

  factory SigningRequest.fromBinary(Type type, Uint8List data) {
    var buffer = ser.SerialBuffer(data);
    var deserializedData =
        Map<String, dynamic>.from(type.deserialize(type, buffer));
    return SigningRequest.fromJson(deserializedData);
  }
}