import 'package:advisor_app/domain/entities/advice_entity.dart';

class AdviceModel extends AdviceEntity {
  AdviceModel({required super.advice, required super.id});

  factory AdviceModel.fromJson(Map<String, dynamic> json) {
    return AdviceModel(
      advice: json['advice'] as String,
      id: json['id'] as int,
    );
  }
}
