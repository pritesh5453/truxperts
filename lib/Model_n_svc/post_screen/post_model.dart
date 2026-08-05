// models/post_screen/post_model.dart
import 'dart:convert';

// --------------------------------------------
// REQUEST MODEL – Instant Booking
// --------------------------------------------
class InstantBookingRequest {
  final String bookingType;
  final int categoryId;
  final String categoryName;
  final int subcategoryId;
  final String subcategoryName;
  final String description;
  final String budget;
  final String locationAddress;
  final String latitude;
  final String longitude;
  final String preferredDate;
  final String preferredTime;
  final String additionalNotes;
  final String paymentAmount;
  final String advanceAmount;
  final bool advancePaid;
  final int userId;

  InstantBookingRequest({
    required this.bookingType,
    required this.categoryId,
    required this.categoryName,
    required this.subcategoryId,
    required this.subcategoryName,
    required this.description,
    required this.budget,
    required this.locationAddress,
    required this.latitude,
    required this.longitude,
    required this.preferredDate,
    required this.preferredTime,
    required this.additionalNotes,
    required this.paymentAmount,
    required this.advanceAmount,
    required this.advancePaid,
    required this.userId,
  });

  Map<String, dynamic> toJson() => {
        'booking_type': bookingType,
        'category_id': categoryId,
        'category_name': categoryName,
        'subcategory_id': subcategoryId,
        'subcategory_name': subcategoryName,
        'description': description,
        'budget': budget,
        'location_address': locationAddress,
        'latitude': latitude,
        'longitude': longitude,
        'preferred_date': preferredDate,
        'preferred_time': preferredTime,
        'additional_notes': additionalNotes,
        'payment_amount': paymentAmount,
        'advance_amount': advanceAmount,
        'advance_paid': advancePaid,
        'user_id': userId,
      };
}

// --------------------------------------------
// RESPONSE MODEL – Instant Booking
// --------------------------------------------
class InstantBookingResponse {
  final bool success;
  final String message;
  final InstantBookingData? data;

  InstantBookingResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory InstantBookingResponse.fromJson(Map<String, dynamic> json) {
    return InstantBookingResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      data: json['data'] != null
          ? InstantBookingData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data?.toJson(),
      };
}

// --------------------------------------------
// DATA MODEL (nested)
// --------------------------------------------
class InstantBookingData {
  final int id;
  final String bookingType;
  final int categoryId;
  final String categoryName;
  final int subcategoryId;
  final String subcategoryName;
  final String description;
  final String budget;
  final List<String> images;
  final String locationAddress;
  final String latitude;
  final String longitude;
  final String preferredDate;
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
  final int advancePaid;
  final int userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? otpCode;
  final String? otpGeneratedAt;
  final int otpVerified;
  final String? otpVerifiedAt;
  final String? cancellationReason;
  final String? cancelledAt;
  final String? serviceStartedAt;
  final String? serviceCompletedAt;
  final int? markAsDoneByUserId;
  final String? markAsDoneAt;
  final String? serviceCompletedBy;
  final String paybleAmount;
  final int? paybleAmountAddedByVendorId;
  final String? paybleAmountAddedAt;
  final String paybleAmountStatus;
  final String? paymentDueDate;
  final String? paymentMethodDetails;
  final String? serviceRating;
  final String? serviceReview;
  final String markAsDoneStatus;
  final String? vendorPaybleAmountNotes;

  InstantBookingData({
    required this.id,
    required this.bookingType,
    required this.categoryId,
    required this.categoryName,
    required this.subcategoryId,
    required this.subcategoryName,
    required this.description,
    required this.budget,
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
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    this.otpCode,
    this.otpGeneratedAt,
    required this.otpVerified,
    this.otpVerifiedAt,
    this.cancellationReason,
    this.cancelledAt,
    this.serviceStartedAt,
    this.serviceCompletedAt,
    this.markAsDoneByUserId,
    this.markAsDoneAt,
    this.serviceCompletedBy,
    required this.paybleAmount,
    this.paybleAmountAddedByVendorId,
    this.paybleAmountAddedAt,
    required this.paybleAmountStatus,
    this.paymentDueDate,
    this.paymentMethodDetails,
    this.serviceRating,
    this.serviceReview,
    required this.markAsDoneStatus,
    this.vendorPaybleAmountNotes,
  });

  // Safe parsing helper
  static T? _safeCast<T>(dynamic value) {
    if (value == null) return null;
    if (T == String && value is! String) return value.toString() as T;
    if (T == int && value is! int) {
      if (value is String) return int.tryParse(value) as T?;
      return null;
    }
    if (T == double && value is! double) {
      if (value is String) return double.tryParse(value) as T?;
      return null;
    }
    if (T == bool && value is! bool) {
      if (value is int) return (value == 1) as T?;
      if (value is String) return (value.toLowerCase() == 'true') as T?;
      return null;
    }
    if (T == DateTime && value is! DateTime) {
      if (value is String) {
        try {
          return DateTime.parse(value) as T;
        } catch (_) {
          return null;
        }
      }
      return null;
    }
    if (value is T) return value;
    return null;
  }

