import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '/core/localization/language_manger.dart';

class DepartmentQuestionsModel extends Equatable {
  final List<DepartmentQuestionsDataModel> departmentQuestions;

  const DepartmentQuestionsModel({
    required this.departmentQuestions,
  });

  factory DepartmentQuestionsModel.fromJson(List<dynamic> json) =>
      DepartmentQuestionsModel(
        departmentQuestions: List<DepartmentQuestionsDataModel>.from(
          json.map(
            (x) => DepartmentQuestionsDataModel.fromJson(x),
          ),
        ),
      );

  @override
  List<Object> get props => [departmentQuestions];
}

class DepartmentQuestionsDataModel extends Equatable {
  final TextEditingController textEditingController = TextEditingController();
  final int id;
  final String questionText;

  DepartmentQuestionsDataModel({
    required this.id,
    required this.questionText,
  });

  factory DepartmentQuestionsDataModel.fromJson(Map<String, dynamic> json) =>
      DepartmentQuestionsDataModel(
        id: json["id"] ?? 0,
        questionText: getAppLanguageCode == 'ar'
            ? json['question_ar'] ?? ''
            : json["questionText"] ?? '',
      );

  @override
  List<Object> get props => [id, questionText];
}
