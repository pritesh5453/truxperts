class Address {
  final int? id;
  final int? customerId;
  final String addressType;
  final String houseNo;
  final String buildingArea;
  final String landmark;
  final String city;
  final String state;
  final String pincode;
  final String receiverName;
  final String receiverPhone;
  final String fullAddress;
  final double? latitude;
  final double? longitude;
  final int isDefault;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Address({
    this.id,
    this.customerId,
    required this.addressType,
    required this.houseNo,
    required this.buildingArea,
    required this.landmark,
    required this.city,
    required this.state,
    required this.pincode,
    required this.receiverName,
    required this.receiverPhone,
    required this.fullAddress,
    this.latitude,
    this.longitude,
    required this.isDefault,
    this.createdAt,
    this.updatedAt,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'] as int?,
      customerId: json['customer_id'] as int?,
      addressType: json['address_type'] as String? ?? '',
      houseNo: json['house_no'] as String? ?? '',
      buildingArea: json['building_area'] as String? ?? '',
      landmark: json['landmark'] as String? ?? '',
      city: json['city'] as String? ?? '',
      state: json['state'] as String? ?? '',
      pincode: json['pincode'] as String? ?? '',
      receiverName: json['receiver_name'] as String? ?? '',
      receiverPhone: json['receiver_phone'] as String? ?? '',
      fullAddress: json['full_address'] as String? ?? '',
      latitude: json['latitude'] != null ? double.tryParse(json['latitude'].toString()) : null,
      longitude: json['longitude'] != null ? double.tryParse(json['longitude'].toString()) : null,
      isDefault: json['is_default'] as int? ?? 0,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address_type': addressType,
      'house_no': houseNo,
      'building_area': buildingArea,
      'landmark': landmark,
      'city': city,
      'state': state,
      'pincode': pincode,
      'receiver_name': receiverName,
      'receiver_phone': receiverPhone,
      'latitude': latitude,
      'longitude': longitude,
      'is_default': isDefault,
    };
  }

  // CopyWith method for updates
  Address copyWith({
    int? id,
    int? customerId,
    String? addressType,
    String? houseNo,
    String? buildingArea,
    String? landmark,
    String? city,
    String? state,
    String? pincode,
    String? receiverName,
    String? receiverPhone,
    String? fullAddress,
    double? latitude,
    double? longitude,
    int? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Address(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      addressType: addressType ?? this.addressType,
      houseNo: houseNo ?? this.houseNo,
      buildingArea: buildingArea ?? this.buildingArea,
      landmark: landmark ?? this.landmark,
      city: city ?? this.city,
      state: state ?? this.state,
      pincode: pincode ?? this.pincode,
      receiverName: receiverName ?? this.receiverName,
      receiverPhone: receiverPhone ?? this.receiverPhone,
      fullAddress: fullAddress ?? this.fullAddress,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}