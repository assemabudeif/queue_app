import 'package:equatable/equatable.dart';

class SendAnswersRequest extends Equatable {
  final String answerText;
  final Question question;

  const SendAnswersRequest({
    required this.answerText,
    required this.question,
  });

  Map<String, dynamic> toJson() => {
        "answerText": answerText,
        "question": question.toJson(),
      };

  @override
  List<Object> get props => [answerText, question];
}

class Question extends Equatable {
  final int id;

  const Question({
    required this.id,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
      };

  @override
  List<Object> get props => [id];
}
