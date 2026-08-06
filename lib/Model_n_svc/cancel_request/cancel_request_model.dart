// models/cancel_booking_model.dart

class CancelBookingRequest {
  final int userId;
  final String cancellationReason;

  CancelBookingRequest({
    required this.userId,
    required this.cancellationReason,
  });

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'cancellation_reason': cancellationReason,
  };
}