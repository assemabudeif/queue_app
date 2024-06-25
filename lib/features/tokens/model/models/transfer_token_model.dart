import 'package:equatable/equatable.dart';

class TransferTokenModel extends Equatable {
  final int transfared;
  final int receiverExist;

  const TransferTokenModel({
    required this.transfared,
    required this.receiverExist,
  });

  factory TransferTokenModel.fromJson(Map<String, dynamic> json) =>
      TransferTokenModel(
        transfared: json["transfared"] as int,
        receiverExist: json["receiver_exist"] as int,
      );

  @override
  List<Object> get props => [transfared, receiverExist];
}