  factory InstantBookingData.fromJson(Map<String, dynamic> json) {
    // Safely parse each field with default values
    return InstantBookingData(
      id: _safeCast<int>(json['id']) ?? 0,
      bookingType: _safeCast<String>(json['booking_type']) ?? '',
      categoryId: _safeCast<int>(json['category_id']) ?? 0,
      categoryName: _safeCast<String>(json['category_name']) ?? '',
      subcategoryId: _safeCast<int>(json['subcategory_id']) ?? 0,
      subcategoryName: _safeCast<String>(json['subcategory_name']) ?? '',
      description: _safeCast<String>(json['description']) ?? '',
      budget: _safeCast<String>(json['budget']) ?? '0',
      images: (json['images'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      locationAddress: _safeCast<String>(json['location_address']) ?? '',
      latitude: _safeCast<String>(json['latitude']) ?? '0.0',
      longitude: _safeCast<String>(json['longitude']) ?? '0.0',
      preferredDate: _safeCast<String>(json['preferred_date']) ?? '',
      preferredTime: _safeCast<String>(json['preferred_time']) ?? '',
      additionalNotes: _safeCast<String>(json['additional_notes']) ?? '',
      status: _safeCast<String>(json['status']) ?? 'pending',
      vendorId: _safeCast<int>(json['vendor_id']),
      vendorName: _safeCast<String>(json['vendor_name']),
      vendorPhone: _safeCast<String>(json['vendor_phone']),
      vendorOrganization: _safeCast<String>(json['vendor_organization']),
      paymentMethod: _safeCast<String>(json['payment_method']) ?? 'full',
      paymentAmount: _safeCast<String>(json['payment_amount']) ?? '0',
      dueAmount: _safeCast<String>(json['due_amount']) ?? '0',
      advanceAmount: _safeCast<String>(json['advance_amount']) ?? '0',
      advancePaid: _safeCast<int>(json['advance_paid']) ?? 0,
      userId: _safeCast<int>(json['user_id']) ?? 0,
      createdAt: _safeCast<DateTime>(json['created_at']) ?? DateTime.now(),
      updatedAt: _safeCast<DateTime>(json['updated_at']) ?? DateTime.now(),
      otpCode: _safeCast<String>(json['otp_code']),
      otpGeneratedAt: _safeCast<String>(json['otp_generated_at']),
      otpVerified: _safeCast<int>(json['otp_verified']) ?? 0,
      otpVerifiedAt: _safeCast<String>(json['otp_verified_at']),
      cancellationReason: _safeCast<String>(json['cancellation_reason']),
      cancelledAt: _safeCast<String>(json['cancelled_at']),
      serviceStartedAt: _safeCast<String>(json['service_started_at']),
      serviceCompletedAt: _safeCast<String>(json['service_completed_at']),
      markAsDoneByUserId: _safeCast<int>(json['mark_as_done_by_user_id']),
      markAsDoneAt: _safeCast<String>(json['mark_as_done_at']),
      serviceCompletedBy: _safeCast<String>(json['service_completed_by']),
      paybleAmount: _safeCast<String>(json['payble_amount']) ?? '0',
      paybleAmountAddedByVendorId: _safeCast<int>(json['payble_amount_added_by_vendor_id']),
      paybleAmountAddedAt: _safeCast<String>(json['payble_amount_added_at']),
      paybleAmountStatus: _safeCast<String>(json['payble_amount_status']) ?? 'pending',
      paymentDueDate: _safeCast<String>(json['payment_due_date']),
      paymentMethodDetails: _safeCast<String>(json['payment_method_details']),
      serviceRating: _safeCast<String>(json['service_rating']),
      serviceReview: _safeCast<String>(json['service_review']),
      markAsDoneStatus: _safeCast<String>(json['mark_as_done_status']) ?? 'pending',
      vendorPaybleAmountNotes: _safeCast<String>(json['vendor_payble_amount_notes']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'booking_type': bookingType,
        'category_id': categoryId,
        'category_name': categoryName,
        'subcategory_id': subcategoryId,
        'subcategory_name': subcategoryName,
        'description': description,
        'budget': budget,
        'images': images,
        'location_address': locationAddress,
        'latitude': latitude,
        'longitude': longitude,
        'preferred_date': preferredDate,
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
        'user_id': userId,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'otp_code': otpCode,
        'otp_generated_at': otpGeneratedAt,
        'otp_verified': otpVerified,
        'otp_verified_at': otpVerifiedAt,
        'cancellation_reason': cancellationReason,
        'cancelled_at': cancelledAt,
        'service_started_at': serviceStartedAt,
        'service_completed_at': serviceCompletedAt,
        'mark_as_done_by_user_id': markAsDoneByUserId,
        'mark_as_done_at': markAsDoneAt,
        'service_completed_by': serviceCompletedBy,
        'payble_amount': paybleAmount,
        'payble_amount_added_by_vendor_id': paybleAmountAddedByVendorId,
        'payble_amount_added_at': paybleAmountAddedAt,
        'payble_amount_status': paybleAmountStatus,
        'payment_due_date': paymentDueDate,
        'payment_method_details': paymentMethodDetails,
        'service_rating': serviceRating,
        'service_review': serviceReview,
        'mark_as_done_status': markAsDoneStatus,
        'vendor_payble_amount_notes': vendorPaybleAmountNotes,
      };
}