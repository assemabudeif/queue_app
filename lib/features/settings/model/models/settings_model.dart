import 'package:equatable/equatable.dart';

class SettingsModel extends Equatable {
  final String title;
  final String icon;
  final Function onTap;
  final bool isSVG;

  const SettingsModel({
    required this.title,
    required this.icon,
    required this.onTap,
    this.isSVG = true,
  });

  @override
  List<Object?> get props => [title, icon, onTap, isSVG];
}
