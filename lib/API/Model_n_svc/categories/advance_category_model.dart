// models/advance_category_model.dart
import 'package:flutter/material.dart';

class AdvanceSubcategory {
  final int id;
  final int categoryId;
  final String name;
  final String description;
  final String status;
  final String commissionType;
  final String commissionValue;
  final String minCommission;
  final String maxCommission;
  final int serviceCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  AdvanceSubcategory({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.status,
    required this.commissionType,
    required this.commissionValue,
    required this.minCommission,
    required this.maxCommission,
    required this.serviceCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AdvanceSubcategory.fromJson(Map<String, dynamic> json) =>
      AdvanceSubcategory(
        id: json['id'] as int,
        categoryId: json['category_id'] as int,
        name: json['name'] as String,
        description: json['description'] as String,
        status: json['status'] as String,
        commissionType: json['commission_type'] as String,
        commissionValue: json['commission_value'] as String,
        minCommission: json['min_commission'] as String,
        maxCommission: json['max_commission'] as String,
        serviceCount: json['service_count'] as int,
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'category_id': categoryId,
        'name': name,
        'description': description,
        'status': status,
        'commission_type': commissionType,
        'commission_value': commissionValue,
        'min_commission': minCommission,
        'max_commission': maxCommission,
        'service_count': serviceCount,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };
}

class AdvanceCategory {
  final int id;
  final String name;
  final String icon;
  final String iconColor;
  final String bgColor;
  final String description;
  final int featured;
  final String status;
  final String commissionType;
  final String commissionValue;
  final String minCommission;
  final String maxCommission;
  final int serviceCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int subcategoryCount;
  final int totalAdvanceSubcategories; // 👈 ye field alag hai
  final List<AdvanceSubcategory>? subcategories;

  AdvanceCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.description,
    required this.featured,
    required this.status,
    required this.commissionType,
    required this.commissionValue,
    required this.minCommission,
    required this.maxCommission,
    required this.serviceCount,
    required this.createdAt,
    required this.updatedAt,
    required this.subcategoryCount,
    required this.totalAdvanceSubcategories,
    this.subcategories,
  });

  // Clean icon (backslash → forward slash)
  String get cleanIcon => icon.replaceAll('\\', '/');

  // Clean color string (remove backslash and parse)
  Color get parsedIconColor => _parseColor(iconColor);
  Color get parsedBgColor => _parseColor(bgColor);

  Color _parseColor(String hex) {
    String clean = hex.trim().replaceAll('\\', '');
    if (clean.startsWith('#')) clean = clean.substring(1);
    if (clean.length == 6) clean = 'ff$clean';
    return Color(int.parse('0x$clean'));
  }

  factory AdvanceCategory.fromJson(Map<String, dynamic> json) => AdvanceCategory(
        id: json['id'] as int,
        name: json['name'] as String,
        icon: json['icon'] as String,
        iconColor: json['icon_color'] as String,
        bgColor: json['bg_color'] as String,
        description: json['description'] as String,
        featured: json['featured'] as int,
        status: json['status'] as String,
        commissionType: json['commission_type'] as String,
        commissionValue: json['commission_value'] as String,
        minCommission: json['min_commission'] as String,
        maxCommission: json['max_commission'] as String,
        serviceCount: json['service_count'] as int,
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
        subcategoryCount: json['subcategory_count'] as int,
        totalAdvanceSubcategories: json['total_advance_subcategories'] as int,
        subcategories: (json['subcategories'] as List<dynamic>?)
            ?.map((e) => AdvanceSubcategory.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'icon': icon,
        'icon_color': iconColor,
        'bg_color': bgColor,
        'description': description,
        'featured': featured,
        'status': status,
        'commission_type': commissionType,
        'commission_value': commissionValue,
        'min_commission': minCommission,
        'max_commission': maxCommission,
        'service_count': serviceCount,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'subcategory_count': subcategoryCount,
        'total_advance_subcategories': totalAdvanceSubcategories,
        'subcategories': subcategories?.map((e) => e.toJson()).toList(),
      };
}

class AdvanceCategoriesResponse {
  final bool success;
  final List<AdvanceCategory> data;
  final int total;

  AdvanceCategoriesResponse({
    required this.success,
    required this.data,
    required this.total,
  });

  factory AdvanceCategoriesResponse.fromJson(Map<String, dynamic> json) =>
      AdvanceCategoriesResponse(
        success: json['success'] as bool,
        data: (json['data'] as List<dynamic>)
            .map((e) => AdvanceCategory.fromJson(e as Map<String, dynamic>))
            .toList(),
        total: json['total'] as int,
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': data.map((e) => e.toJson()).toList(),
        'total': total,
      };
}