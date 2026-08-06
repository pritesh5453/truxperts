// models/tracking_model.dart

class InstantTrackingResponse {
  final bool success;
  final String message;
  final TrackingData data;

  InstantTrackingResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory InstantTrackingResponse.fromJson(Map<String, dynamic> json) {
    return InstantTrackingResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      data: TrackingData.fromJson(json['data'] as Map<String, dynamic>? ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data.toJson(),
  };
}

class TrackingData {
  final int requestId;
  final String requestNumber;
  final String status; // pending, assigned, in_progress, completed, OnTheWay etc.
  final JobSummary jobSummary;
  final List<TimelineItem> timeline;
  final RequestDetails requestDetails;
  final Actions actions;
  final ServiceOTP serviceOtp;
  final VendorInfo? vendor;
  final LiveLocation? liveLocation;

  TrackingData({
    required this.requestId,
    required this.requestNumber,
    required this.status,
    required this.jobSummary,
    required this.timeline,
    required this.requestDetails,
    required this.actions,
    required this.serviceOtp,
    this.vendor,
    this.liveLocation,
  });

  factory TrackingData.fromJson(Map<String, dynamic> json) {
    return TrackingData(
      requestId: json['request_id'] as int? ?? 0,
      requestNumber: json['request_number'] as String? ?? '',
      status: json['status'] as String? ?? '',
      jobSummary: JobSummary.fromJson(json['job_summary'] as Map<String, dynamic>? ?? {}),
      timeline: (json['timeline'] as List<dynamic>?)
          ?.map((e) => TimelineItem.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
      requestDetails: RequestDetails.fromJson(json['request_details'] as Map<String, dynamic>? ?? {}),
      actions: Actions.fromJson(json['actions'] as Map<String, dynamic>? ?? {}),
      serviceOtp: ServiceOTP.fromJson(json['service_otp'] as Map<String, dynamic>? ?? {}),
      vendor: json['vendor'] != null 
          ? VendorInfo.fromJson(json['vendor'] as Map<String, dynamic>)
          : null,
      liveLocation: json['live_location'] != null
          ? LiveLocation.fromJson(json['live_location'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'request_id': requestId,
    'request_number': requestNumber,
    'status': status,
    'job_summary': jobSummary.toJson(),
    'timeline': timeline.map((e) => e.toJson()).toList(),
    'request_details': requestDetails.toJson(),
    'actions': actions.toJson(),
    'service_otp': serviceOtp.toJson(),
    'vendor': vendor?.toJson(),
    'live_location': liveLocation?.toJson(),
  };
}

class JobSummary {
  final String title;
  final String description;
  final String category;
  final DateTime bookingDate;
  final String bookingTime;

  JobSummary({
    required this.title,
    required this.description,
    required this.category,
    required this.bookingDate,
    required this.bookingTime,
  });

  factory JobSummary.fromJson(Map<String, dynamic> json) {
    return JobSummary(
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? '',
      bookingDate: json['booking_date'] != null 
          ? DateTime.parse(json['booking_date'] as String) 
          : DateTime.now(),
      bookingTime: json['booking_time'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'category': category,
    'booking_date': bookingDate.toIso8601String(),
    'booking_time': bookingTime,
  };
}

class TimelineItem {
  final String title;
  final bool completed;
  final bool active;

  TimelineItem({
    required this.title,
    required this.completed,
    required this.active,
  });

  factory TimelineItem.fromJson(Map<String, dynamic> json) {
    return TimelineItem(
      title: json['title'] as String? ?? '',
      completed: json['completed'] as bool? ?? false,
      active: json['active'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'completed': completed,
    'active': active,
  };
}

class RequestDetails {
  final String bookingType;
  final String category;
  final String subcategory;
  final String description;
  final int budget;
  final List<ImageInfo> images;
  final String location;
  final double latitude;
  final double longitude;
  final String preferredTime;
  final String paymentMethod;
  final int paymentAmount;
  final int dueAmount;
  final int advanceAmount;
  final bool advancePaid;
  final String additionalNotes;

  RequestDetails({
    required this.bookingType,
    required this.category,
    required this.subcategory,
    required this.description,
    required this.budget,
    required this.images,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.preferredTime,
    required this.paymentMethod,
    required this.paymentAmount,
    required this.dueAmount,
    required this.advanceAmount,
    required this.advancePaid,
    required this.additionalNotes,
  });

  factory RequestDetails.fromJson(Map<String, dynamic> json) {
    return RequestDetails(
      bookingType: json['booking_type'] as String? ?? '',
      category: json['category'] as String? ?? '',
      subcategory: json['subcategory'] as String? ?? '',
      description: json['description'] as String? ?? '',
      budget: json['budget'] as int? ?? 0,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => ImageInfo.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
      location: json['location'] as String? ?? '',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      preferredTime: json['preferred_time'] as String? ?? '',
      paymentMethod: json['payment_method'] as String? ?? '',
      paymentAmount: json['payment_amount'] as int? ?? 0,
      dueAmount: json['due_amount'] as int? ?? 0,
      advanceAmount: json['advance_amount'] as int? ?? 0,
      advancePaid: json['advance_paid'] as bool? ?? false,
      additionalNotes: json['additional_notes'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'booking_type': bookingType,
    'category': category,
    'subcategory': subcategory,
    'description': description,
    'budget': budget,
    'images': images.map((e) => e.toJson()).toList(),
    'location': location,
    'latitude': latitude,
    'longitude': longitude,
    'preferred_time': preferredTime,
    'payment_method': paymentMethod,
    'payment_amount': paymentAmount,
    'due_amount': dueAmount,
    'advance_amount': advanceAmount,
    'advance_paid': advancePaid,
    'additional_notes': additionalNotes,
  };
}

class ImageInfo {
  final String path;
  final int size;
  final String filename;
  final String mimetype;
  final String originalname;

  ImageInfo({
    required this.path,
    required this.size,
    required this.filename,
    required this.mimetype,
    required this.originalname,
  });

  factory ImageInfo.fromJson(Map<String, dynamic> json) {
    return ImageInfo(
      path: json['path'] as String? ?? '',
      size: json['size'] as int? ?? 0,
      filename: json['filename'] as String? ?? '',
      mimetype: json['mimetype'] as String? ?? '',
      originalname: json['originalname'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'path': path,
    'size': size,
    'filename': filename,
    'mimetype': mimetype,
    'originalname': originalname,
  };
}

class Actions {
  final bool showVendor;
  final bool showServiceOtp;
  final bool showLiveLocation;
  final bool showCancelButton;
  final bool showMarkDoneButton;

  Actions({
    required this.showVendor,
    required this.showServiceOtp,
    required this.showLiveLocation,
    required this.showCancelButton,
    required this.showMarkDoneButton,
  });

  factory Actions.fromJson(Map<String, dynamic> json) {
    return Actions(
      showVendor: json['show_vendor'] as bool? ?? false,
      showServiceOtp: json['show_service_otp'] as bool? ?? false,
      showLiveLocation: json['show_live_location'] as bool? ?? false,
      showCancelButton: json['show_cancel_button'] as bool? ?? false,
      showMarkDoneButton: json['show_mark_done_button'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'show_vendor': showVendor,
    'show_service_otp': showServiceOtp,
    'show_live_location': showLiveLocation,
    'show_cancel_button': showCancelButton,
    'show_mark_done_button': showMarkDoneButton,
  };
}

class ServiceOTP {
  final String otp;
  final bool verified;

  ServiceOTP({
    required this.otp,
    required this.verified,
  });

  factory ServiceOTP.fromJson(Map<String, dynamic> json) {
    return ServiceOTP(
      otp: json['otp'] as String? ?? '',
      verified: json['verified'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'otp': otp,
    'verified': verified,
  };
}

class VendorInfo {
  final int id;
  final String name;
  final String businessName;
  final String profileImage;
  final bool verified;
  final int rating;
  final int reviews;
  final String mobile;
  final int? etaMinutes;
  final double? distanceKm;

  VendorInfo({
    required this.id,
    required this.name,
    required this.businessName,
    required this.profileImage,
    required this.verified,
    required this.rating,
    required this.reviews,
    required this.mobile,
    this.etaMinutes,
    this.distanceKm,
  });

  factory VendorInfo.fromJson(Map<String, dynamic> json) {
    return VendorInfo(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      businessName: json['business_name'] as String? ?? '',
      profileImage: json['profile_image'] as String? ?? '',
      verified: json['verified'] as bool? ?? false,
      rating: json['rating'] as int? ?? 0,
      reviews: json['reviews'] as int? ?? 0,
      mobile: json['mobile'] as String? ?? '',
      etaMinutes: json['eta_minutes'] as int?,
      distanceKm: (json['distance_km'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'business_name': businessName,
    'profile_image': profileImage,
    'verified': verified,
    'rating': rating,
    'reviews': reviews,
    'mobile': mobile,
    'eta_minutes': etaMinutes,
    'distance_km': distanceKm,
  };
}

class LiveLocation {
  final double vendorLatitude;
  final double vendorLongitude;
  final double customerLatitude;
  final double customerLongitude;

  LiveLocation({
    required this.vendorLatitude,
    required this.vendorLongitude,
    required this.customerLatitude,
    required this.customerLongitude,
  });

  factory LiveLocation.fromJson(Map<String, dynamic> json) {
    return LiveLocation(
      vendorLatitude: (json['vendor_latitude'] as num?)?.toDouble() ?? 0.0,
      vendorLongitude: (json['vendor_longitude'] as num?)?.toDouble() ?? 0.0,
      customerLatitude: (json['customer_latitude'] as num?)?.toDouble() ?? 0.0,
      customerLongitude: (json['customer_longitude'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
    'vendor_latitude': vendorLatitude,
    'vendor_longitude': vendorLongitude,
    'customer_latitude': customerLatitude,
    'customer_longitude': customerLongitude,
  };
}