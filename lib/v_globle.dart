import 'package:shared_value/shared_value.dart';

final SharedValue<String> accessToken = SharedValue(
  value: "",
  key: "access_token",
);