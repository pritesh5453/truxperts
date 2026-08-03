// models/categories_model.dart

class Subcategory {
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

  Subcategory({
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

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
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

class Category {
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
  final int totalSubcategories;
  final List<Subcategory>? subcategories;

  Category({
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
    required this.totalSubcategories,
    this.subcategories,
  });

  // 🔥 Ye getter automatically backslash ko forward slash mein badal dega
  String get cleanIcon => icon.replaceAll('\\', '/');

  factory Category.fromJson(Map<String, dynamic> json) => Category(
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
        totalSubcategories: json['total_subcategories'] as int,
        subcategories: (json['subcategories'] as List<dynamic>?)
            ?.map((e) => Subcategory.fromJson(e as Map<String, dynamic>))
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
        'total_subcategories': totalSubcategories,
        'subcategories': subcategories?.map((e) => e.toJson()).toList(),
      };
}

class CategoriesResponse {
  final bool success;
  final List<Category> data;
  final int total;

  CategoriesResponse({
    required this.success,
    required this.data,
    required this.total,
  });

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) =>
      CategoriesResponse(
        success: json['success'] as bool,
        data: (json['data'] as List<dynamic>)
            .map((e) => Category.fromJson(e as Map<String, dynamic>))
            .toList(),
        total: json['total'] as int,
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': data.map((e) => e.toJson()).toList(),
        'total': total,
      };
}