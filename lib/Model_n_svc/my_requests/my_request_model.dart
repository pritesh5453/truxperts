// models/instant_booking_models.dart

class InstantBookingResponse {
  final bool success;
  final String message;
  final int total;
  final int count;
  final Pagination pagination;
  final List<Booking> data;

  InstantBookingResponse({
    required this.success,
    required this.message,
    required this.total,
    required this.count,
    required this.pagination,
    required this.data,
  });

  factory InstantBookingResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List? ?? [];
    List<Booking> bookings =
        list.map((i) => Booking.fromJson(i as Map<String, dynamic>)).toList();

    return InstantBookingResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      total: json['total'] ?? 0,
      count: json['count'] ?? 0,
      pagination: Pagination.fromJson(json['pagination'] ?? {}),
      data: bookings,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'total': total,
      'count': count,
      'pagination': pagination.toJson(),
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class Pagination {
  final int total;
  final int limit;
  final int offset;
  final int currentPage;
  final int totalPages;

  Pagination({
    required this.total,
    required this.limit,
    required this.offset,
    required this.currentPage,
    required this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      total: json['total'] ?? 0,
      limit: json['limit'] ?? 0,
      offset: json['offset'] ?? 0,
      currentPage: json['currentPage'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'limit': limit,
      'offset': offset,
      'currentPage': currentPage,
      'totalPages': totalPages,
    };
  }
}

class Booking {
  final int id;
  final String bookingType;
  final int categoryId;
  final String categoryName;
  final String budget;
  final int subcategoryId;
  final String subcategoryName;
  final String description;
  final List<ImageItem> images;
  final String locationAddress;
  final String latitude;
  final String longitude;
  final DateTime preferredDate;
  final String preferredTime;
  final String additionalNotes;
  final String status;
  final int? vendorId;
  final String? vendorName;
  final String? vendorPhone;
  final String? vendorOrganization;
  final String paymentMethod;
  final String paymentAmount;
  final String dueAmount;
  final String advanceAmount;
  final bool advancePaid;
  final String? otpCode;
  final DateTime? otpGeneratedAt;
  final bool otpVerified;
  final int userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String categoryImage;

  Booking({
    required this.id,
    required this.bookingType,
    required this.categoryId,
    required this.categoryName,
    required this.budget,
    required this.subcategoryId,
    required this.subcategoryName,
    required this.description,
    required this.images,
    required this.locationAddress,
    required this.latitude,
    required this.longitude,
    required this.preferredDate,
    required this.preferredTime,
    required this.additionalNotes,
    required this.status,
    this.vendorId,
    this.vendorName,
    this.vendorPhone,
    this.vendorOrganization,
    required this.paymentMethod,
    required this.paymentAmount,
    required this.dueAmount,
    required this.advanceAmount,
    required this.advancePaid,
    this.otpCode,
    this.otpGeneratedAt,
    required this.otpVerified,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.categoryImage,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    List<ImageItem> images = [];
    if (json['images'] != null && json['images'] is List) {
      images = (json['images'] as List)
          .map((i) => ImageItem.fromJson(i as Map<String, dynamic>))
          .toList();
    }

    return Booking(
      id: json['id'] ?? 0,
      bookingType: json['booking_type'] ?? '',
      categoryId: json['category_id'] ?? 0,
      categoryName: json['category_name'] ?? '',
      budget: json['budget'] ?? '0.00',
      subcategoryId: json['subcategory_id'] ?? 0,
      subcategoryName: json['subcategory_name'] ?? '',
      description: json['description'] ?? '',
      images: images,
      locationAddress: json['location_address'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      preferredDate: json['preferred_date'] != null
          ? DateTime.parse(json['preferred_date'])
          : DateTime.now(),
      preferredTime: json['preferred_time'] ?? '',
      additionalNotes: json['additional_notes'] ?? '',
      status: json['status'] ?? '',
      vendorId: json['vendor_id'],
      vendorName: json['vendor_name'],
      vendorPhone: json['vendor_phone'],
      vendorOrganization: json['vendor_organization'],
      paymentMethod: json['payment_method'] ?? '',
      paymentAmount: json['payment_amount'] ?? '0.00',
      dueAmount: json['due_amount'] ?? '0.00',
      advanceAmount: json['advance_amount'] ?? '0.00',
      advancePaid: json['advance_paid'] ?? false,
      otpCode: json['otp_code'],
      otpGeneratedAt: json['otp_generated_at'] != null
          ? DateTime.parse(json['otp_generated_at'])
          : null,
      otpVerified: json['otp_verified'] ?? false,
      userId: json['user_id'] ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
      categoryImage: json['category_image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'booking_type': bookingType,
      'category_id': categoryId,
      'category_name': categoryName,
      'budget': budget,
      'subcategory_id': subcategoryId,
      'subcategory_name': subcategoryName,
      'description': description,
      'images': images.map((e) => e.toJson()).toList(),
      'location_address': locationAddress,
      'latitude': latitude,
      'longitude': longitude,
      'preferred_date': preferredDate.toIso8601String(),
      'preferred_time': preferredTime,
      'additional_notes': additionalNotes,
      'status': status,
      'vendor_id': vendorId,
      'vendor_name': vendorName,
      'vendor_phone': vendorPhone,
      'vendor_organization': vendorOrganization,
      'payment_method': paymentMethod,
      'payment_amount': paymentAmount,
      'due_amount': dueAmount,
      'advance_amount': advanceAmount,
      'advance_paid': advancePaid,
      'otp_code': otpCode,
      'otp_generated_at': otpGeneratedAt?.toIso8601String(),
      'otp_verified': otpVerified,
      'user_id': userId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'category_image': categoryImage,
    };
  }
}

class ImageItem {
  final String path;
  final int size;
  final String filename;
  final String mimetype;
  final String originalname;

  ImageItem({
    required this.path,
    required this.size,
    required this.filename,
    required this.mimetype,
    required this.originalname,
  });

  factory ImageItem.fromJson(Map<String, dynamic> json) {
    return ImageItem(
      path: json['path'] ?? '',
      size: json['size'] ?? 0,
      filename: json['filename'] ?? '',
      mimetype: json['mimetype'] ?? '',
      originalname: json['originalname'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'path': path,
      'size': size,
      'filename': filename,
      'mimetype': mimetype,
      'originalname': originalname,
    };
  }
}


// ========== Stats Response ==========
class StatsResponse {
  final bool success;
  final Map<String, dynamic> data;

  StatsResponse({required this.success, required this.data});

  factory StatsResponse.fromJson(Map<String, dynamic> json) {
    return StatsResponse(
      success: json['success'] ?? false,
      data: json['data'] ?? {},
    );
  }
}