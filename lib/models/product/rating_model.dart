import 'package:equatable/equatable.dart';

class RatingModel extends Equatable {
  final num rate;
  final int count;

  const RatingModel({
    required this.rate,
    required this.count,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      rate: json['rate'] ?? 0,
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'count': count,
    };
  }

  factory RatingModel.empty() {
    return const RatingModel(
      rate: 0,
      count: 0,
    );
  }

  @override
  List<Object?> get props => [
        rate,
        count,
      ];
}
