import 'package:json_annotation/json_annotation.dart';
part 'login_response_dto.g.dart';

@JsonSerializable()
class LoginResponseDto {
  @JsonKey(name: "success")
  final bool success;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "token")
  final String? token;

  LoginResponseDto({
    required this.success,
    required this.message,
    required this.token,
  });

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) => _$LoginResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseDtoToJson(this);
}