# if you create file name sample_model.dart
# you need to create part for it generate model.
# part 'sample_model.g.dart'; and then run command
# sh modelize.sh  // both of window and mac

part 'sample_model.g.dart';
@JsonSerializable()
class SampleModel extends Equatable {
  const SampleModel({
    this.primaryColorHex,
    this.fontFamily,
  });

  final String? primaryColorHex;
  final String? fontFamily;

  SampleModel copyWith({
    String? primaryColorHex, 
    String? fontFamily
    }) {
    return SampleModel(
      primaryColorHex: primaryColorHex ?? this.primaryColorHex,
      fontFamily: fontFamily ?? this.fontFamily,
    );
  }

  @override
  List<Object?> get props => [primaryColorHex, fontFamily];

  factory SampleModel.fromJson(Map<String, dynamic> json) =>
      _$SampleModelFromJson(json);

  Map<String, dynamic> toJson() => _$SampleModelToJson(this);
}
