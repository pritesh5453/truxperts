// models/subcategories_response.dart
import 'package:truxperts/Model_n_svc/categories/categories_model.dart';


class SubcategoriesResponse {
  final bool success;
  final List<Subcategory> data;
  final int total;

  SubcategoriesResponse({
    required this.success,
    required this.data,
    required this.total,
  });

  factory SubcategoriesResponse.fromJson(Map<String, dynamic> json) =>
      SubcategoriesResponse(
        success: json['success'] as bool,
        data: (json['data'] as List<dynamic>)
            .map((e) => Subcategory.fromJson(e as Map<String, dynamic>))
            .toList(),
        total: json['total'] as int,
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': data.map((e) => e.toJson()).toList(),
        'total': total,
      };
}