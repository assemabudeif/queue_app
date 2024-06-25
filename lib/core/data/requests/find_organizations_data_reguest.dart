import 'package:equatable/equatable.dart';

class FindOrganizationsDataRequest extends Equatable {
  final double latitude;
  final double longitude;

  const FindOrganizationsDataRequest({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [
        latitude,
        longitude,
      ];
}
